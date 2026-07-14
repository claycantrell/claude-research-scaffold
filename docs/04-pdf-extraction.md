# Extracting Text from PDFs

Tools for converting PDFs into plain text for reading, searching, and processing.

---

## pdftotext (poppler)

Fast, simple text extraction. Handles most single-column academic papers well.

### Install

**macOS:**
```bash
brew install poppler
```

**Linux:**
```bash
sudo apt install poppler-utils
```

### Examples

```bash
# Extract to stdout
pdftotext sources/paper.pdf -

# Extract to a .txt file (same name, different extension)
pdftotext sources/paper.pdf sources/paper.txt

# Extract a specific page range (pages 3-7)
pdftotext -f 3 -l 7 sources/paper.pdf -

# Preserve layout (useful for tables)
pdftotext -layout sources/paper.pdf sources/paper.txt

# Extract and search for a term
pdftotext sources/paper.pdf - | grep -i "cognitive load"
```

### Makefile shortcuts

```bash
# Extract text from a single PDF (prints to stdout)
make extract-text PDF="sources/paper.pdf"

# Extract text from all PDFs in sources/
make extract-all
```

`make extract-text` runs `pdftotext` on the given PDF and streams output to stdout. `make extract-all` runs the `scripts/extract-all-text.sh` script, which processes every PDF in `sources/` and writes corresponding `.txt` files alongside them.

### How it connects

- Extracted text is useful for full-text search across your source papers.
- The `make identify-doi` target uses `pdftotext` internally to find DOIs embedded in PDFs.
- Plain text output can be piped into other tools or pasted into reading notes.

---

## When pdftotext struggles

Two-column conference papers (ACM/IEEE style) can come out with mangled column order. Two fixes before reaching for heavier tooling:

- `pdftotext -layout sources/paper.pdf -` preserves the physical layout, which often reads better for two-column text
- Claude can usually reconstruct the reading order from mangled output anyway — extraction quality matters less when the reader is a model

If a PDF is truly hostile (scanned images, complex tables), say so — OCR or manual transcription of the relevant table beats fighting the extractor.
