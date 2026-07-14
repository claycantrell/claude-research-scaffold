# Downloading Papers

Getting PDFs into `sources/`. All retrieval runs through make targets — no extra tools to install.

---

## Fetch from arXiv

```bash
make fetch-arxiv ID="2301.00001"
```

Downloads the PDF to `sources/arxiv-2301.00001.pdf` using `curl` against the arXiv PDF endpoint, creating `sources/` if needed. Works for any paper with an arXiv ID — which covers most CS/ML papers, including many later published at conferences.

### How it connects

- Downloaded PDFs land in `sources/`, ready for text extraction (`make extract-text`) or import into papis (`make add-pdf`).
- After downloading, run `make identify-doi PDF="sources/arxiv-2301.00001.pdf"` to extract the DOI for citation tracking.

---

## Fetch by DOI

```bash
make fetch-doi DOI="10.1038/s41586-020-2649-2"
```

Resolves the DOI with an `Accept: application/pdf` header and saves to `sources/doi-<doi>.pdf` (slashes become underscores).

**This only works for open-access papers.** Most publishers serve a paywalled landing page instead of a PDF; the target detects this, deletes the non-PDF download, and says so. When that happens, try in order:

1. **A preprint version** — search the title on arXiv, then `make fetch-arxiv`
2. **The author's website** — many authors self-archive accepted manuscripts
3. **Institutional library access** — download manually and drop the file in `sources/`

However you obtain the PDF, register it afterwards: `make add-pdf PDF="sources/file.pdf"` or `make add-paper DOI="..."` for full metadata.

---

## Find the DOI in a PDF you already have

```bash
make identify-doi PDF="sources/paper.pdf"
```

Extracts text with `pdftotext` and greps for a DOI pattern; returns the first match or reports none found.

### How it connects

- Once you have the DOI, `make add-paper DOI="..."` pulls full metadata into the papis library.
- The DOI also feeds `make verify DOI="..."` (citation support/contradiction) and `make verify-bib` (bibliography checking).
