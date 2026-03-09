# ==============================================================================
# Academic Research Scaffold — CLI-first Makefile
#
# Usage: make <target>
# Run `make` or `make help` to see all available targets.
# ==============================================================================

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

MANUSCRIPT    = manuscript/main.md
BIB_FILE      = bibliography/references.bib
CSL_FILE      = bibliography/citation-style.csl
OUTPUT_DIR    = output
SOURCES_DIR   = sources
LIBRARY_DIR   = library
NOTES_DIR     = notes
PANDOC_FLAGS  = --filter pandoc-crossref --citeproc --bibliography=$(BIB_FILE) --csl=$(CSL_FILE) --pdf-engine=xelatex

# Default target
.DEFAULT_GOAL := help

# ==============================================================================
# DISCOVERY
# ==============================================================================

.PHONY: search
search: ## Search Semantic Scholar. Usage: make search QUERY="topic"
	@if [ -z "$(QUERY)" ]; then \
		echo "Error: QUERY is required. Usage: make search QUERY=\"topic\""; \
		exit 1; \
	fi
	semantic_bibtool "$(QUERY)"

.PHONY: search-py
search-py: ## Deeper search with citation counts. Usage: make search-py QUERY="topic"
	@if [ -z "$(QUERY)" ]; then \
		echo "Error: QUERY is required. Usage: make search-py QUERY=\"topic\""; \
		exit 1; \
	fi
	@python3 scripts/search-papers.py "$(QUERY)"

.PHONY: search-openalex
search-openalex: ## Search OpenAlex (250M+ papers). Usage: make search-openalex QUERY="topic"
	@if [ -z "$(QUERY)" ]; then \
		echo "Error: QUERY is required. Usage: make search-openalex QUERY=\"topic\""; \
		exit 1; \
	fi
	@python3 scripts/search-openalex.py "$(QUERY)"

.PHONY: search-author
search-author: ## Find papers by a specific author. Usage: make search-author AUTHOR="Jane Smith"
	@if [ -z "$(AUTHOR)" ]; then \
		echo "Error: AUTHOR is required. Usage: make search-author AUTHOR=\"Jane Smith\""; \
		exit 1; \
	fi
	@python3 scripts/search-author.py "$(AUTHOR)"

# ==============================================================================
# RETRIEVAL
# ==============================================================================

.PHONY: fetch-arxiv
fetch-arxiv: ## Download from arXiv. Usage: make fetch-arxiv ID="2301.00001"
	@if [ -z "$(ID)" ]; then \
		echo "Error: ID is required. Usage: make fetch-arxiv ID=\"2301.00001\""; \
		exit 1; \
	fi
	@mkdir -p $(SOURCES_DIR)
	@echo "Downloading arXiv paper $(ID) to $(SOURCES_DIR)/..."
	curl -sSL -o "$(SOURCES_DIR)/arxiv-$(ID).pdf" \
		"https://arxiv.org/pdf/$(ID).pdf"
	@echo "Saved to $(SOURCES_DIR)/arxiv-$(ID).pdf"

.PHONY: fetch-doi
fetch-doi: ## Download by DOI. Usage: make fetch-doi DOI="10.1234/example"
	@if [ -z "$(DOI)" ]; then \
		echo "Error: DOI is required. Usage: make fetch-doi DOI=\"10.1234/example\""; \
		exit 1; \
	fi
	@mkdir -p $(SOURCES_DIR)
	@echo "Resolving DOI $(DOI)..."
	curl -sSL -o "$(SOURCES_DIR)/doi-$$(echo '$(DOI)' | tr '/' '_').pdf" \
		-H "Accept: application/pdf" \
		"https://doi.org/$(DOI)"
	@echo "Saved to $(SOURCES_DIR)/"

# ==============================================================================
# PDF PROCESSING
# ==============================================================================

.PHONY: extract-text
extract-text: ## Extract text from single PDF. Usage: make extract-text PDF="sources/paper.pdf"
	@if [ -z "$(PDF)" ]; then \
		echo "Error: PDF is required. Usage: make extract-text PDF=\"sources/paper.pdf\""; \
		exit 1; \
	fi
	@if [ ! -f "$(PDF)" ]; then \
		echo "Error: File not found: $(PDF)"; \
		exit 1; \
	fi
	pdftotext "$(PDF)" -

.PHONY: extract-all
extract-all: ## Extract text from all PDFs in sources/
	@echo "Extracting text from all PDFs in $(SOURCES_DIR)/..."
	scripts/extract-all-text.sh

.PHONY: identify-doi
identify-doi: ## Extract DOI from PDF. Usage: make identify-doi PDF="sources/paper.pdf"
	@if [ -z "$(PDF)" ]; then \
		echo "Error: PDF is required. Usage: make identify-doi PDF=\"sources/paper.pdf\""; \
		exit 1; \
	fi
	@if [ ! -f "$(PDF)" ]; then \
		echo "Error: File not found: $(PDF)"; \
		exit 1; \
	fi
	@pdftotext "$(PDF)" - 2>/dev/null | grep -oiE '10\.[0-9]{4,9}/[^\s]+' | head -1 || \
		echo "No DOI found in $(PDF)"

