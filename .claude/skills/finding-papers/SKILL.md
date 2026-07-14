---
name: finding-papers
description: Search academic literature, manage the search queue, download papers, and verify sources. Use when the user wants to find papers, when working search-queue.md, or when adding references.
---

# Finding Papers

## Which search tool to use

- **Built-in make commands for academic papers.** They query dedicated databases (200M+ papers) and return structured results — citation counts, DOIs, years, BibTeX. Always try these first for paper discovery.
- **Web search for everything else** — a researcher's lab page, whether a tool exists, non-academic facts. Don't substitute web search for the make commands: it returns blog posts and news mixed with papers.
- **If a make command fails,** fall back to web search, tell the user what happened, and suggest `make check` or `./setup.sh`.

## Commands

- `make search-py QUERY="topic"` — Semantic Scholar, human-readable results with citation counts and years (use this for presenting options to the user)
- `make search QUERY="topic"` — Semantic Scholar, BibTeX output (use this when appending an entry to references.bib)
- `make search-openalex QUERY="topic"` — OpenAlex (250M+ papers, alternative source)
- `make search-author AUTHOR="Jane Smith"` — papers by author, with h-index
- `make fetch-arxiv ID="2301.00001"` / `make fetch-doi DOI="10.1038/..."` — download to sources/
- `make add-paper DOI="..."` — add to papis library; `make bib` — regenerate references.bib
- `make verify DOI="..."` — check citation support/contradiction (scite)
- `make identify-doi PDF="sources/paper.pdf"` — find a DOI inside a PDF

## The search queue (search-queue.md)

The project's literature backlog: every paper still needed, in three tiers.

- **P0 — must have before drafting.** Positioning papers (closest neighbors to cite and differentiate from), core framing sources, evidence for the most vulnerable claims.
- **P1 — search while drafting**, when a section reveals a real gap.
- **P2 — only if needed later.** Don't search these until a draft demands it.

**Add to the queue** after outline changes, after a paper points somewhere worth following, when the user names a gap, or when a section draft's "Gaps" section reveals one. Always assign a tier.

**Work the queue** when the user says "find papers" (check the queue before asking what to search), and always P0 before P1 before P2:

1. Pick the highest-priority open search
2. Run it with `make search-py` or `make search-openalex` using the listed keywords
3. No good results → try alternative keywords or the other tool
4. Update the entry: results, status (`[x]` found, `[-]` failed + what was tried)
5. Move completed searches to "Sources Already Collected" (or archive.md)

**Good-enough-to-draft threshold:** the queue defines a gate — typically all positioning papers read plus one strong source per evidence-dependent section. Check it after each search batch. Don't let research become an excuse not to write.

## When the user asks for papers on a topic

1. `make search-py QUERY="the topic"`
2. Present readable results: title, year, citation count
3. Ask which to download; fetch with `make fetch-doi` / `make fetch-arxiv`
4. `make add-paper DOI="..."` to add to the library
5. **Automatically create a reading note** (see the reading-notes skill) — don't wait to be asked

## Adding a citation to the manuscript

1. Check `bibliography/references.bib` for the key
2. Missing → `make search QUERY="paper title"` and append the BibTeX, or `make add-paper DOI="..."` then `make bib`
3. Insert `[@key]` at the right place — keys must exist in references.bib or the PDF build breaks
