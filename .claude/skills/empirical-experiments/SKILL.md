---
name: empirical-experiments
description: Conventions for projects that generate their own results — running models, labeling data, computing statistics. Use when writing or running experiment code, or when drafting sections that report original results.
---

# Empirical Experiments

Some projects don't just review literature — they produce results. For these:

1. **Experiment code lives in `scripts/`, generated data in `data/`, API caches in `cache/`.** Both `data/` and `cache/` are git-ignored — scripts are the source of truth; anyone rebuilds the data by running them.
2. **Cache every expensive call.** LLM API responses, dataset downloads, embeddings, model outputs — cached to disk on first run, so experiments are cheap to re-run and results stay stable across sessions.
3. **Log to files, not just the terminal.** Long-running scripts write to a log (e.g. `cache/run-YYYY-MM-DD.log`). Terminal output disappears; the paper's numbers must be re-checkable later.
4. **One note per experiment in `notes/`:** the exact command, parameters, and headline result. When drafting, numbers come from these notes and logs — never from memory.
5. **API keys go in `.env`** (`ANTHROPIC_API_KEY`, `OPENAI_API_KEY` are pre-listed in `.env.example`). Never hardcode keys.
6. **Negative and null results get recorded too.** A control that showed nothing is evidence — it belongs in progress.md and often in the paper.
7. **Estimate cost before big API runs** and tell the user ("~1,200 calls, roughly $2").

## Reporting results in the manuscript

- Every number in a table or sentence traces to a specific log or output file — cite the file in the draft's Sources table
- Re-run or re-open the analysis when transcribing; never quote a statistic from memory
- Ablations and robustness checks that failed to change the result are worth a sentence — reviewers ask
