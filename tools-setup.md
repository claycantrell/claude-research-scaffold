# Research Tools Setup

CLI-based tools that integrate with this repo for finding and managing citable sources.

## 1. Semantic Scholar — `semantic_bibtool`

Converts paper titles to formatted BibTeX entries using the Semantic Scholar API (200M+ papers).

### Install
```bash
pip install semantic_bibtool
```

### API Key (free)
Request at: https://www.semanticscholar.org/product/api#Partner-Form
```bash
export SEMANTIC_SCHOLAR_API_KEY="your-key-here"
```

### Usage
```bash
# Single paper by title
semantic_bibtool "attention is all you need"

# Multiple titles from a file (one per line)
semantic_bibtool sources/titles.txt -o bibliography/references.bib

# Include paper URLs
semantic_bibtool "cognitive enhancement and AI" --add-url -o bibliography/references.bib
```

### Python Library (for deeper searches)
```bash
pip install semanticscholar
```
```python
from semanticscholar import SemanticScholar
sch = SemanticScholar()
results = sch.search_paper("nootropics cognitive performance")
for paper in results[:5]:
    print(paper.title, paper.year, paper.citationCount)
```

---

## 2. Scite — `scite-cli`

Checks whether papers have been supported or contradicted by subsequent research (1.6B+ citations).

### Install
```bash
git clone https://github.com/OpenDevEd/scite-cli.git /tmp/scite-cli
cd /tmp/scite-cli && npm run setup
```

### API Key
```bash
scite-cli config set access-token
```

### Usage
```bash
# Look up a paper by DOI
scite-cli papers 10.1038/s41586-020-2649-2

# Multiple papers
scite-cli papers 10.1002/bin.1697 10.1002/best.202271004
```

---

## 3. Papis — CLI Reference & Bibliography Manager

Stores all references as plain YAML + PDFs on your filesystem. Fully git-trackable, no GUI needed.

### Install
```bash
pip install papis
```

### Initial Config
```bash
papis config --set dir ~/Documents/GitHub/cognitive-augmentation-ai-era/library
```
This tells papis to store its library inside this repo.

### Usage
```bash
# Add a paper by DOI
papis add --from doi 10.1038/s41586-020-2649-2

# Add a local PDF
papis add path/to/paper.pdf --set author "Smith, J." --set title "Cognitive Enhancement" --set year 2024

# Search your library
papis list
papis list --query "nootropics"

# Open a paper's PDF
papis open "cognitive enhancement"

# Edit metadata in your $EDITOR
papis edit "smith 2024"

# Export entire library to BibTeX
papis export --all --format bibtex > bibliography/references.bib

# Export a single entry
papis export --format bibtex "attention is all you need"
```

### How It Stores Data
Each source gets its own folder with plain-text metadata:
```
library/
├── smith-2024-cognitive-enhancement/
│   ├── info.yaml    ← metadata (title, authors, DOI, year, etc.)
│   └── paper.pdf    ← the actual paper
├── vaswani-2017-attention/
│   ├── info.yaml
│   └── paper.pdf
```

Everything is plain text + files — perfect for git version control.

---

## Workflow

1. **Find sources** — Use `semantic_bibtool` or the Python `semanticscholar` library to search by topic/title
2. **Verify sources** — Use `scite-cli` to check if a paper's findings have been supported or contradicted
3. **Store in library** — Use `papis add` to save papers with metadata into `library/`
4. **Export bibliography** — Run `papis export --all --format bibtex > bibliography/references.bib`
5. **Commit** — `git add . && git commit -m "Add new sources on [topic]"`
