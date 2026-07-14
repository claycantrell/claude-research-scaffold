# End-to-End Research Workflow

A step-by-step walkthrough of a complete research project using this scaffold, from question to submission. Claude drives all of this in conversation — this doc shows what happens underneath.

---

## 1. Define your research question

Edit `outline.md`: working title, research question, thesis statement, section structure, target venue and length. Everything downstream flows from this file.

## 2. Build the search queue

For each outline section, identify the evidence it needs and add prioritized entries to `search-queue.md`:

- **P0** — blocks drafting: literature-positioning papers, core framing, evidence for vulnerable claims
- **P1** — search while drafting, when a section reveals a gap
- **P2** — only if a draft demands it

The queue defines a **good-enough-to-draft threshold** so research can't become an excuse not to write.

## 3. Search for papers

```bash
make search-py QUERY="cognitive enhancement tools"     # human-readable, citation counts
make search QUERY="..."                                # BibTeX output for references.bib
make search-openalex QUERY="..."                       # alternative index (250M+ works)
make search-author AUTHOR="Jane Smith"                 # everything by one author
```

Update the queue entry with what was found (or what was tried, if nothing was).

## 4. Download and catalog

```bash
make fetch-arxiv ID="2301.00001"                # arXiv PDFs (covers most CS/ML)
make fetch-doi DOI="10.1038/s41586-020-2649-2"  # open-access only; fails honestly on paywalls
make add-paper DOI="..."                        # register in papis with full metadata
make bib                                        # regenerate bibliography/references.bib
```

## 5. Extract and read

```bash
make extract-text PDF="sources/paper.pdf"   # one paper
make extract-all                            # everything in sources/
```

Claude reads the extracted text and summarizes directly — no separate summarization tool.

## 6. Take reading notes

One note per paper in `notes/`, created automatically when Claude downloads or summarizes a source:

```bash
make new-note TITLE="Cognitive Enhancement in the Age of AI"
make search-notes QUERY="working memory"
```

Notes capture exact quotes with page numbers and specific data points — the raw material that makes drafts traceable.

## 7. Plan the writing

Once the outline is stable, create `drafts/writing-plan.md`: word budgets per section, the argumentative job of each paragraph, discipline notes, and the paper's throughline. This is the bridge between "what are we arguing?" and the prose.

## 8. Draft sections

When 2+ notes speak to the same section, discuss how the papers connect, agree on the evidence chain, and save a section draft in `drafts/` — argument, numbered evidence bridge, gaps, rough prose with `[@key]` citations. **Drafts capture your reasoning and require your approval; notes are automatic.**

## 9. Write the manuscript

Polish section drafts into `manuscript/main.md`:

```markdown
Cognitive load theory [@sweller1988] provides a framework for understanding
how AI tools might reduce extraneous processing demands [@smith2024; @jones2023].
```

## 10. Build

```bash
make pdf         # via tectonic (self-contained LaTeX; installed by setup.sh)
make docx        # for journals that want Word
make html        # for sharing
make wordcount   # against the writing plan's budgets
```

## 11. Check quality

```bash
make lint          # Vale: passive voice, hedging, weasel words
make readability   # grade level, fog index
make grammar       # LanguageTool (optional install)
make figures       # rebuild diagrams; check them in the built PDF at print size
```

## 12. Iterate

Writing reveals gaps → new queue entries → search → notes → drafts → manuscript. Claude keeps `progress.md`, `decisions.md`, and `search-queue.md` current as the loop runs, so any future session picks up exactly where this one stopped.

## 13. Submit

Copy `templates/submission-checklist.md` to the project root and work through it:

```bash
make verify-bib                                 # every references.bib entry checked against Crossref/arXiv
make verify DOI="..."                           # citation support/contradiction (optional; needs scite.ai)
make diff OLD="submitted-v1.md" NEW="manuscript/main.md"   # track-changes PDF for revisions
```

Then tag the snapshot (`git tag submitted-<venue>-<date>`) and record the submission in `progress.md`.

---

## Quick reference

| Stage | Command | Docs |
|---|---|---|
| Search | `make search-py QUERY="..."` | [01-discovery.md](01-discovery.md) |
| Download | `make fetch-arxiv ID="..."` / `make fetch-doi DOI="..."` | [02-retrieval.md](02-retrieval.md) |
| Add to library | `make add-paper DOI="..."` | [05-reference-management.md](05-reference-management.md) |
| Extract text | `make extract-text PDF="..."` | [04-pdf-extraction.md](04-pdf-extraction.md) |
| New note | `make new-note TITLE="..."` | [06-note-taking.md](06-note-taking.md) |
| Build bib | `make bib` | [05-reference-management.md](05-reference-management.md) |
| Verify bibliography | `make verify-bib` | [03-summarization.md](03-summarization.md) |
| Verify one source | `make verify DOI="..."` (optional) | [03-summarization.md](03-summarization.md) |
| Compile | `make pdf` / `make all` | [07-writing-and-publishing.md](07-writing-and-publishing.md) |
| Quality | `make lint` / `make readability` | [08-writing-quality.md](08-writing-quality.md) |
| Figures | `make figure SRC="..."` / `make plot SRC="..."` | [09-figures-and-diagrams.md](09-figures-and-diagrams.md) |
| Track changes | `make diff OLD="..." NEW="..."` | [10-revision-and-review.md](10-revision-and-review.md) |

## Directory map

```
.
├── outline.md               ← research plan: thesis, sections, venue
├── search-queue.md          ← prioritized literature backlog (P0/P1/P2)
├── progress.md              ← what's done, where we left off
├── decisions.md             ← choices made, with the why
├── archive.md               ← retired entries from the three files above
├── manuscript/main.md       ← the paper (write here)
├── drafts/                  ← section drafts + writing-plan.md
├── notes/                   ← reading notes, one per paper
├── sources/                 ← downloaded PDFs
├── library/                 ← papis reference library (YAML + PDF)
├── bibliography/
│   ├── references.bib       ← auto-generated by `make bib`
│   └── citation-style.csl   ← swappable CSL style (APA 7th default)
├── figures/                 ← Mermaid/gnuplot sources + rendered images
├── output/                  ← compiled PDF/DOCX/HTML (generated)
├── scratch/                 ← brainstorming (git-ignored)
├── data/, cache/            ← (empirical projects) datasets + API caches (git-ignored)
├── templates/               ← note, section-draft, search-queue, writing-plan,
│                              submission-checklist, peer-review-response
├── scripts/                 ← helper scripts (search, verify-bib, batch ops)
├── docs/                    ← these tool docs
├── .claude/skills/          ← Claude's on-demand playbooks per workflow stage
├── Makefile                 ← all commands (`make help`)
└── setup.sh                 ← one-command installer
```
