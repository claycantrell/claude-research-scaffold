#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

tools=(
  semantic_bibtool
  python3
  pip
  node
  npm
  pdftotext
  pandoc
  papis
  nb
  zk
  arxiv-dl
  doi2pdf
  pdf2doi
  scite-cli
  vale
  mmdc
  gnuplot
  style
  latexdiff
  pandoc-crossref
)

ready=0
total=${#tools[@]}

echo "Checking tools..."
echo "---"

for tool in "${tools[@]}"; do
  if command -v "$tool" &>/dev/null; then
    printf "\xe2\x9c\x93 %s\n" "$tool"
    ready=$((ready + 1))
  else
    printf "\xe2\x9c\x97 %s\n" "$tool"
  fi
done

echo "---"

# Check API keys
echo ""
echo "Checking API keys..."
echo "---"

env_file="$REPO_ROOT/.env"
api_keys_ok=0
api_keys_total=1

if [ -f "$env_file" ]; then
  if grep -q '^SEMANTIC_SCHOLAR_API_KEY=.\+' "$env_file" 2>/dev/null; then
    printf "\xe2\x9c\x93 SEMANTIC_SCHOLAR_API_KEY (set in .env)\n"
    api_keys_ok=$((api_keys_ok + 1))
  else
    printf "\xe2\x9c\x97 SEMANTIC_SCHOLAR_API_KEY (missing or empty in .env)\n"
  fi
else
  printf "\xe2\x9c\x97 SEMANTIC_SCHOLAR_API_KEY (.env file not found)\n"
fi

echo "---"
echo ""
echo "$ready/$total tools ready"
echo "$api_keys_ok/$api_keys_total API keys configured"
