---
name: drafting
description: Create writing plans, section drafts, and manuscript prose. Use when drafting or editing any part of the paper, building evidence chains from notes, or planning the writing.
---

# Drafting

The research workflow:

```
outline  →  search queue  →  notes  →  writing plan  →  drafts  →  manuscript
```

Reading notes capture what each paper says. Section drafts capture what the papers **mean together** for the user's argument. Notes are automatic; **drafts require user approval** — they contain the user's intellectual contribution.

## Proposing a section draft

**When:** 2+ reading notes relate to the same outline section; the user discusses how sources connect; a clear evidence chain forms across notes.

**How:**
1. Talk it through first — propose the evidence chain, let the user react and redirect
2. **Ask explicitly:** "Want me to save this as a working draft in `drafts/`?" Do NOT create the file before yes
3. Read `outline.md` for the section's argumentative job, and the relevant notes
4. Create `drafts/section-<number>-<slug>.md` from `templates/section-draft.md`:
   - **Argument** — what the section argues, how it advances the thesis (2–3 sentences)
   - **Evidence bridge** — numbered logical chain connecting sources to the argument. The most valuable part: it captures *reasoning*, not just references
   - **Gaps** — missing evidence → add to search-queue.md
   - **Draft prose** — rough paragraphs with `[@key]` citations
   - **Sources used** — table mapping each paper to its contribution

**Cite evidence precisely — the user must find any claim's source in under 30 seconds:**
- Direct quotes with page/section: `"exact words from the paper" (Smith 2024, p. 12)`
- Paraphrases name the location: `Smith et al. found X (Table 2, p. 8)`
- Real numbers, pulled from the paper: "N=217", "d=0.43" — never "a large sample"
- Key claims get quote + key: `"TUS significantly enhanced positive mood" [@sanguinetti2020, p. 5]`

## The writing plan (drafts/writing-plan.md)

Create once the outline is stable, before drafting begins, from `templates/writing-plan.md`. It is the bridge between "what are we arguing?" (outline) and the prose (drafts) — instructions for drafting, not the draft:

- **Word budgets** per section and total (prevents sprawl, respects venue limits)
- **Paragraph-level jobs**: "P1: establish the problem. P2: historical precedent. P3: why AI is different."
- **Section jobs** — the one question each section answers, with boundary notes for adjacent sections that could blur
- **Discipline notes** — sprawl, over-hedging, and other section-specific risks
- **Throughline map** — where the paper's central spine should surface
- **Key citations needed** — mapped to the search queue

Update it when sections are added, budgets shift, or feedback changes a section's job. Consult it before drafting any section.

## Writing and editing the manuscript

1. Read `manuscript/main.md` and `outline.md` first
2. Edit `manuscript/main.md` directly; `[@key]` syntax, keys must exist in references.bib
3. **Never invent examples, quotes, or numbers** — copy them from real project files (see CLAUDE.md, this rule is absolute)
4. After significant edits, offer to rebuild: `make pdf`

## Conventions

- Pandoc Markdown with YAML frontmatter
- Citations: `[@smith2024]`, `[@smith2024, p. 42]`, `[see @smith2024; @jones2023]`
- APA 7th by default (`bibliography/citation-style.csl` — swappable)
- Reference keys: authorYear (`walker2017`)
- `make wordcount` — check against the writing plan's budgets
