# Submission Checklist

<!-- Copy this into the project root as submission-checklist.md when the
     manuscript is nearing completion. Work through it top to bottom before
     every submission (and again before every resubmission). Each item here
     exists because skipping it cost a real revision cycle on a past paper. -->

## Integrity — nothing invented

- [ ] **Every example, quote, and number in the manuscript traces to a real source.** For each worked example or data excerpt, open the actual file (`notes/`, `data/`, `cache/`, `sources/`) and confirm the text matches verbatim. LLM-drafted prose invents plausible-looking examples — check every one.
- [ ] **Bibliography verified against the published record:** `make verify-bib`. Fix every ✗; manually check every ? and ⚠ (author name variants, workshop papers, books).
- [ ] **Every `[@key]` in the manuscript resolves** — build the PDF and search the output for "??" and unresolved citations.
- [ ] **Reported statistics match the analysis output.** Re-run or re-open the analysis and compare every number in tables and prose against it. No transcription from memory.

## Claims discipline

- [ ] **Soften overclaims.** Search the manuscript for "prove", "demonstrate", "show that", "trace", "establish" — downgrade to "suggest", "indicate", "are consistent with" wherever the evidence is correlational or ablation-based.
- [ ] **Title and abstract match the actual scope.** If the evidence covers one domain, the title shouldn't imply all domains.
- [ ] **Limitations section covers the vulnerabilities a hostile reviewer would raise first.** Write their review for them, then answer it in the paper.

## Consistency

- [ ] **Terminology is uniform** — one name per concept throughout (pick "summary" or "abstractive summary", not both interchangeably).
- [ ] **Repeated phrases varied** — search for your favorite sentence patterns; reviewers notice.
- [ ] **Numbers agree everywhere** — abstract, intro, tables, and conclusion must report identical figures.

## Figures and formatting

- [ ] **Figures readable at print size.** Build the PDF and view at 100% — check title overlap, legend size, axis labels. Do not trust the on-screen figure preview.
- [ ] **Figure captions self-contained** — a reader skimming only figures should follow the argument.
- [ ] **Author metadata correct** — name, email, affiliation in the YAML frontmatter (easy to leave as template defaults).
- [ ] **Venue formatting requirements met** — page limit, anonymization, citation style, required sections.

## Repo and reproducibility (empirical papers)

- [ ] **Code availability statement present** and the linked repo is public/accessible.
- [ ] **README rewritten for the paper** — replace scaffold boilerplate with: key finding, repo structure, reproduction steps, dataset table.
- [ ] **Reproduction actually works** — fresh clone, follow the README, confirm scripts run (or document exactly what keys/data are needed).

## Final pass

- [ ] `make lint`, `make grammar`, `make readability` — fix or consciously waive each finding.
- [ ] **Build with the real engine** (`make pdf`, tectonic/xelatex — not an HTML-to-PDF fallback) and read the entire PDF once, slowly, on paper or full-screen.
- [ ] **Update `progress.md` and `decisions.md`** — record the submission (venue, date, version) and any scope decisions made during polish.
- [ ] **Save a snapshot and tag it** (`git tag submitted-<venue>-<date>`) so the submitted version is always recoverable.
