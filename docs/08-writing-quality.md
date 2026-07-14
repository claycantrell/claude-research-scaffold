# Writing Quality Tools

Three offline tools for catching prose issues before submission: a style linter, a grammar checker, and a readability analyzer.

## Vale — Prose Linter

**Install:** `brew install vale`

Vale enforces writing style rules on Markdown files. It catches passive voice, weasel words, jargon, hedging language ("it seems," "arguably"), and inconsistent terminology. All checks run offline with no cloud dependency.

### Usage

Lint all Markdown files:

```bash
make lint
```

Lint a specific file:

```bash
make lint FILE="notes/some-note.md"
```

### Configuration

The project `.vale.ini` in the repo root controls Vale's behavior:

```ini
StylesPath = .vale/styles
MinAlertLevel = suggestion

Packages = write-good, proselint

[*.md]
BasedOnStyles = Vale, write-good, proselint
```

- **StylesPath** — where Vale stores downloaded style rules (`.vale/styles/`).
- **MinAlertLevel** — show `suggestion`, `warning`, and `error` level alerts. Change to `warning` to reduce noise.
- **Packages** — style packages installed by `vale sync`. Each package is a collection of rules.
- **BasedOnStyles** — which rule sets to apply to `.md` files.

### Installing and Updating Styles

After cloning the repo or changing packages in `.vale.ini`:

```bash
vale sync
```

This downloads the listed packages into `.vale/styles/`.

### Adding or Changing Style Packages

Edit the `Packages` line in `.vale.ini`. Some useful packages:

| Package | What it catches |
|---|---|
| `write-good` | Passive voice, weasel words, "there is/are" |
| `proselint` | Jargon, cliches, redundancy, hedging |
| `alex` | Insensitive, inconsiderate writing |
| `Microsoft` | Microsoft Writing Style Guide rules |
| `Google` | Google Developer Documentation Style Guide |

For academic writing, `write-good` + `proselint` is a solid baseline. Add `Microsoft` or `Google` if you want stricter style enforcement.

### Suppressing False Positives

Wrap a section with Vale comments to disable a specific rule:

```markdown
<!-- vale write-good.Passive = NO -->
The experiment was conducted in a controlled environment.
<!-- vale write-good.Passive = YES -->
```

---

## LanguageTool — Grammar and Spell Checker

**Install:** `brew install languagetool` — optional and not installed by `setup.sh` (it pulls in a Java runtime). `make lint` (Vale) covers style without it; LanguageTool adds grammar and spelling.

LanguageTool is an open-source grammar and spell checker supporting 25+ languages. It runs locally — no text is sent to external servers. It catches subject-verb agreement errors, comma splices, article misuse ("a" vs. "an"), spelling mistakes, and common grammatical errors.

### Usage

```bash
make grammar
```

This runs LanguageTool against the manuscript files and reports errors with line numbers and suggested corrections.

### What It Catches

- Subject-verb agreement ("The results *shows*" -> "show")
- Comma splices ("The study was complete, it showed results" -> use semicolon or period)
- Article errors ("a unique" is correct, "an unique" is not)
- Spelling errors and typos
- Repeated words ("the the")
- Confused word pairs ("affect" vs. "effect")

---

## GNU diction/style — Readability Statistics

**Install:** `brew install diction`

The `style` command (part of the `diction` package) computes readability statistics: Flesch-Kincaid grade level, Gunning fog index, average sentence length, and more. Use it to check whether your prose is at the right complexity level for your audience.

### Usage

```bash
make readability
```

### Interpreting Scores

**Flesch-Kincaid Grade Level** — the U.S. school grade needed to understand the text:

| Score | Audience |
|---|---|
| 8-10 | General public, blog posts |
| 10-12 | Undergraduate textbooks |
| **12-16** | **Journal articles (target this range)** |
| 16+ | Legal/bureaucratic text (too dense) |

**Gunning Fog Index** — similar to Flesch-Kincaid but weights polysyllabic words more heavily. Same ranges apply.

**Practical targets for academic writing:**
- Flesch-Kincaid grade level: 12-16. Below 12, you may be oversimplifying. Above 16, sentences are too long or jargon-heavy.
- Average sentence length: 15-25 words. Over 30 words per sentence signals restructuring is needed.
- Sentences over 35 words: flag individually and consider splitting.

### Example Output

```
readability grades:
        Kincaid: 13.2
        ARI: 14.1
        Coleman-Liau: 13.8
        Flesch Index: 38.6
        Fog Index: 15.9
sentence info:
        19532 characters
        4205 words, average length 4.64 characters
        178 sentences, average length 23.6 words
```

This sample is in the target range: Kincaid 13.2, average sentence length 23.6 words.

---

## Makefile Shortcuts Summary

| Command | Tool | What it does |
|---|---|---|
| `make lint` | Vale | Style linting on all Markdown files |
| `make lint FILE="path"` | Vale | Style linting on a specific file |
| `make grammar` | LanguageTool | Grammar and spell check |
| `make readability` | diction/style | Flesch-Kincaid and readability stats |
