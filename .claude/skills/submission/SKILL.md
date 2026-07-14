---
name: submission
description: Pre-submission checks, bibliography verification, and peer-review responses. Use when the manuscript nears submission, when verifying references, or when responding to reviewers.
---

# Submission

## When the manuscript is nearing submission

1. Copy `templates/submission-checklist.md` to the project root as `submission-checklist.md`
2. Work through it top to bottom with the user, checking items off in the file
3. `make verify-bib` — verifies every references.bib entry (authors, given names, year, title) against Crossref/arXiv. Fix every ✗ against the published record; manually check every ? (books, workshop papers) and ⚠ (author-name variants)
4. **Grounding pass:** for every example, quote, and statistic in the manuscript, open the underlying source file and confirm it matches verbatim
5. **Claims pass:** search for "prove", "demonstrate", "show that", "establish" — downgrade to "suggest"/"indicate" where evidence is correlational or ablation-based
6. Run `make lint`, `make grammar`, `make readability`; build with `make pdf` and read the whole PDF at print size (figures especially)
7. After submitting: record venue, date, and version in progress.md; tag the snapshot `git tag submitted-<venue>-<date>`

## Verifying a single source's standing

- `make verify DOI="..."` — has the paper been supported or contradicted? (optional tool: needs a paid scite.ai account; if missing, check the paper's citations manually on scite.ai or Semantic Scholar)
- Report supported/contradicted/mixed; suggest alternatives if disputed

## Responding to peer review

1. Copy `templates/peer-review-response.md` into `manuscript/`
2. Fill in responses point by point with the user — quote each reviewer comment, state the change made, cite where in the manuscript
3. `make diff OLD="<submitted version>" NEW="manuscript/main.md"` — track-changes PDF for the resubmission
4. Record the revision round in progress.md

## Repo hygiene for published papers

- Replace the scaffold README with a paper-specific one: key finding, repo structure, reproduction steps, dataset table
- Confirm the code-availability link works from a fresh clone
