---
name: building-the-paper
description: Build the manuscript to PDF/DOCX/HTML, create figures and diagrams, manage cross-references, and run writing-quality checks (lint, grammar, readability).
---

# Building the Paper

## Building

1. `make bib` first, so the bibliography is current
2. `make pdf` (or `make docx`, `make html`, `make all`)
3. Report the output location (`output/manuscript.pdf` etc.)

The PDF engine prefers **tectonic** (self-contained, downloads LaTeX packages on demand), falling back to xelatex. Override: `make pdf PDF_ENGINE=xelatex`. An unresolved `[@key]` citation breaks the PDF build — check the build log for "citation ... not found".

- `make wordcount` — words in the manuscript
- `make clean` — remove generated output
- `make diff OLD="manuscript/draft-v1.md" NEW="manuscript/main.md"` — track-changes PDF between versions

## Figures and diagrams

1. Ask what kind: flowchart/sequence → Mermaid; data plot → gnuplot
2. Diagrams: write `figures/name.mmd`, then `make figure SRC="figures/name.mmd"` (`make figures` builds all)
3. Plots: write `figures/name.gp`, then `make plot SRC="figures/name.gp"`
4. Add to manuscript: `![Caption](figures/name.png){#fig:label}`, reference with `@fig:label`
5. **Check figures in the built PDF at print size** — titles overlap and legends shrink in ways the source preview hides

## Cross-references (pandoc-crossref auto-numbers on build)

- Figures: `![Caption](path.png){#fig:label}` → `@fig:label`
- Tables: `Table: Caption {#tbl:label}` → `@tbl:label`
- Equations: `$$ ... $$ {#eq:label}` → `@eq:label`
- Sections: `# Section {#sec:label}` → `@sec:label`

## Writing quality

1. `make lint` — prose style via Vale (passive voice, jargon, weasel words, hedging)
2. `make grammar` — grammar/spelling via LanguageTool (optional tool, not installed by default — skip gracefully if missing)
3. `make readability` — Flesch-Kincaid grade, fog index, sentence complexity
4. Summarize plainly: "3 style issues, 2 grammar issues; reading level grade 14 — appropriate for journals"
5. Offer to fix issues directly in the manuscript

All three accept `FILE="path"` to check one file.
