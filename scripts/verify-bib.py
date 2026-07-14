#!/usr/bin/env python3
"""Verify every entry in a BibTeX file against the published record.

For each entry, looks the paper up (by DOI on Crossref, by arXiv ID on
arXiv, or by title search on Crossref as a fallback) and compares:

  - author family names (missing or extra authors)
  - year
  - title (normalized similarity)

Usage:
    python3 scripts/verify-bib.py bibliography/references.bib

Exit code is non-zero if any entry mismatches, so it can gate a build.
Uses only the Python standard library. Be patient: one network request
per entry, throttled to stay polite to the APIs.
"""

import json
import re
import sys
import time
import unicodedata
import urllib.parse
import urllib.request
from difflib import SequenceMatcher

USER_AGENT = "research-scaffold-verify-bib/1.0 (https://github.com/claycantrell/claude-research-scaffold)"
REQUEST_GAP_SECONDS = 1.0
TITLE_MATCH_THRESHOLD = 0.85


# ── BibTeX parsing ────────────────────────────────────────────────────────────

def parse_bib(text):
    """Parse BibTeX entries into dicts. Handles nested braces in field values."""
    entries = []
    for match in re.finditer(r"@(\w+)\s*\{\s*([^,\s]+)\s*,", text):
        entry_type = match.group(1).lower()
        if entry_type in ("comment", "preamble", "string"):
            continue
        key = match.group(2)
        # Walk braces from the opening { of the entry to find its end
        start = text.index("{", match.start())
        depth, i = 0, start
        while i < len(text):
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
                if depth == 0:
                    break
            i += 1
        body = text[start + 1 : i]
        fields = {}
        for fmatch in re.finditer(
            r"(\w+)\s*=\s*(\{(?:[^{}]|\{[^{}]*\})*\}|\"[^\"]*\"|[^,\n]+)", body
        ):
            name = fmatch.group(1).lower()
            value = fmatch.group(2).strip().strip("{}").strip('"')
            fields[name] = re.sub(r"\s+", " ", value).strip()
        entries.append({"type": entry_type, "key": key, "fields": fields})
    return entries


# ── Normalization ─────────────────────────────────────────────────────────────

def strip_accents(s):
    return "".join(
        c for c in unicodedata.normalize("NFKD", s) if not unicodedata.combining(c)
    )


def norm_title(s):
    s = re.sub(r"[{}\\$]", "", s)
    s = strip_accents(s).lower()
    return re.sub(r"[^a-z0-9]+", " ", s).strip()


def norm_name(s):
    """Lowercase, drop accents and LaTeX residue, keep letters only."""
    return re.sub(r"[^a-z]", "", strip_accents(s).lower())


def bib_authors(author_field):
    """Extract (family, given) name pairs from a BibTeX author field, normalized."""
    authors = []
    for part in re.split(r"\s+and\s+", author_field):
        part = re.sub(r"[{}\\]", "", part).strip()
        if not part or part.lower() == "others":
            continue
        if "," in part:
            family, _, given = part.partition(",")
        else:
            words = part.split()
            family, given = words[-1], " ".join(words[:-1])
        family, given = norm_name(family), norm_name(given.split()[0] if given.split() else "")
        if family:
            authors.append((family, given))
    return authors


def given_names_conflict(a, b):
    """True if two given names can't be the same person (Luyu vs Larry).

    Initials and prefixes are compatible: 'l' matches 'luyu', 'chris' matches
    'christopher'. Only flag when both are substantial and neither prefixes
    the other.
    """
    if not a or not b:
        return False
    if a.startswith(b) or b.startswith(a):
        return False
    return True


def bib_family_names(author_field):
    return [family for family, _ in bib_authors(author_field)]


# ── Lookups ───────────────────────────────────────────────────────────────────

def http_get(url):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=30) as resp:
        return resp.read().decode("utf-8", errors="replace")


def crossref_by_doi(doi):
    data = json.loads(http_get(f"https://api.crossref.org/works/{urllib.parse.quote(doi)}"))
    return crossref_record(data["message"])


