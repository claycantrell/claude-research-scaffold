# Reading Notes

One note per paper, in the project-local `notes/` directory. Notes are the raw material for section drafts — see `.claude/skills/reading-notes` for how Claude creates them automatically after downloading a paper.

---

## The note template

`templates/note.md` defines the structure:

```markdown
---
title: "{{PAPER_TITLE}}"
date: {{DATE}}
tags: []
doi: ""
---

## Summary

## Key Findings
-

## Methodology
-

## Relevance to This Work

## Key Quotes
>

## Questions & Follow-ups
-

## References to Chase
-
```

Every section earns its keep:

- **Key Quotes** with page numbers are what make drafts traceable later — capture exact wording while the paper is open.
- **Relevance to This Work** is the bridge to the argument; a note without it is a summary, not a research note.
- **References to Chase** feeds the search queue (`search-queue.md`).

## Creating a note

```bash
make new-note TITLE="Attention Is All You Need"
```

Creates `notes/2026-03-08-attention-is-all-you-need.md` from the template (via `scripts/new-note.sh` — the template file is the single source of truth for the format).

## Searching notes

```bash
make search-notes QUERY="cognitive load"
```

Greps every note and prints matching files and lines. For a paper-writing project's scale (dozens of notes), plain text search is fast and sufficient.

## How it connects

- Notes reference papers by DOI and `[@citation-key]`, tying them back to `bibliography/references.bib`.
- 2+ notes touching the same outline section → time to propose a section draft (see `.claude/skills/drafting`).
- The "References to Chase" section feeds the next round of searches.
