#!/usr/bin/env bash
# doctor.sh — validates WSL/Linux terminal environment alignment with env-setup guide

set -euo pipefail

# ANSI Color Codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

WORK_MODE=false
# Parse arguments
for arg in "$@"; do
  if [[ "$arg" == "--work" ]]; then
    WORK_MODE=true
  fi
done

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}          ✨ WSL Workstation Doctor ✨               ${NC}"
echo -e -n "${CYAN}  Mode: "
if [ "$WORK_MODE" = true ]; then
  echo -e "${YELLOW}Work / Corporate Machine 🏢${NC}"
else
  echo -e "${GREEN}Personal / Home Machine 🏠${NC}"
fi
echo -e "${CYAN}====================================================${NC}"
echo ""

ERRORS=0
WARNINGS=0
RETIRED_FOUND=0

# Helper function to check required tools
check_required_tool() {
  local name="$1"
  local cmd="$2"
  local install_cmd="$3"
  
  if command -v "$cmd" >/dev/null 2>&1; then
    # Try to verify if it's managed by mise (if applicable)
    if [[ "$install_cmd" == *"mise"* ]]; then
      if command -v mise >/dev/null 2>&1; then
        if mise which "$cmd" >/dev/null 2>&1; then
          echo -e "  [${GREEN}✅ OK${NC}] $name (managed by mise)"
        else
          echo -e "  [${YELLOW}⚠️ WARN${NC}] $name exists, but does not seem to be managed by mise!"
          echo -e "           -> Recommendation: migrate to mise via '${install_cmd}'"
          (( WARNINGS++ )) || true
        fi
      else
        # cmd exists, but mise does NOT! This is a major pitfall/conflict, especially for node
        if [[ "$cmd" == "node" ]]; then
          echo -e "  [${YELLOW}⚠️ WARN${NC}] $name is installed, but mise is NOT installed!"
          echo -e "           -> CRITICAL MIGRATION WARNING: You must first UNINSTALL your pre-existing Node.js"
          echo -e "              (via Volta, NVM, or apt) BEFORE installing/migrating to mise."
          echo -e "              Otherwise, PATH conflicts will break your terminal Node version."
          echo -e "              See: [wsl/migrate-to-mise.md](wsl/migrate-to-mise.md) for details."
          (( WARNINGS++ )) || true
        else
          echo -e "  [${YELLOW}⚠️ WARN${NC}] $name exists, but mise is not installed to manage it!"
          echo -e "           -> Recommendation: Install mise, then migrate $name."
          (( WARNINGS++ )) || true
        fi
      fi
    else
      echo -e "  [${GREEN}✅ OK${NC}] $name"
    fi
  else
    echo -e "  [${RED}❌ MISSING${NC}] $name"
    echo -e "             -> Install via: ${install_cmd}"
    (( ERRORS++ )) || true
  fi
}