# ==============================================================================
# CITATION VERIFICATION
# ==============================================================================

.PHONY: verify
verify: ## Check citation support/contradiction via scite-cli. Usage: make verify DOI="10.1234/example"
	@if [ -z "$(DOI)" ]; then \
		echo "Error: DOI is required. Usage: make verify DOI=\"10.1234/example\""; \
		exit 1; \
	fi
	scite-cli "$(DOI)"

# ==============================================================================
# REFERENCE MANAGEMENT
# ==============================================================================

.PHONY: add-paper
add-paper: ## Add paper to papis by DOI. Usage: make add-paper DOI="10.1234/example"
	@if [ -z "$(DOI)" ]; then \
		echo "Error: DOI is required. Usage: make add-paper DOI=\"10.1234/example\""; \
		exit 1; \
	fi
	papis add --from doi "$(DOI)"

.PHONY: add-pdf
add-pdf: ## Add local PDF to papis. Usage: make add-pdf PDF="path/to/file.pdf"
	@if [ -z "$(PDF)" ]; then \
		echo "Error: PDF is required. Usage: make add-pdf PDF=\"path/to/file.pdf\""; \
		exit 1; \
	fi
	@if [ ! -f "$(PDF)" ]; then \
		echo "Error: File not found: $(PDF)"; \
		exit 1; \
	fi
	papis add "$(PDF)"

.PHONY: bib
bib: ## Export full papis library to bibliography/references.bib
	@mkdir -p bibliography
	papis export --all --format bibtex > $(BIB_FILE)
	@echo "Exported references to $(BIB_FILE)"

.PHONY: list-refs
list-refs: ## List all references in papis library
	papis list

# ==============================================================================
# NOTE-TAKING
# ==============================================================================

