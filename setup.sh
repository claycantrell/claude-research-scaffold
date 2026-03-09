#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────────────────────
# Academic Research CLI Scaffold — One-Command Installer
# ─────────────────────────────────────────────────────────────────────────────
# Idempotent: safe to run multiple times. Detects macOS vs Linux and installs
# system dependencies, Python tools, and Node-based tools for a CLI-first
# academic research workflow.
# ─────────────────────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCITE_CLI_DIR="${HOME}/.local/share/scite-cli"

# ── Colours & helpers ────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

info()  { printf "${CYAN}[info]${RESET}  %s\n" "$*"; }
ok()    { printf "${GREEN}[ok]${RESET}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[warn]${RESET}  %s\n" "$*"; }
fail()  { printf "${RED}[fail]${RESET}  %s\n" "$*"; }
header(){ printf "\n${BOLD}── %s ──${RESET}\n\n" "$*"; }

# ── Detect platform ─────────────────────────────────────────────────────────

detect_platform() {
    case "$(uname -s)" in
        Darwin) PLATFORM="macos" ;;
        Linux)  PLATFORM="linux" ;;
        *)      fail "Unsupported platform: $(uname -s)"; exit 1 ;;
    esac
    info "Detected platform: ${PLATFORM}"
}

# ── Package manager helpers ──────────────────────────────────────────────────

brew_install() {
    local pkg="$1"
    if brew list "$pkg" &>/dev/null; then
        ok "$pkg already installed (brew)"
    else
        info "Installing $pkg via brew..."
        brew install "$pkg"
    fi
}

apt_install() {
    local pkg="$1"
    if dpkg -s "$pkg" &>/dev/null 2>&1; then
        ok "$pkg already installed (apt)"
    else
        info "Installing $pkg via apt..."
        sudo apt-get install -y "$pkg"
    fi
}

# ── Install system dependencies ──────────────────────────────────────────────

install_system_deps() {
    header "System Dependencies"

    if [[ "$PLATFORM" == "macos" ]]; then
        if ! command -v brew &>/dev/null; then
            fail "Homebrew not found. Install it first: https://brew.sh"
            exit 1
        fi
        brew_install python3
        brew_install node
        brew_install poppler       # provides pdftotext
        brew_install pandoc
        brew_install nb
        brew_install zk
        brew_install vale
        brew_install languagetool
        brew_install pandoc-crossref
        brew_install gnuplot
        brew_install diction
        brew_install latexdiff
    else
        info "Updating apt cache..."
        sudo apt-get update -qq
        apt_install python3
        apt_install python3-pip
        apt_install nodejs
        apt_install npm
        apt_install poppler-utils  # provides pdftotext
        apt_install pandoc

        # nb (xwmx/tui notebook)
        if ! command -v nb &>/dev/null; then
            info "Installing nb via brew (linuxbrew)..."
            if command -v brew &>/dev/null; then
                brew_install nb
            else
                warn "brew not available on this Linux system — install nb manually: https://xwmx.github.io/nb/"
            fi
        else
            ok "nb already installed"
        fi

        # zk (zettelkasten CLI)
        if ! command -v zk &>/dev/null; then
            info "Installing zk via brew (linuxbrew)..."
            if command -v brew &>/dev/null; then
                brew_install zk
            else
                warn "brew not available on this Linux system — install zk manually: https://github.com/zk-org/zk"
            fi
        else
            ok "zk already installed"
        fi

        # vale (prose linter)
        if ! command -v vale &>/dev/null; then
            info "Installing vale..."
            if command -v brew &>/dev/null; then
                brew_install vale
            else
                info "Downloading vale binary..."
                curl -sfL https://install.goreleaser.com/github.com/errata-ai/vale.sh | sh -s -- -b /usr/local/bin || warn "vale install failed — install manually: https://vale.sh/docs/vale-cli/installation/"
            fi
        else
            ok "vale already installed"
        fi

        # pandoc-crossref
        if ! command -v pandoc-crossref &>/dev/null; then
            if command -v brew &>/dev/null; then
                brew_install pandoc-crossref
            else
                warn "Install pandoc-crossref manually: https://github.com/lierdakil/pandoc-crossref"
            fi
        else
            ok "pandoc-crossref already installed"
        fi

        apt_install gnuplot
        apt_install diction

        # latexdiff (usually included with texlive)
        if ! command -v latexdiff &>/dev/null; then
            apt_install latexdiff
        else
            ok "latexdiff already installed"
        fi
    fi
}

# ── Install Python tools ────────────────────────────────────────────────────

install_python_deps() {
    header "Python Dependencies"

    if [[ ! -f "${SCRIPT_DIR}/requirements.txt" ]]; then
        fail "requirements.txt not found in ${SCRIPT_DIR}"
        exit 1
    fi

    info "Installing packages from requirements.txt..."
    pip install --quiet --upgrade -r "${SCRIPT_DIR}/requirements.txt"
    ok "requirements.txt installed"

}

# ── Install scite-cli (Node-based) ──────────────────────────────────────────