# Helper function to check retired tools
check_retired_tool() {
  local name="$1"
  local test_path="$2" # Can be a command name or a file path
  local removal_desc="$3"
  
  local found=false
  if [[ "$test_path" == /* ]]; then
    if [[ -d "$test_path" || -f "$test_path" ]]; then
      found=true
    fi
  else
    if command -v "$test_path" >/dev/null 2>&1; then
      found=true
    fi
  fi

  if [ "$found" = true ]; then
    echo -e "  [${RED}🗑️ RETIRED${NC}] $name found!"
    echo -e "               -> Recommendation: $removal_desc"
    (( RETIRED_FOUND++ )) || true
  fi
}

# ── 1. ACTIVE / REQUIRED TOOLSTACK ──────────────────────────────────────────
echo -e "${BLUE}--- Checking Core Required Toolstack ---${NC}"

# Check mise
if command -v mise >/dev/null 2>&1; then
  echo -e "  [${GREEN}✅ OK${NC}] mise (Polyglot Tool Manager)"
else
  echo -e "  [${RED}❌ MISSING${NC}] mise"
  echo -e "             -> Install via: curl https://mise.run | sh"
  (( ERRORS++ )) || true
fi

# Core tools managed by mise in both configurations
check_required_tool "Node.js" "node" "mise use --global node@lts"
check_required_tool "Python" "python" "mise use --global python@3.13"
check_required_tool "Neovim" "nvim" "mise use --global neovim@stable"
check_required_tool "GitHub CLI" "gh" "mise use --global gh@latest"
check_required_tool "Python UV" "uv" "mise use --global uv@latest"

# Check Tree-Sitter-CLI (npm package)
if command -v tree-sitter >/dev/null 2>&1; then
  echo -e "  [${GREEN}✅ OK${NC}] tree-sitter-cli"
else
  echo -e "  [${RED}❌ MISSING${NC}] tree-sitter-cli"
  echo -e "             -> Install via: mise use --global npm:tree-sitter-cli"
  (( ERRORS++ )) || true
fi

# Configured AI assistants depending on mode
if [ "$WORK_MODE" = true ]; then
  # Work configuration requires Claude Code
  check_required_tool "Claude Code" "claude" "mise use --global npm:@anthropic-ai/claude-code"
else
  # Personal/Home configuration requires Google Antigravity CLI (agy)
  if command -v agy >/dev/null 2>&1; then
    echo -e "  [${GREEN}✅ OK${NC}] Google Antigravity CLI (agy)"
    # Check settings file presence
    if [ -f "$HOME/.gemini/antigravity-cli/settings.json" ]; then
      echo -e "  [${GREEN}✅ OK${NC}] Antigravity CLI settings.json exists"
    else
      echo -e "  [${YELLOW}⚠️  NOTE${NC}] Antigravity settings.json not found (will be created on first login)"
    fi
  else
    echo -e "  [${RED}❌ MISSING${NC}] Google Antigravity CLI (agy)"
    echo -e "             -> Ensure Antigravity CLI is preinstalled in your home terminal."
    (( ERRORS++ )) || true
  fi

  # SQLite3 & Harlequin checks for personal home database utilities
  check_required_tool "SQLite3 CLI" "sqlite3" "sudo apt update && sudo apt install sqlite3"
  
  if command -v harlequin >/dev/null 2>&1; then
    echo -e "  [${GREEN}✅ OK${NC}] Harlequin SQL Client"
  else
    echo -e "  [${YELLOW}⚠️ WARN${NC}] Harlequin SQL TUI client is missing"
    echo -e "           -> Recommended: Install via 'uv tool install harlequin'"
    (( WARNINGS++ )) || true
  fi
fi

# Check Git credential helper configuration
if command -v gh >/dev/null 2>&1; then
  # gh auth setup-git configures domain-specific helpers (e.g. credential.https://github.com.helper) instead of the top-level credential.helper
  if git config --global --get-regexp "credential\..*helper" 2>/dev/null | grep -q "gh" >/dev/null 2>&1 || git config --global credential.helper 2>/dev/null | grep -q "gh" >/dev/null 2>&1; then
    echo -e "  [${GREEN}✅ OK${NC}] Git credential helper configured to use GitHub CLI (gh)"
  else
    echo -e "  [${YELLOW}⚠️ WARN${NC}] Git credential helper is NOT configured to use GitHub CLI"
    echo -e "           -> Recommendation: run 'gh auth setup-git'"
    (( WARNINGS++ )) || true
  fi
fi

echo ""

# ── 2. SHELL PROFILE CONFIGURATION CHECK (~/.bashrc) ─────────────────────────
echo -e "${BLUE}--- Inspecting ~/.bashrc Environment Configuration ---${NC}"
BASHRC="$HOME/.bashrc"
if [ -f "$BASHRC" ]; then
  # Check mise activation
  if grep -q "mise activate bash" "$BASHRC"; then
    echo -e "  [${GREEN}✅ OK${NC}] mise activation hook found in ~/.bashrc"
  else
    echo -e "  [${RED}❌ MISSING${NC}] mise activation hook in ~/.bashrc"
    echo -e "             -> Recommendation: Run 'echo '\''eval \"\$(~/.local/bin/mise activate bash)\"'\'' >> ~/.bashrc'"
    (( ERRORS++ )) || true
  fi

  # Check wslview / BROWSER integration (extremely important for browser authentication on WSL)
  if grep -q "export BROWSER=wslview" "$BASHRC" || grep -q "export BROWSER=\"wslview\"" "$BASHRC"; then
    echo -e "  [${GREEN}✅ OK${NC}] BROWSER=wslview is declared in ~/.bashrc"
  else
    echo -e "  [${YELLOW}⚠️ WARN${NC}] BROWSER=wslview is missing from ~/.bashrc (authenticating via gh/GCM might fail to open your Windows browser)"
    echo -e "           -> Recommendation: Run 'echo '\''export BROWSER=wslview'\'' >> ~/.bashrc'"
    (( WARNINGS++ )) || true
  fi

  # GCM & Work specific bashrc variables
  if [ "$WORK_MODE" = true ]; then
    # GPG_TTY export for sign-ins
    if grep -q "export GPG_TTY=" "$BASHRC" || grep -q "GPG_TTY=\$(tty)" "$BASHRC"; then
      echo -e "  [${GREEN}✅ OK${NC}] export GPG_TTY=\$(tty) found in ~/.bashrc"
    else
      echo -e "  [${YELLOW}⚠️ WARN${NC}] GPG_TTY is not exported. GPG passphrase prompts might fail in this shell."
      echo -e "           -> Recommendation: Run 'echo '\''export GPG_TTY=\$(tty)'\'' >> ~/.bashrc'"
      (( WARNINGS++ )) || true
    fi

    # Dotnet tools in PATH
    if grep -q "\.dotnet/tools" "$BASHRC" || [[ "$PATH" == *".dotnet/tools"* ]]; then
      echo -e "  [${GREEN}✅ OK${NC}] .dotnet/tools path configuration found"
    else
      echo -e "  [${YELLOW}⚠️ WARN${NC}] ~/.dotnet/tools is not on your PATH or in ~/.bashrc"
      echo -e "           -> Recommendation: Run 'echo '\''export PATH=\"\$PATH:\$HOME/.dotnet/tools\"'\'' >> ~/.bashrc'"
      (( WARNINGS++ )) || true
    fi
  fi
else
  echo -e "  [${RED}❌ ERROR${NC}] ~/.bashrc file not found!"
  (( ERRORS++ )) || true
fi

echo ""

# ── 3. RETIRED / DEPRECATED TOOLS ─────────────────────────────────────────────
echo -e "${BLUE}--- Checking for Retired / Deprecated Tools ---${NC}"

check_retired_tool "Bob (Neovim Manager)" "bob" "Remove Neovim Bob manager: run 'rm -rf ~/.local/share/bob' and clear path bindings in ~/.bashrc"
check_retired_tool "Pyenv (Python Manager)" "pyenv" "Remove Pyenv: run 'rm -rf ~/.pyenv' and remove PYENV lines from ~/.bashrc"
check_retired_tool "Volta (Node Manager)" "volta" "Remove Volta: run 'rm -rf ~/.volta' and remove VOLTA lines from ~/.bashrc"
check_retired_tool "NVM (Node Version Manager)" "$HOME/.nvm" "Remove NVM: run 'rm -rf ~/.nvm' and remove NVM lines from ~/.bashrc"
check_retired_tool "ASDF Version Manager" "$HOME/.asdf" "Remove ASDF: run 'rm -rf ~/.asdf' and remove ASDF lines from ~/.bashrc"
check_retired_tool "Homebrew (WSL)" "brew" "Remove Homebrew if not needed for work/home: run '/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)\"'"

# Check SSH Keys (deprecated/removed in favor of gh CLI and HTTPS)
SSH_KEYS=$(find "$HOME/.ssh" -type f \( -name "id_rsa" -o -name "id_ed25519" -o -name "id_git-*" \) 2>/dev/null || true)
if [[ -n "$SSH_KEYS" ]]; then
  echo -e "  [${YELLOW}⚠️  NOTE${NC}] Found standard/legacy SSH Keys in ~/.ssh/"
  echo -e "           -> Since setup uses GitHub CLI and HTTPS, you can safely remove these"
  echo -e "              keys if you do not use them for other setups/platforms."
fi

# In personal mode, Claude Code is retired (use Antigravity instead)
if [ "$WORK_MODE" = false ]; then
  check_retired_tool "Claude Code (Work Only)" "claude" "Uninstall Claude Code on Home PC: run 'mise uninstall npm:@anthropic-ai/claude-code'"
fi

if [ "$RETIRED_FOUND" -eq 0 ]; then
  echo -e "  [${GREEN}✅ OK${NC}] Clean toolstack! No retired or conflicting tools found."
fi

echo ""

# ── 4. WORK ENVIRONMENT ONLY CHECKS ───────────────────────────────────────────
if [ "$WORK_MODE" = true ]; then
  echo -e "${BLUE}--- Checking Work-Specific Toolstack (GCM & Azure DevOps) ---${NC}"
  
  # Check Dotnet SDK 8.0+
  if command -v dotnet >/dev/null 2>&1; then
    if dotnet --list-sdks | grep -E "^8\.[0-9]+" >/dev/null 2>&1; then
      echo -e "  [${GREEN}✅ OK${NC}] .NET SDK 8.0+ is installed"
    else
      echo -e "  [${YELLOW}⚠️ WARN${NC}] .NET SDK is installed, but no 8.0 SDK was found!"
      echo -e "           -> Run: sudo apt install dotnet-sdk-8.0"
      (( WARNINGS++ )) || true
    fi
  else
    echo -e "  [${RED}❌ MISSING${NC}] .NET SDK 8.0 (Required for GCM Azure DevOps auth)"
    echo -e "             -> Run: sudo apt update && sudo apt install dotnet-sdk-8.0"
    (( ERRORS++ )) || true
  fi

  # Check GCM (Git Credential Manager)
  if command -v git-credential-manager >/dev/null 2>&1 || command -v git-credential-manager-core >/dev/null 2>&1; then
    echo -e "  [${GREEN}✅ OK${NC}] Git Credential Manager (GCM)"
  else
    echo -e "  [${RED}❌ MISSING${NC}] Git Credential Manager (GCM)"
    echo -e "             -> Run: dotnet tool install -g git-credential-manager"
    (( ERRORS++ )) || true
  fi

  # Check GPG, Pass, GNOME Keyring
  check_required_tool "GnuPG (GPG)" "gpg" "sudo apt install gpg"
  check_required_tool "Pass (Password Store)" "pass" "sudo apt install pass"
  
  # Check if gnome-keyring systemd daemon is active
  if systemctl --user is-active gnome-keyring-daemon.service >/dev/null 2>&1; then
    echo -e "  [${GREEN}✅ OK${NC}] GNOME Keyring systemd daemon is active"
  else
    echo -e "  [${YELLOW}⚠️ WARN${NC}] GNOME Keyring systemd daemon is NOT active!"
    echo -e "           -> Run: systemctl --user enable gnome-keyring-daemon.service && systemctl --user start gnome-keyring-daemon.service"
    (( WARNINGS++ )) || true
  fi

  # Check credential helper store configuration
  if git config --global credential.credentialstore | grep -q "gpg" >/dev/null 2>&1; then
    echo -e "  [${GREEN}✅ OK${NC}] GCM credential store set to 'gpg'"
  else
    echo -e "  [${YELLOW}⚠️ WARN${NC}] Git credential.credentialstore is NOT set to 'gpg'"
    echo -e "           -> Run: git config --global credential.credentialstore gpg"
    (( WARNINGS++ )) || true
  fi
else
  # If not work mode, output a passive status
  echo -e "${BLUE}--- Work-Specific Toolstack (GCM & Azure DevOps) ---${NC}"
  echo -e "  [${CYAN}⏭️  SKIPPED${NC}] Running on personal machine (pass --work to enable GCM/.NET checks)"
fi

echo ""

# ── SUMMARY ───────────────────────────────────────────────────────────────────
echo -e "${CYAN}=================== Summary =======================${NC}"
echo -e "  Errors (Missing Core Tools):     ${RED}$ERRORS${NC}"
echo -e "  Warnings (Outdated/Misconfigs):  ${YELLOW}$WARNINGS${NC}"
echo -e "  Retired Tools Found:             ${RED}$RETIRED_FOUND${NC}"
echo -e "${CYAN}====================================================${NC}"

if [ "$ERRORS" -gt 0 ] || [ "$RETIRED_FOUND" -gt 0 ]; then
  echo -e "${YELLOW}💡 Action Required: Please resolve the errors and remove retired tools listed above to align with the env-setup guide.${NC}"
  exit 1
elif [ "$WARNINGS" -gt 0 ]; then
  echo -e "${YELLOW}💡 Action Recommended: Setup is working, but minor adjustments/upgrades are suggested.${NC}"
  exit 0
else
  echo -e "${GREEN}🎉 Awesome! Your terminal environment is perfectly aligned with the env-setup guide!${NC}"
  exit 0
fi
