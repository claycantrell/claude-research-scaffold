# Understanding Papers

Tools for reading and verifying academic papers.

## Reading and Summarizing Papers

Claude can read and summarize papers directly -- no separate summarization tool is needed. Extract the text from a PDF and Claude will analyze it:

```bash
make extract-text PDF="sources/paper.pdf"
```

Claude reads the extracted text and can provide summaries, identify key findings, assess methodology, and answer questions about the paper. This is more flexible and accurate than a standalone summarization tool since you can ask follow-up questions and get tailored analysis.

---

## scite-cli

Check whether a paper's findings have been supported or contradicted by subsequent research (1.6B+ citation statements).

### Install

Clone and set up from GitHub (Node.js required):

```bash
git clone https://github.com/OpenDevEd/scite-cli.git /tmp/scite-cli
cd /tmp/scite-cli && npm run setup
```

The `setup.sh` script in this repo handles this automatically (installs to `~/.local/share/scite-cli`).

### API Key

Configure your scite access token:

```bash
scite-cli config set access-token
```

### Examples

```bash
# Look up citation context for a paper
scite-cli papers 10.1038/s41586-020-2649-2

# Check multiple papers at once
scite-cli papers 10.1002/bin.1697 10.1002/best.202271004

# Get tallies (supporting, contradicting, mentioning)
scite-cli tallies 10.1038/s41586-020-2649-2
```

### Makefile shortcut

```bash
make verify DOI="10.1038/s41586-020-2649-2"
```

Runs `scite-cli` with the given DOI and displays the citation context.

### How it connects

- Run before citing a paper to confirm its findings are well-supported.
- Pair with `make identify-doi` to extract the DOI from a PDF, then pipe it into `make verify`.
- Results inform your Discussion section and help strengthen your manuscript's argumentation.