install_scite_cli() {
    header "scite-cli (Node)"

    if [[ -d "$SCITE_CLI_DIR" ]]; then
        info "scite-cli directory already exists, updating..."
        git -C "$SCITE_CLI_DIR" pull --ff-only || warn "git pull failed — continuing with existing checkout"
    else
        info "Cloning scite-cli..."
        git clone https://github.com/scitedotai/scite-cli.git "$SCITE_CLI_DIR"
    fi

    info "Running npm install..."
    (cd "$SCITE_CLI_DIR" && npm install --silent)

    info "Running npm link..."
    (cd "$SCITE_CLI_DIR" && npm link --silent 2>/dev/null) || warn "npm link failed (may need sudo on Linux)"

    ok "scite-cli set up at ${SCITE_CLI_DIR}"
}

# ── Install Node-based tools ─────────────────────────────────────────────────

install_node_tools() {
    header "Node Tools"

    # mermaid-cli (diagram generation)
    if command -v mmdc &>/dev/null; then
        ok "mermaid-cli already installed"
    else
        info "Installing @mermaid-js/mermaid-cli globally..."
        npm install -g @mermaid-js/mermaid-cli || warn "mermaid-cli install failed"
    fi
}

# ── Create .env from .env.example ────────────────────────────────────────────

setup_env_file() {
    header "Environment File"

    if [[ -f "${SCRIPT_DIR}/.env" ]]; then
        ok ".env already exists — skipping"
    elif [[ -f "${SCRIPT_DIR}/.env.example" ]]; then
        cp "${SCRIPT_DIR}/.env.example" "${SCRIPT_DIR}/.env"
        ok "Created .env from .env.example"
    else
        warn ".env.example not found — skipping .env creation"
    fi
}

# ── Validation ───────────────────────────────────────────────────────────────

declare -a TOOL_NAMES=()
declare -a TOOL_RESULTS=()

check_tool() {
    local name="$1"
    local cmd="$2"
    TOOL_NAMES+=("$name")
    if eval "$cmd" &>/dev/null 2>&1; then
        TOOL_RESULTS+=("PASS")
    else
        TOOL_RESULTS+=("FAIL")
    fi
}

validate_tools() {
    header "Validation"

    # System tools
    check_tool "python3"        "python3 --version"
    check_tool "pip"            "pip --version"
    check_tool "node"           "node --version"
    check_tool "npm"            "npm --version"
    check_tool "pdftotext"      "pdftotext -v"
    check_tool "pandoc"         "pandoc --version"

    # Brew-based tools
    check_tool "nb"             "nb --version"
    check_tool "zk"             "zk --version"

    # Python tools
    check_tool "semantic_bibtool"  "python3 -c 'import semantic_bibtool'"
    check_tool "semanticscholar"   "python3 -c 'import semanticscholar'"
    check_tool "arxiv-dl"          "command -v arxiv-dl || python3 -c 'import arxiv_dl'"
    check_tool "doi2pdf"           "command -v doi2pdf || python3 -c 'import doi2pdf'"
    check_tool "pdf2doi"           "command -v pdf2doi || python3 -c 'import pdf2doi'"
    check_tool "pdfminer"         "python3 -c 'import pdfminer'"
    check_tool "papis"            "papis --version"

    # Prose & writing tools
    check_tool "vale"             "vale --version"
    check_tool "languagetool"     "command -v languagetool"
    check_tool "pandoc-crossref"  "pandoc-crossref --version"
    check_tool "gnuplot"          "gnuplot --version"
    check_tool "style (diction)"  "command -v style"
    check_tool "latexdiff"        "latexdiff --version"

    # Node-based tools
    check_tool "scite-cli"        "command -v scite"
    check_tool "mmdc (mermaid)"   "mmdc --version"
}

print_summary() {
    header "Summary"

    printf "%-22s %s\n" "TOOL" "STATUS"
    printf "%-22s %s\n" "────────────────────" "──────"

    local pass_count=0
    local fail_count=0

    for i in "${!TOOL_NAMES[@]}"; do
        local name="${TOOL_NAMES[$i]}"
        local result="${TOOL_RESULTS[$i]}"
        if [[ "$result" == "PASS" ]]; then
            printf "%-22s ${GREEN}%s${RESET}\n" "$name" "PASS"
            ((pass_count++))
        else
            printf "%-22s ${RED}%s${RESET}\n" "$name" "FAIL"
            ((fail_count++))
        fi
    done

    printf "\n"
    printf "${GREEN}Passed: %d${RESET}  ${RED}Failed: %d${RESET}  Total: %d\n" \
        "$pass_count" "$fail_count" "$(( pass_count + fail_count ))"
}

print_next_steps() {
    header "Next Steps"

    cat <<'NEXT'
1. Edit .env and add your API keys:

     SEMANTIC_SCHOLAR_API_KEY  — free, request at:
       https://www.semanticscholar.org/product/api#Partner-Form

2. Configure papis (reference manager):
     papis init

3. Initialise nb and zk notebooks:
     nb init
     zk init

4. Try a quick smoke test:
     semanticscholar search "cognitive augmentation"
     papis add --from doi 10.1145/3411764.3445243
NEXT
}

# ── Main ─────────────────────────────────────────────────────────────────────

main() {
    printf "\n${BOLD}Academic Research CLI Scaffold — Setup${RESET}\n"
    printf "═══════════════════════════════════════════\n\n"

    detect_platform
    install_system_deps
    install_python_deps
    install_scite_cli
    install_node_tools
    setup_env_file
    validate_tools
    print_summary
    print_next_steps

    printf "\n${GREEN}${BOLD}Setup complete.${RESET}\n\n"
}

main "$@"
