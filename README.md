# Research Scaffold

**A ready-made project folder for academic research, powered by Claude Code.**

You talk to an AI assistant in plain English. It finds papers, downloads them, organizes your sources, manages citations, writes with you, and produces a finished document. You focus on the ideas — Claude handles the tedium.

Everything here is **free** and runs on your computer. Your research stays yours.

---

## What Is This?

Think of it as a **pre-organized filing cabinet for a research project** — except it comes with a built-in research assistant (Claude Code) that can:

- **Find papers** — "Find me recent papers about cognitive enhancement"
- **Download them** — "Download that first one"
- **Summarize them** — "What does this paper argue?"
- **Verify them** — "Has this paper's findings been contradicted?"
- **Organize your sources** — "Add this to my library"
- **Take notes** — "Create a reading note for this paper"
- **Write with you** — "Draft an introduction based on my outline"
- **Cite properly** — "Cite Smith 2024 in that paragraph"
- **Produce finished documents** — "Build my paper as a PDF"

You don't need to memorize commands or learn software. You just talk to Claude.

---

## Getting Started

### What You'll Need

1. **A Mac or Linux computer** (Windows users can use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install))
2. **VS Code** (free) — download from [code.visualstudio.com](https://code.visualstudio.com/). This is your workspace where you'll see your files and talk to Claude side by side.
3. **Claude Code** — Anthropic's AI assistant. Install it:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
   (You'll need [Node.js](https://nodejs.org/) installed first. If you don't have it, download it from that link.)
4. **A GitHub account** (free) — sign up at [github.com](https://github.com) if you don't have one

### Setup (5 minutes)

```bash
# 1. Get your own copy of this project
gh repo fork claycantrell/research-scaffold --clone
cd research-scaffold

# 2. Install the research tools
./setup.sh

# 3. Open the project in VS Code
code .
```

When VS Code opens, it will suggest installing a few helpful extensions (Claude Code, Markdown preview, PDF viewer, spell checker). **Click "Install All"** — these make the experience much better.

### Your Workspace

Once VS Code is open with the extensions installed, here's what you'll see:

```
┌─────────────────────────────────────────────────────────┐
│  FILE TREE (left)    │  YOUR DOCUMENT (center)          │
│                      │                                   │
│  > manuscript/       │  # Introduction                   │
│  > sources/          │                                   │
│  > notes/            │  Studies have shown that sleep     │
│  > bibliography/     │  deprivation impacts memory        │
│  > library/          │  consolidation [@walker2017]...    │
│    outline.md        │                                   │
│                      │                                   │
│                      ├───────────────────────────────────│
│                      │  CLAUDE CODE (bottom panel)       │
│                      │                                   │
│                      │  You: Find me papers about sleep  │
│                      │       and memory consolidation    │
│                      │                                   │
│                      │  Claude: I found 10 papers...     │
│                      │                                   │
└─────────────────────────────────────────────────────────┘
```

- **Left panel** — your project folders. Click any file to open it.
- **Center** — whatever document you're reading or writing. You can preview Markdown formatted (Cmd+Shift+V on Mac) and view PDFs directly.
- **Bottom panel** — Claude Code. This is where you talk to your research assistant.

To start Claude Code in the terminal panel, click **Terminal > New Terminal** in VS Code's menu bar, then type:

```bash
claude
```

Now just start talking. Try:

> "I'm researching the effects of sleep deprivation on memory. Help me find papers."

Claude will search for papers, show you the results, and ask what you'd like to do next. When it edits files, you'll see the changes appear live in the editor above.

### Alternative: Terminal Only

If you prefer not to use VS Code, Claude Code works fine on its own in any terminal:

```bash
cd research-scaffold
claude
```

You can still do everything — Claude will show you file contents when you ask and edit files when needed. You just won't have the visual file browser and live preview alongside it.

---

## How to Use It (Just Talk)

Once Claude Code is running inside this project, you can say things like:

### Finding & Collecting Sources
- "Find papers about climate change and migration patterns"
- "Search for studies on cognitive enhancement published after 2020"
- "Download that paper — the DOI is 10.1038/s41586-020-2649-2"
- "Download this arXiv paper: 2301.00001"
- "I have some PDFs in my Downloads folder. Move them into this project and add them to my library."

### Reading & Understanding
- "Summarize the paper I just downloaded"
- "What are the key findings in sources/smith-2024.pdf?"
- "Has this paper's conclusions been supported by later research?"
- "Create a reading note for this paper"

### Writing
- "Show me my outline"
- "Draft the introduction section based on my outline and the papers we've collected"
- "Add a citation to Walker 2017 in the second paragraph"
- "Rewrite this paragraph to be more concise"
- "What's my word count?"

### Publishing
- "Build my paper as a PDF"
- "Export it as a Word document too"
- "Change the citation style from APA to Chicago"

### Project Management
- "What sources are in my library?"
- "Search my notes for anything about REM sleep"
- "Commit my progress — I just finished the literature review section"
- "What sections from my outline still need to be written?"

---

## How the Folder Is Organized

| Folder | What goes in it | Analogy |
|--------|----------------|---------|
| `manuscript/` | Your paper — the actual writing | Your typewriter |
| `sources/` | Downloaded PDFs of papers you've found | Your file drawer of photocopied articles |
| `library/` | Organized metadata for each source | Your card catalog |
| `notes/` | Your reading notes on individual papers | Your note cards |
| `bibliography/` | Your formatted reference list | Your bibliography cards |
| `figures/` | Charts, images, diagrams | Your illustration folder |
| `scratch/` | Brainstorming, rough ideas, discarded material | Your wastebasket (that you can dig through) |
| `output/` | The finished product — PDF, Word doc, etc. | Your printer tray |
| `templates/` | Pre-made forms for notes and drafts | Your blank index cards |
| `docs/` | Detailed instructions for each tool | Your reference manual |

---

## How Citations Work

You write your paper in plain text. When you want to cite a source, you (or Claude) put its reference key in brackets:

```
Studies have shown a link between sleep and memory [@walker2017].

This was confirmed by later work [@smith2023, p. 42].

Multiple researchers agree [see @walker2017; @smith2023; @jones2021].
```

When you build your paper, the system automatically:

1. Looks up each reference in your bibliography
2. Formats the citation in proper academic style (APA 7th edition by default)
3. Generates a complete "References" section at the end

**You never format a citation by hand.** Want a different style? Just tell Claude: "Switch my citations to Chicago style."

---

## The Research Workflow

A typical session looks like this:

```
 1. Plan         "Help me flesh out my outline on [topic]"
 2. Search       "Find papers about [subtopic]"
 3. Download     "Download the top 3 results"
 4. Catalog      "Add them to my library"
 5. Read         "Summarize that first paper"
 6. Verify       "Has this paper been contradicted by newer research?"
 7. Notes        "Create a reading note for it"
 8. Write        "Draft the literature review section"
 9. Cite         "Make sure all sources are properly cited"
10. Build        "Build my paper as a PDF"
11. Repeat       "Now let's work on the methodology section"
```

All of this happens in conversation. Claude knows the project structure, the tools, and your progress.

---

## API Keys (Optional but Recommended)

Some search tools work better with a free API key. After setup, you'll have a `.env` file. Tell Claude:

> "Help me set up my API keys"

| Key | What it's for | Cost | Where to get it |
|-----|--------------|------|-----------------|
| `SEMANTIC_SCHOLAR_API_KEY` | Faster, unlimited paper searches | Free | [semanticscholar.org](https://www.semanticscholar.org/product/api#Partner-Form) |
| `OPENAI_API_KEY` | AI-powered paper summaries | Pay-per-use | [platform.openai.com](https://platform.openai.com) |
| `ANTHROPIC_API_KEY` | Alternative AI summaries | Pay-per-use | [console.anthropic.com](https://console.anthropic.com) |

The Semantic Scholar key is the only one that matters, and it's free.

---

## For Power Users: Direct Commands

Everything Claude does under the hood uses `make` commands. If you prefer to run them yourself:

<details>
<summary>Click to expand the full command reference</summary>

### Finding Papers
| What you want to do | Command |
|---------------------|---------|
| Search for papers | `make search QUERY="your topic"` |
| Deeper search with citation counts | `make search-py QUERY="your topic"` |

### Downloading Papers
| What you want to do | Command |
|---------------------|---------|
| Download from arXiv | `make fetch-arxiv ID="2301.00001"` |
| Download by DOI | `make fetch-doi DOI="10.1038/s41586-020-2649-2"` |

### Working with PDFs
| What you want to do | Command |
|---------------------|---------|
| Extract text from a PDF | `make extract-text PDF="sources/paper.pdf"` |
| Extract text from all PDFs | `make extract-all` |
| Find a DOI in a PDF | `make identify-doi PDF="sources/paper.pdf"` |

### Understanding & Verifying
| What you want to do | Command |
|---------------------|---------|
| Summarize a paper | `make summarize PDF="sources/paper.pdf"` |
| Check citation support/contradiction | `make verify DOI="10.1038/s41586-020-2649-2"` |

### Organizing Sources
| What you want to do | Command |
|---------------------|---------|
| Add paper by DOI | `make add-paper DOI="10.1038/s41586-020-2649-2"` |
| Add a local PDF | `make add-pdf PDF="sources/paper.pdf"` |
| Generate bibliography | `make bib` |
| List all references | `make list-refs` |

### Note-Taking
| What you want to do | Command |
|---------------------|---------|
| Create a reading note | `make new-note TITLE="Paper Title"` |
| Search notes | `make search-notes QUERY="keyword"` |

### Writing & Building
| What you want to do | Command |
|---------------------|---------|
| Build PDF | `make pdf` |
| Build Word document | `make docx` |
| Build HTML | `make html` |
| Build all formats | `make all` |
| Word count | `make wordcount` |

### Utilities
| What you want to do | Command |
|---------------------|---------|
| Check all tools are working | `make check` |
| Re-run setup | `make setup` |

</details>

---

## The Tools Under the Hood

Claude uses 15+ free CLI tools to do the work. You don't need to know about them, but if you're curious:

| What it does | Tool | More info |
|-------------|------|-----------|
| Searches 200M+ academic papers | Semantic Scholar | [docs/01-discovery.md](docs/01-discovery.md) |
| Downloads papers from arXiv | arxiv-dl | [docs/02-retrieval.md](docs/02-retrieval.md) |
| Downloads papers by DOI | doi2pdf | [docs/02-retrieval.md](docs/02-retrieval.md) |
| Extracts DOIs from PDFs | pdf2doi | [docs/02-retrieval.md](docs/02-retrieval.md) |
| Summarizes papers with AI | slurp, arxiv-summarizer | [docs/03-summarization.md](docs/03-summarization.md) |
| Checks if findings are supported | scite-cli | [docs/03-summarization.md](docs/03-summarization.md) |
| Extracts text from PDFs | pdftotext, pdfminer | [docs/04-pdf-extraction.md](docs/04-pdf-extraction.md) |
| Manages your reference library | papis | [docs/05-reference-management.md](docs/05-reference-management.md) |
| Structured note-taking | nb, zk | [docs/06-note-taking.md](docs/06-note-taking.md) |
| Builds PDF/Word/HTML from Markdown | pandoc | [docs/07-writing-and-publishing.md](docs/07-writing-and-publishing.md) |

---

## Frequently Asked Questions

**Do I need to know how to code?**
No. You talk to Claude in plain English. It handles everything.

**Do I need to know what a "terminal" is?**
Barely. You open it once, type `claude`, and from then on you're having a conversation.

**What if I already have papers saved as PDFs?**
Tell Claude: "I have PDFs in my Downloads folder — add them to my project." It will move them into the right place and catalog them.

**Can I collaborate with co-authors?**
Yes. This is a GitHub repository, so multiple people can work on it. Each person forks the project and pushes their contributions.

**What if something breaks?**
Tell Claude: "Something seems broken, can you check my setup?" It will run diagnostics and fix what it can.

**Can I use this for a dissertation or book?**
Absolutely. The structure works for any length. You can split chapters into separate files in `manuscript/`.

**I prefer writing in Word or Google Docs. Can I still use the rest?**
Yes. Use Claude for finding, downloading, and organizing sources. When you're ready, say "Export my bibliography" and import the `.bib` file into your word processor's citation manager.

**How is this different from Zotero, Mendeley, or EndNote?**
Those are GUI applications you click through. This is an AI-powered command-line workflow where you describe what you want in natural language and it happens. Everything is stored as plain text files you own — no proprietary database, no vendor lock-in.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Suggestions, new tools, and improvements are welcome.

## License

MIT — see [LICENSE](LICENSE). Use it however you like.
