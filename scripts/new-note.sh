#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NOTES_DIR="$REPO_ROOT/notes"
TEMPLATE="$REPO_ROOT/templates/note.md"

if [ $# -lt 1 ]; then
  echo "Usage: $0 \"Paper Title\"" >&2
  exit 1
fi

TITLE="$1"
DATE="$(date +%Y-%m-%d)"

# Slugify the title: lowercase, replace non-alphanumeric with hyphens, collapse multiple hyphens, trim leading/trailing hyphens
SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\{2,\}/-/g' | sed 's/^-//;s/-$//')"

FILENAME="${DATE}-${SLUG}.md"
FILEPATH="$NOTES_DIR/$FILENAME"

if [ -f "$FILEPATH" ]; then
  echo "Note already exists: $FILEPATH" >&2
  exit 1
fi

if [ ! -f "$TEMPLATE" ]; then
  echo "Error: template not found at $TEMPLATE" >&2
  exit 1
fi

mkdir -p "$NOTES_DIR"

sed -e "s/{{PAPER_TITLE}}/$TITLE/g" -e "s/{{DATE}}/$DATE/g" "$TEMPLATE" > "$FILEPATH"

echo "Created: $FILEPATH"
