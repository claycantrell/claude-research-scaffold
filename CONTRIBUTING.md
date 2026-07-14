# Contributing

This is a community template — contributions are welcome.

## How to Contribute

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## What to Contribute

- **New tools**: Add a CLI-based research tool to the scaffold
- **Makefile targets**: New workflow shortcuts
- **Documentation**: Improve or expand tool docs in `docs/`
- **Templates**: Better note/manuscript/outline templates
- **Bug fixes**: Broken scripts, incorrect install commands

## Adding a New Tool

1. Ask first whether it earns its place: a Makefile target must use it, or it doesn't go in. (A past cleanup removed six tools that were installed, documented, and validated but backed nothing.)
2. Add install instructions to `setup.sh`
3. Add Python packages to `requirements.txt` (if applicable)
4. Add the tool to the check list in `scripts/validate-env.sh` and the validation list in `setup.sh`
5. Add a Makefile target — if a paid account is required, make it optional: don't install it in `setup.sh`, and have the target degrade with install instructions
6. Create or update the relevant file in `docs/` (organized by workflow stage)
7. Update the toolkit table in `README.md`, and the relevant skill in `.claude/skills/` if Claude should use the tool

## Standards

- Shell scripts: `#!/usr/bin/env bash`, `set -euo pipefail`, pass `shellcheck`
- Keep everything CLI-first — no GUI dependencies
- All tools must be free (paid tiers are fine, but free tier must be functional)
- Test on both macOS and Linux when possible
