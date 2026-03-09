# Research Scaffold

**A ready-made project folder for academic research, powered by Claude Code.**

You talk to an AI assistant in plain English. It finds papers, downloads them, organizes your sources, manages citations, writes with you, and produces a finished document. You focus on the ideas — Claude handles the tedium.

Everything here is **free** and runs on your computer. Your research stays yours.

---

## What Is This?

Think of it as a **pre-organized filing cabinet for a research project** — except it comes with a built-in research assistant (Claude Code) that can:

- **Find papers** — "Find me recent papers about cognitive enhancement"
- **Download them** — "Download that first one"
- **Understand them** — "What does this paper argue?"
- **Verify them** — "Has this paper's findings been contradicted?"
- **Organize your sources** — "Add this to my library"
- **Take notes** — "Create a reading note for this paper"
- **Write with you** — "Draft an introduction based on my outline"
- **Cite properly** — "Cite Smith 2024 in that paragraph"
- **Produce finished documents** — "Build my paper as a PDF"

You don't need to memorize commands or learn software. You just talk to Claude.

---

## Getting Started

### Step 1: Open Your Terminal

The **terminal** is a text window where you type commands. That's how you'll talk to Claude.

- **Mac:** Press `Cmd + Space`, type **Terminal**, and hit Enter.
- **Linux:** Look for "Terminal" in your applications menu.
- **Windows:** Install [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) first, then open the Ubuntu app.

You'll see a blinking cursor waiting for you to type. That's it — that's the terminal.

### Step 2: Install Claude Code

Copy and paste each of these into your terminal, one at a time, pressing Enter after each one:

**First, install Node.js** (a behind-the-scenes tool that Claude Code needs):

    curl -fsSL https://fnm.vercel.app/install | bash

Close your terminal and open a new one, then:

    fnm install --lts

**Next, install Claude Code itself:**

    npm install -g @anthropic-ai/claude-code

**Now, start Claude to log in:**

    claude

The first time you run this, Claude will ask you to create an account. You have two options:

- **Anthropic account** (recommended) — sign up free at [console.anthropic.com](https://console.anthropic.com). You get some free usage, then pay-as-you-go.
- **Claude Pro/Max subscription** — if you already pay for Claude at [claude.ai](https://claude.ai), you can connect that instead.

A browser window will pop open — log in there, then come back to the terminal. Once you see Claude talking to you, you're in. Type `/exit` to close it for now.

### Step 3: Let Claude Set Up Everything Else

Start Claude back up:

    claude

Now just tell it what you need. Claude will handle the rest — installing tools, creating accounts, downloading software. You just answer its questions.

**To get your copy of this project,** say:

> "I don't have a GitHub account yet. I need you to install the GitHub CLI, help me create an account and log in, then fork and clone the research-scaffold project from claycantrell on GitHub. Walk me through each step and tell me exactly what to do."

*(If you already have a GitHub account, just say: "Install the GitHub CLI, log me into GitHub, and fork and clone claycantrell/research-scaffold.")*

Claude will do the work and tell you what to type when it needs you. When it's done, it will say something like "type `cd research-scaffold`" — do what it says, then start Claude again:

    claude

**To install the research tools,** say:

> "Run the setup script to install all the research tools for this project. Then verify everything is working."

**To set up a visual workspace** (so you can see your files and writing side by side with Claude), say:

> "Download and install VS Code if I don't have it, open this project in it, and install all the recommended extensions. Then explain the layout to me."

This is optional but recommended — it lets you see your paper, sources, and notes while you talk to Claude.

### Your Workspace (if you set up VS Code)

If Claude sets up VS Code for you, here's what you'll see:

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
- **Center** — whatever document you're reading or writing.
- **Bottom panel** — Claude Code. This is where you talk to your research assistant.

You don't have to use VS Code. Claude works fine in any terminal window. But VS Code lets you see your files updating live as Claude works, which is nice.

### Saving Your Work

This project automatically tracks every change you make — think of it as an **infinite undo button**. Here's all you need to know:

- **Claude saves your work for you.** After you make progress (finish a section, add a batch of sources, etc.), Claude will offer to save a snapshot. Just say yes.
- **You can always go back.** If something goes wrong, tell Claude: *"Undo my last changes"* or *"Go back to how things were yesterday."* Nothing is ever permanently lost.
- **Your work is backed up online.** Claude can push your saved snapshots to GitHub, so even if your computer dies, your research is safe. Just say: *"Back up my work."*
- **You don't need to understand Git.** Claude handles all of that behind the scenes. If you're curious, "saving a snapshot" is called a "commit" and "backing up online" is called a "push" — but you never need to type those words.

### Claude Remembers Where You Left Off

Every time you close Claude and come back later, it picks up where you left off. It knows what sections you've drafted, which papers you've found, what decisions you've made, and what you planned to do next.

This works because three files in your project act as Claude's memory:

- **`outline.md`** — your paper's structure and thesis
- **`progress.md`** — a checklist of what's done and a note about where you left off
- **`decisions.md`** — choices you've made along the way (scope, style, focus areas)

Claude updates these automatically as you work. You don't need to touch them — but you can look at them anytime to see the state of your project at a glance.

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
- "What does this paper argue?"
- "What are the key findings in sources/smith-2024.pdf?"
- "Has this paper's conclusions been supported by later research?"
- "Create a reading note for this paper"

### Writing & Editing
- "Show me my outline"
- "Draft the introduction section based on my outline and the papers we've collected"
- "Add a citation to Walker 2017 in the second paragraph"
- "Rewrite this paragraph to be more concise"
- "What's my word count?"
- "Check my writing for grammar and style issues"
- "How readable is my manuscript? What's the grade level?"
- "Create a flowchart showing my methodology"

### Revising & Publishing
- "Build my paper as a PDF"
- "Export it as a Word document too"
- "Change the citation style from APA to Chicago"
- "Show me what changed between my first and current draft"
- "Help me write a response to these peer reviewer comments"

### Project Management
- "What sources are in my library?"
- "Search my notes for anything about REM sleep"
- "Commit my progress — I just finished the literature review section"
- "What sections from my outline still need to be written?"

---

## How the Folder Is Organized

| File / Folder | What goes in it | Analogy |
|--------|----------------|---------|
| `outline.md` | Your research plan — thesis, sections, structure | Your table of contents |
| `progress.md` | What's done, what's not, where you left off | Your to-do list |
| `decisions.md` | Choices you've made about scope, style, focus | Your research journal |
| `manuscript/` | Your paper — the actual writing | Your typewriter |
| `sources/` | Downloaded PDFs of papers you've found | Your file drawer of photocopied articles |
| `library/` | Organized metadata for each source | Your card catalog |
| `notes/` | Your reading notes on individual papers | Your note cards |
| `drafts/` | Working drafts for each section — where argument meets evidence | Your rough drafts pile |
| `bibliography/` | Your formatted reference list | Your bibliography cards |
| `figures/` | Charts, images, diagrams | Your illustration folder |
| `scratch/` | Brainstorming, rough ideas, discarded material | Your wastebasket (that you can dig through) |
| `output/` | The finished product — PDF, Word doc, etc. | Your printer tray |
| `templates/` | Pre-made forms for notes and drafts | Your blank index cards |
| `docs/` | Detailed instructions for each tool | Your reference manual |

---

## How Research Becomes Writing

Research papers don't go from "I found some papers" to "here's a polished manuscript" in one step. This scaffold breaks the process into three layers, and Claude manages the flow between them:

    notes/  →  drafts/  →  manuscript/

**1. Reading Notes (`notes/`)** — When you find and read a paper, Claude automatically creates a reading note. This is objective: what does the paper say? Key findings, methodology, data points, direct quotes with page numbers. One file per paper. You don't need to ask for this — it happens whenever Claude downloads or summarizes a source.

**2. Section Drafts (`drafts/`)** — This is where the real thinking happens. After you've collected a few papers on a topic, you and Claude talk through how they fit together. How does Paper A's finding connect to Paper B's result? What argument do they support? What's the logical chain? What evidence is still missing?

Once you agree on how the pieces fit, Claude saves a working draft in `drafts/` — one file per section of your paper. Each draft contains:
- **Argument** — what this section is trying to say in 2-3 sentences
- **Evidence Bridge** — the numbered logical chain connecting your sources to your argument (this is the most valuable part — it captures your *reasoning*)
- **Evidence Log** — direct quotes, page numbers, exact data points, and specific tables/figures from each paper. Everything is traceable — you should be able to find any claim in the original source in under 30 seconds
- **Gaps** — what evidence you still need to find
- **Draft Prose** — rough paragraphs with citations that you'll eventually polish and move to the manuscript

**Important:** Claude will *not* write section drafts without your input. Reading notes are objective and get created automatically. But section drafts are *your* argument, *your* interpretation of what the evidence means. Claude will discuss how the papers connect, propose an evidence chain, and then ask: "Want me to save this as a working draft?" You decide.

**3. Manuscript (`manuscript/main.md`)** — The polished final paper. When a section draft is solid, you move it here, clean it up, and it becomes part of the finished work.

**Why this matters:** The biggest risk in research is losing the *reasoning* — you read five papers, see how they connect, have an insight about your argument... and then forget it by next week. The `drafts/` folder captures that reasoning while it's fresh. The evidence log means you never have to re-read a paper just to find where a number came from.

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
 5. Read         "What does that first paper say?"
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

The Semantic Scholar key is the only one that matters, and it's free. Claude itself can summarize papers directly — no separate API key needed for that.

---

## For Power Users: Direct Commands

Everything Claude does under the hood uses `make` commands. If you prefer to run them yourself:

<details>
<summary>Click to expand the full command reference</summary>

### Finding Papers
| What you want to do | Command |
|---------------------|---------|
| Search Semantic Scholar | `make search QUERY="your topic"` |
| Deeper search with citation counts | `make search-py QUERY="your topic"` |
| Search OpenAlex (250M+ papers) | `make search-openalex QUERY="your topic"` |
| Find papers by a specific author | `make search-author AUTHOR="Jane Smith"` |

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

### Verifying
| What you want to do | Command |
|---------------------|---------|
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

### Writing Quality
| What you want to do | Command |
|---------------------|---------|
| Check prose style (passive voice, jargon, etc.) | `make lint` |
| Check grammar and spelling | `make grammar` |
| Get readability stats (grade level, fog index) | `make readability` |

### Figures & Diagrams
| What you want to do | Command |
|---------------------|---------|
| Generate a diagram from Mermaid file | `make figure SRC="figures/diagram.mmd"` |
| Generate all diagrams | `make figures` |
| Run a gnuplot chart script | `make plot SRC="figures/chart.gp"` |

### Writing & Building
| What you want to do | Command |
|---------------------|---------|
| Build PDF | `make pdf` |
| Build Word document | `make docx` |
| Build HTML | `make html` |
| Build all formats | `make all` |
| Word count | `make wordcount` |
| Compare two drafts (track-changes PDF) | `make diff OLD="v1.md" NEW="v2.md"` |

### Utilities
| What you want to do | Command |
|---------------------|---------|
| Check all tools are working | `make check` |
| Re-run setup | `make setup` |

</details>

---

## The Tools Under the Hood

Claude uses 20+ free CLI tools to do the work. You don't need to know about them, but if you're curious:

| What it does | Tool | More info |
|-------------|------|-----------|
| Searches 200M+ academic papers | Semantic Scholar | [docs/01-discovery.md](docs/01-discovery.md) |
| Searches 250M+ papers (alternative) | OpenAlex | [docs/01-discovery.md](docs/01-discovery.md) |
| Downloads papers from arXiv | arxiv-dl | [docs/02-retrieval.md](docs/02-retrieval.md) |
| Downloads papers by DOI | doi2pdf | [docs/02-retrieval.md](docs/02-retrieval.md) |
| Extracts DOIs from PDFs | pdf2doi | [docs/02-retrieval.md](docs/02-retrieval.md) |
| Checks if findings are supported | scite-cli | [docs/03-summarization.md](docs/03-summarization.md) |
| Extracts text from PDFs | pdftotext, pdfminer | [docs/04-pdf-extraction.md](docs/04-pdf-extraction.md) |
| Manages your reference library | papis | [docs/05-reference-management.md](docs/05-reference-management.md) |
| Structured note-taking | nb, zk | [docs/06-note-taking.md](docs/06-note-taking.md) |
| Builds PDF/Word/HTML from Markdown | pandoc | [docs/07-writing-and-publishing.md](docs/07-writing-and-publishing.md) |
| Checks prose style and tone | Vale | [docs/08-writing-quality.md](docs/08-writing-quality.md) |
| Checks grammar and spelling | LanguageTool | [docs/08-writing-quality.md](docs/08-writing-quality.md) |
| Measures readability (grade level) | GNU style | [docs/08-writing-quality.md](docs/08-writing-quality.md) |
| Generates diagrams from text | Mermaid CLI | [docs/09-figures-and-diagrams.md](docs/09-figures-and-diagrams.md) |
| Creates scientific charts/plots | gnuplot | [docs/09-figures-and-diagrams.md](docs/09-figures-and-diagrams.md) |
| Auto-numbers figures/tables/equations | pandoc-crossref | [docs/10-revision-and-review.md](docs/10-revision-and-review.md) |
| Compares draft versions (track changes) | latexdiff | [docs/10-revision-and-review.md](docs/10-revision-and-review.md) |

---

## Important Things to Know

Claude Code is an **AI agent** — it reads files, runs commands, and makes changes on your computer on your behalf. That's what makes it powerful, but it comes with things you should be aware of:

**Claude makes mistakes.** It's an AI, not a human expert. It may misinterpret a paper, cite the wrong source, or write something that sounds confident but is factually wrong. **Always read what Claude writes before you publish it.** This is your research — Claude is a fast assistant, not a co-author.

**Review your writing carefully.** Claude can draft entire sections in seconds, but that doesn't mean the output is ready to submit. Check facts, verify quotes, and make sure arguments actually make sense. AI-generated text can be fluent but shallow.

**Claude runs commands on your computer.** When you ask it to install tools, download files, or set things up, it's executing real commands in your terminal. This project is designed so those commands are safe, but you should know it's happening. Claude will ask for permission before doing anything unusual.

**It costs money.** Claude Code uses the Anthropic API, which charges based on how much you use it. Short conversations are cheap (pennies). Long sessions with lots of file reading and searching can add up. Keep an eye on your usage at [console.anthropic.com](https://console.anthropic.com). If you have a Claude Pro or Max subscription, usage may be included — check your plan.

**Your data stays on your computer.** PDFs, notes, and your manuscript stay in your local project folder. However, the text of your conversations with Claude (including any file contents Claude reads) is sent to Anthropic's servers for processing. Don't feed it anything you're not comfortable with a third party seeing — unpublished proprietary data, confidential patient records, classified material, etc.

**Save your work often.** Tell Claude "save my progress" regularly. If something goes wrong — a bad edit, an accidental deletion — you can always go back to a previous snapshot. Claude is instructed to offer saves automatically, but don't rely on that entirely.

**AI is not a substitute for peer review.** Claude can check grammar, find sources, and draft text, but it cannot replace the judgment of human experts in your field. Use it to accelerate your work, not to bypass the scholarly process.

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