def crossref_by_title(title, first_author=None):
    clean = re.sub(r"[{}\\]", "", title)
    url = f"https://api.crossref.org/works?query.bibliographic={urllib.parse.quote(clean)}&rows=5"
    if first_author:
        url += f"&query.author={urllib.parse.quote(first_author)}"
    data = json.loads(http_get(url))
    best, best_score = None, 0.0
    for item in data["message"].get("items", []):
        cand = crossref_record(item)
        if not cand["title"]:
            continue
        score = SequenceMatcher(None, norm_title(title), norm_title(cand["title"])).ratio()
        if score > best_score:
            best, best_score = cand, score
    if best and best_score >= TITLE_MATCH_THRESHOLD:
        return best
    return None


def crossref_record(msg):
    # A paper can legitimately carry several years (online vs print);
    # collect them all and accept a bib year that matches any.
    years = set()
    for field in ("published-print", "published-online", "issued", "created"):
        parts = msg.get(field, {}).get("date-parts", [[None]])
        if parts and parts[0] and parts[0][0]:
            years.add(int(parts[0][0]))
    return {
        "source": "Crossref",
        "title": (msg.get("title") or [""])[0],
        "authors": [
            (norm_name(a["family"]), norm_name((a.get("given") or "").split()[0] if (a.get("given") or "").split() else ""))
            for a in msg.get("author", [])
            if a.get("family")
        ],
        "years": years,
        "doi": msg.get("DOI"),
    }


def arxiv_by_id(arxiv_id):
    xml = http_get(
        f"https://export.arxiv.org/api/query?id_list={urllib.parse.quote(arxiv_id)}"
    )
    return arxiv_parse_first_entry(xml)


def arxiv_by_title(title):
    clean = re.sub(r"[{}\\]", "", title)
    query = urllib.parse.quote(f'ti:"{clean}"')
    xml = http_get(
        f"https://export.arxiv.org/api/query?search_query={query}&max_results=3"
    )
    record = arxiv_parse_first_entry(xml)
    if record and (
        SequenceMatcher(None, norm_title(title), norm_title(record["title"])).ratio()
        >= TITLE_MATCH_THRESHOLD
    ):
        return record
    return None


def arxiv_parse_first_entry(xml):
    entry = re.search(r"<entry>(.*?)</entry>", xml, re.S)
    if not entry:
        return None
    body = entry.group(1)
    title = re.search(r"<title>(.*?)</title>", body, re.S)
    authors = re.findall(r"<name>(.*?)</name>", body)
    published = re.search(r"<published>(\d{4})", body)
    if not title:
        return None
    return {
        "source": "arXiv",
        "title": re.sub(r"\s+", " ", title.group(1)).strip(),
        "authors": [
            (norm_name(a.split()[-1]), norm_name(a.split()[0]) if len(a.split()) > 1 else "")
            for a in authors
            if a.split()
        ],
        "years": {int(published.group(1))} if published else set(),
        "doi": None,
    }


def lookup(fields):
    doi = fields.get("doi")
    if doi:
        try:
            return crossref_by_doi(doi)
        except Exception:
            pass
    eprint = fields.get("eprint")
    if eprint and "arxiv" in fields.get("archiveprefix", "arxiv").lower():
        try:
            return arxiv_by_id(eprint)
        except Exception:
            pass
    # Some entries put an arXiv URL in the url/howpublished field
    url = fields.get("url", "") + " " + fields.get("howpublished", "")
    arxiv_match = re.search(r"arxiv\.org/(?:abs|pdf)/([\w.\-/]+?)(?:v\d+)?(?:\.pdf)?(?:\s|$)", url)
    if arxiv_match:
        try:
            return arxiv_by_id(arxiv_match.group(1))
        except Exception:
            pass
    title = fields.get("title")
    if title:
        # Use the raw (un-normalized) first family name for the query —
        # Crossref matches "Pang-Naylor", not "pangnaylor"
        first = re.split(r"\s+and\s+", fields.get("author", ""))[0]
        raw_family = first.split(",")[0].strip() if "," in first else (first.split()[-1] if first.split() else "")
        raw_family = re.sub(r"[{}\\]", "", raw_family)
        for author in (raw_family or None, None):
            try:
                record = crossref_by_title(title, first_author=author)
            except Exception:
                record = None
            if record:
                return record
        # ML conference papers (ICLR, NeurIPS via OpenReview) are often
        # absent from Crossref but present on arXiv
        try:
            return arxiv_by_title(title)
        except Exception:
            pass
    return None


