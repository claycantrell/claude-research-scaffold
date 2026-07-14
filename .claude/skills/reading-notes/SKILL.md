---
name: reading-notes
description: Extract text from papers, summarize them, and create reading notes. Use when reading or summarizing a paper, and automatically after downloading one.
---

# Reading Notes

Reading notes are objective (what does the paper say?) — create them automatically, no approval needed. One note per paper in `notes/`.

## When the user asks you to read or summarize a paper

1. `make extract-text PDF="sources/filename.pdf"` to get the text
2. Read it and provide your own summary
3. **Always create a reading note automatically.** File name: `YYYY-MM-DD-authorlastname-year---short-title.md` (e.g., `2026-03-08-smith-2024---cognitive-offloading.md`)
4. YAML frontmatter:
   ```
   ---
   title: "Author Year - Short Title"
   date: YYYY-MM-DD
   tags: [relevant, topic, tags]
   doi: "10.xxxx/..."
   ---
   ```
5. Fill every section of `templates/note.md`: Summary, Key Findings, Methodology, Relevance to This Work, Questions & Follow-ups, plus one key quote the user can paste into the manuscript
6. Tell the user: "I've saved a reading note in `notes/`."
7. Mark the corresponding search-queue entry done
8. Check whether enough related notes have accumulated to propose a section draft (see the drafting skill)

## Commands

- `make extract-text PDF="sources/paper.pdf"` — extract one PDF
- `make extract-all` — extract every PDF in sources/
- `make new-note TITLE="Paper Title"` — create a note from the template
- `make search-notes QUERY="keyword"` — search across all notes

## Precision requirements

Notes feed section drafts, and drafts must trace every claim to its source in under 30 seconds. Capture in the note:

- **Direct quotes** with page or section: `"exact words" (p. 12)`
- **Specific numbers**: not "large sample" but "N=217", "d=0.43"
- **Where things live**: "Table 2, p. 8", "Discussion section"