.PHONY: new-note
new-note: ## Create reading note from template. Usage: make new-note TITLE="Paper Title"
	@if [ -z "$(TITLE)" ]; then \
		echo "Error: TITLE is required. Usage: make new-note TITLE=\"Paper Title\""; \
		exit 1; \
	fi
	@mkdir -p $(NOTES_DIR)
	$(eval SLUG := $(shell echo "$(TITLE)" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-'))
	$(eval NOTE_FILE := $(NOTES_DIR)/$(shell date +%Y-%m-%d)-$(SLUG).md)
	@if [ -f "$(NOTE_FILE)" ]; then \
		echo "Note already exists: $(NOTE_FILE)"; \
		exit 1; \
	fi
	@echo "---"                          >  $(NOTE_FILE)
	@echo "title: \"$(TITLE)\""          >> $(NOTE_FILE)
	@echo "date: $$(date +%Y-%m-%d)"     >> $(NOTE_FILE)
	@echo "tags: []"                      >> $(NOTE_FILE)
	@echo "doi: \"\""                     >> $(NOTE_FILE)
	@echo "---"                          >> $(NOTE_FILE)
	@echo ""                             >> $(NOTE_FILE)
	@echo "## Summary"                   >> $(NOTE_FILE)
	@echo ""                             >> $(NOTE_FILE)
	@echo "## Key Findings"              >> $(NOTE_FILE)
	@echo ""                             >> $(NOTE_FILE)
	@echo "## Methodology"               >> $(NOTE_FILE)
	@echo ""                             >> $(NOTE_FILE)
	@echo "## Relevance to This Work"    >> $(NOTE_FILE)
	@echo ""                             >> $(NOTE_FILE)
	@echo "## Questions & Follow-ups"    >> $(NOTE_FILE)
	@echo ""                             >> $(NOTE_FILE)
	@echo "## Quotes"                    >> $(NOTE_FILE)
	@echo ""                             >> $(NOTE_FILE)
	@echo "Created note: $(NOTE_FILE)"

.PHONY: search-notes
search-notes: ## Search notes. Usage: make search-notes QUERY="keyword"
	@if [ -z "$(QUERY)" ]; then \
		echo "Error: QUERY is required. Usage: make search-notes QUERY=\"keyword\""; \
		exit 1; \
	fi
	@echo "Searching notes for: $(QUERY)"
	@grep -rl "$(QUERY)" $(NOTES_DIR)/ 2>/dev/null || echo "No matches found."
	@echo ""
	@echo "--- Matching lines ---"
	@grep -rn "$(QUERY)" $(NOTES_DIR)/ 2>/dev/null || true

# ==============================================================================
# WRITING QUALITY
# ==============================================================================

.PHONY: lint
lint: ## Lint prose with Vale. Usage: make lint [FILE="manuscript/main.md"]
	@vale $(or $(FILE),$(MANUSCRIPT))

.PHONY: grammar
grammar: ## Check grammar with LanguageTool. Usage: make grammar [FILE="manuscript/main.md"]
	@languagetool $(or $(FILE),$(MANUSCRIPT))

.PHONY: readability
readability: ## Readability stats (Flesch-Kincaid, fog index). Usage: make readability [FILE="manuscript/main.md"]
	@style $(or $(FILE),$(MANUSCRIPT))

# ==============================================================================
# FIGURES
# ==============================================================================

.PHONY: figure
figure: ## Generate figure from Mermaid file. Usage: make figure SRC="figures/diagram.mmd"
	@if [ -z "$(SRC)" ]; then \
		echo "Error: SRC is required. Usage: make figure SRC=\"figures/diagram.mmd\""; \
		exit 1; \
	fi
	@if [ ! -f "$(SRC)" ]; then \
		echo "Error: File not found: $(SRC)"; \
		exit 1; \
	fi
	mmdc -i "$(SRC)" -o "$(SRC:.mmd=.png)" -b transparent
	@echo "Generated: $(SRC:.mmd=.png)"

.PHONY: figures
figures: ## Generate all Mermaid diagrams in figures/
	@for f in figures/*.mmd; do \
		if [ -f "$$f" ]; then \
			echo "Generating: $$f"; \
			mmdc -i "$$f" -o "$${f%.mmd}.png" -b transparent; \
		fi; \
	done
	@echo "Done."

.PHONY: plot
plot: ## Run a gnuplot script. Usage: make plot SRC="figures/chart.gp"
	@if [ -z "$(SRC)" ]; then \
		echo "Error: SRC is required. Usage: make plot SRC=\"figures/chart.gp\""; \
		exit 1; \
	fi
	gnuplot "$(SRC)"

# ==============================================================================
# WRITING & BUILDING
# ==============================================================================

.PHONY: pdf
pdf: ## Build manuscript to PDF via Pandoc
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(MANUSCRIPT) $(PANDOC_FLAGS) -o $(OUTPUT_DIR)/manuscript.pdf
	@echo "Built: $(OUTPUT_DIR)/manuscript.pdf"

.PHONY: docx
docx: ## Build manuscript to DOCX
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(MANUSCRIPT) $(PANDOC_FLAGS) -o $(OUTPUT_DIR)/manuscript.docx
	@echo "Built: $(OUTPUT_DIR)/manuscript.docx"

.PHONY: html
html: ## Build manuscript to HTML
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(MANUSCRIPT) $(PANDOC_FLAGS) --standalone -o $(OUTPUT_DIR)/manuscript.html
	@echo "Built: $(OUTPUT_DIR)/manuscript.html"

.PHONY: all
all: pdf docx html ## Build all formats (PDF, DOCX, HTML)

.PHONY: wordcount
wordcount: ## Count words in manuscript
	@if [ -f "$(MANUSCRIPT)" ]; then \
		wc -w $(MANUSCRIPT) | awk '{print $$1 " words in $(MANUSCRIPT)"}'; \
	else \
		echo "Manuscript not found: $(MANUSCRIPT)"; \
	fi

.PHONY: clean
clean: ## Remove output/ contents
	rm -rf $(OUTPUT_DIR)/*
	@echo "Cleaned $(OUTPUT_DIR)/"

# ==============================================================================
# VERSION COMPARISON
# ==============================================================================

.PHONY: diff
diff: ## Compare two manuscript versions (track-changes PDF). Usage: make diff OLD="v1.md" NEW="v2.md"
	@if [ -z "$(OLD)" ] || [ -z "$(NEW)" ]; then \
		echo "Error: OLD and NEW required. Usage: make diff OLD=\"v1.md\" NEW=\"v2.md\""; \
		exit 1; \
	fi
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(OLD) -o /tmp/scaffold-old.tex
	pandoc $(NEW) -o /tmp/scaffold-new.tex
	latexdiff /tmp/scaffold-old.tex /tmp/scaffold-new.tex > /tmp/scaffold-diff.tex
	pdflatex -output-directory=$(OUTPUT_DIR) /tmp/scaffold-diff.tex
	@echo "Built: $(OUTPUT_DIR)/scaffold-diff.pdf"

# ==============================================================================
# UTILITIES
# ==============================================================================

.PHONY: setup
setup: ## Run initial project setup
	./setup.sh

.PHONY: check
check: ## Validate environment and dependencies
	scripts/validate-env.sh

.PHONY: help
help: ## Show this help message
	@echo ""
	@echo "Academic Research Scaffold"
	@echo "========================="
	@echo ""
	@echo "Usage: make <target> [VARIABLE=\"value\"]"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"} \
		/^[a-zA-Z_-]+:.*##/ { \
			printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2 \
		}' $(MAKEFILE_LIST)
	@echo ""
