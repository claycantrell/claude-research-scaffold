# Downloading Papers

Tools for getting PDFs onto your local filesystem.

---

## arxiv-dl

Download papers from arXiv by URL or paper ID.

### Install

```bash
pip install arxiv-dl
```

No API key required.

### Examples

```bash
# Download by arXiv ID
arxiv-dl 2301.00001 -d sources/

# Download by full URL
arxiv-dl https://arxiv.org/abs/2301.00001 -d sources/

# Download multiple papers
arxiv-dl 2301.00001 2302.12345 2303.67890 -d sources/
```

### Makefile shortcut

```bash
make fetch-arxiv ID="2301.00001"
```

Downloads the PDF to `sources/arxiv-2301.00001.pdf` using `curl` against the arXiv PDF endpoint. The Makefile target creates the `sources/` directory automatically if it does not exist.

### How it connects

- Downloaded PDFs land in `sources/`, ready for text extraction (`make extract-text`) or import into papis (`make add-pdf`).
- After downloading, run `make identify-doi PDF="sources/arxiv-2301.00001.pdf"` to extract the DOI for citation tracking.

---

## doi2pdf

Download any paper by its DOI. Resolves the DOI and attempts to retrieve the PDF.

### Install

```bash
pip install doi2pdf
```

No API key required (uses DOI resolution and open-access endpoints).

### Examples

```bash
# Download by DOI
doi2pdf 10.1038/s41586-020-2649-2 -o sources/

# Specify a custom filename
doi2pdf 10.1145/3411764.3445243 -o sources/chi2021-paper.pdf

# Pipe the DOI from another command
echo "10.1038/s41586-020-2649-2" | xargs doi2pdf -o sources/
```

### Makefile shortcut

```bash
make fetch-doi DOI="10.1038/s41586-020-2649-2"
```

Uses `curl` with an `Accept: application/pdf` header to resolve the DOI and save the PDF to `sources/doi-10.1038_s41586-020-2649-2.pdf` (slashes replaced with underscores).

### How it connects

- Same as `arxiv-dl`: PDFs land in `sources/` for extraction or library import.
- Use the DOI directly with `make add-paper DOI="..."` to register the paper in your papis library with full metadata.

---

## pdf2doi

Extract the DOI embedded in a PDF you already have on disk.

### Install

```bash
pip install pdf2doi
```

No API key required.

### Examples

```bash
# Extract DOI from a single PDF
pdf2doi sources/paper.pdf

# Process all PDFs in a directory
pdf2doi sources/

# Output in BibTeX format
pdf2doi sources/paper.pdf -b
```

### Makefile shortcut

```bash
make identify-doi PDF="sources/paper.pdf"
```

Extracts text from the PDF with `pdftotext` and searches for a DOI pattern using `grep`. Returns the first match or reports that no DOI was found.

### How it connects

- Once you have the DOI, use it with `make add-paper DOI="..."` to pull full metadata into your papis library.
- Also useful for verifying citations: pipe the DOI into `make verify DOI="..."` to check support/contradiction via scite.
