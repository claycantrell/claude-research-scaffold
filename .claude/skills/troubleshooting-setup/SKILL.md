---
name: troubleshooting-setup
description: First-time setup and fixing missing tools. Use when a command fails with "not found", when starting a brand-new project, or when the user says something seems broken.
---

# Setup & Troubleshooting

The user will NOT know how to install things. If a tool is missing, **install it for them** — don't just say what's needed.

## First-time setup (new project)

1. Read `progress.md` and `outline.md` — if still template defaults, this is a new project
2. `make check` — see what's installed; if tools are missing, run `./setup.sh` for them
3. Help them fill in `outline.md`: ask about their research topic, draft the structure together
4. Initialize `progress.md`'s checklist to match their outline sections
5. Offer to set up API keys in `.env` (better search results; empirical projects need LLM keys)
6. Explain the workspace briefly if they seem lost
7. Save a first snapshot

## When a command fails

1. Read the error — it usually names what's missing
2. First resort: `./setup.sh` (safe to re-run, installs everything)
3. Still missing → install directly:
   - **Mac:** `brew install <tool>` (install Homebrew first if `which brew` fails)
   - **Linux:** `sudo apt update && sudo apt install <tool>`
   - **Python:** `pip3 install <package>` or `pip3 install -r requirements.txt`
   - **Node:** `npm install -g <package>`
4. Re-run the failed command
5. Tell the user in plain language: "One of the research tools wasn't installed yet. I fixed it — you're good to go."

## Common errors

| Error | Missing | Fix |
|-------|---------|-----|
| `make: command not found` | Build tools | Mac: `xcode-select --install`; Linux: `sudo apt install build-essential` |
| `python3` / `node` / `npm` not found | Python / Node | brew or apt install |
| `pandoc: command not found` | Pandoc | `brew install pandoc` / `sudo apt install pandoc` |
| `tectonic: command not found` | PDF engine | `brew install tectonic` (or `make pdf PDF_ENGINE=xelatex` with a TeX install) |
| `pdftotext: command not found` | Poppler | `brew install poppler` / `sudo apt install poppler-utils` |
| `vale: command not found` | Vale style checker | `brew install vale` |
| `papis: command not found` | Reference manager | `pip3 install papis` |
| `semanticscholar` / `pyalex` module missing | Search libraries | `pip3 install -r requirements.txt` |
| `brew: command not found` (Mac) | Homebrew | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |

**Never leave the user stuck.** If you truly can't fix it, explain plainly and suggest they say: "Something seems broken, can you check my setup?"