# ── Comparison ────────────────────────────────────────────────────────────────

def check_entry(entry, record):
    problems, warnings = [], []
    fields = entry["fields"]

    bib_title = fields.get("title", "")
    if bib_title and record["title"]:
        sim = SequenceMatcher(None, norm_title(bib_title), norm_title(record["title"])).ratio()
        if sim < TITLE_MATCH_THRESHOLD:
            problems.append(f'title differs from {record["source"]}: "{record["title"]}"')

    bib_year = re.search(r"\d{4}", fields.get("year", "") or "")
    if bib_year and record["years"] and int(bib_year.group()) not in record["years"]:
        known = "/".join(str(y) for y in sorted(record["years"]))
        problems.append(f'year is {bib_year.group()}, {record["source"]} says {known}')

    entry_authors = bib_authors(fields.get("author", ""))
    truncated = "others" in fields.get("author", "").lower()
    if entry_authors and record["authors"]:
        bib_families = [f for f, _ in entry_authors]
        rec_families = [f for f, _ in record["authors"]]
        missing = [f for f in rec_families if f not in bib_families]
        extra = [f for f in bib_families if f not in rec_families]
        if missing and not truncated:
            problems.append(f'missing authors: {", ".join(missing)}')
        if extra:
            problems.append(f'authors not on record: {", ".join(extra)}')
        # A paper can have two authors with the same family name (both Chens
        # on Dense X Retrieval) — only warn when NO same-family record author
        # has a compatible given name. Nicknames (Nick/Nicholas) make this
        # fuzzy, so given-name conflicts are warnings, not failures.
        for family, given in entry_authors:
            same_family = [g for f, g in record["authors"] if f == family]
            if same_family and all(given_names_conflict(given, g) for g in same_family):
                warnings.append(
                    f'given name for {family}: bib says "{given}", '
                    f'record says "{" or ".join(same_family)}"'
                )

    return problems, warnings


def main():
    bib_path = sys.argv[1] if len(sys.argv) > 1 else "bibliography/references.bib"
    try:
        with open(bib_path) as f:
            entries = parse_bib(f.read())
    except FileNotFoundError:
        print(f"No bibliography file at {bib_path}")
        return 1
    if not entries:
        print(f"No entries found in {bib_path}")
        return 0

    print(f"Verifying {len(entries)} entries in {bib_path}...\n")
    mismatched, unverified = [], []
    for i, entry in enumerate(entries):
        if i:
            time.sleep(REQUEST_GAP_SECONDS)
        record = lookup(entry["fields"])
        if record is None:
            unverified.append(entry["key"])
            print(f"  ?  {entry['key']}: could not find on Crossref/arXiv — verify by hand")
            continue
        problems, warnings = check_entry(entry, record)
        if problems:
            mismatched.append(entry["key"])
            print(f"  ✗  {entry['key']} ({record['source']}):")
            for p in problems:
                print(f"       - {p}")
        else:
            print(f"  ✓  {entry['key']} ({record['source']})")
        for w in warnings:
            print(f"       ⚠ {w}")

    print(
        f"\n{len(entries) - len(mismatched) - len(unverified)} verified, "
        f"{len(mismatched)} mismatched, {len(unverified)} not found."
    )
    if mismatched:
        print("Fix the mismatched entries against the published record before submitting.")
    if unverified:
        print("Entries marked '?' need manual verification (books, web pages, workshop papers).")
    return 1 if mismatched else 0


if __name__ == "__main__":
    sys.exit(main())
