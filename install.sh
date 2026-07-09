#!/usr/bin/env bash
# ============================================================
# install-nvim-config.sh
# Backs up existing Neovim config and installs from:
# https://github.com/MahmoudDolah/neovim-configs
# ============================================================

set -euo pipefail

REPO_URL="https://github.com/MahmoudDolah/neovim-configs.git"
NVIM_CONFIG_DIR="${HOME}/.config/nvim"
BACKUP_DIR="${HOME}/.config/nvim.bak.$(date +%Y%m%d_%H%M%S)"

# ── Colors ───────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # no color

info() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() {
  echo -e "${RED}[✗]${NC} $1"
  exit 1
}

# ── Dependency checks ─────────────────────────────────────────
echo ""
echo "Checking dependencies..."
echo ""

# Neovim
if ! command -v nvim &>/dev/null; then
  error "Neovim not found. Install via bob: https://github.com/MordechaiHadad/bob"
fi
NVIM_VERSION=$(nvim --version | head -1 | grep -oP '\d+\.\d+\.\d+')
NVIM_MINOR=$(echo "$NVIM_VERSION" | cut -d. -f2)
if [ "$NVIM_MINOR" -lt 9 ]; then
  error "Neovim >= 0.9 required. Found v${NVIM_VERSION}. Upgrade via: bob install latest && bob use latest"
fi
info "Neovim v${NVIM_VERSION}"

# Git
if ! command -v git &>/dev/null; then
  error "git not found. Install with: sudo apt install git"
fi
info "git $(git --version | awk '{print $3}')"

# ripgrep
if ! command -v rg &>/dev/null; then
  warn "ripgrep not found — Telescope live grep won't work. Install with: sudo apt install ripgrep"
else
  info "ripgrep $(rg --version | head -1 | awk '{print $2}')"
fi

# make (for telescope-fzf-native)
if ! command -v make &>/dev/null; then
  warn "make not found — telescope-fzf-native won't build. Install with: sudo apt install build-essential"
else
  info "make $(make --version | head -1 | awk '{print $3}')"
fi

# Nerd Font reminder (can't verify programmatically)
warn "Nerd Font: make sure your terminal is using one — icons in nvim-tree and lualine won't render otherwise."
warn "Download from: https://www.nerdfonts.com/font-downloads"

echo ""

# ── Backup existing config ────────────────────────────────────
if [ -d "$NVIM_CONFIG_DIR" ]; then
  info "Backing up existing config to ${BACKUP_DIR}"
  mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
else
  info "No existing Neovim config found — skipping backup"
fi

# ── Clone repo ────────────────────────────────────────────────
info "Cloning neovim-configs into ${NVIM_CONFIG_DIR}"
git clone --depth=1 "$REPO_URL" "$NVIM_CONFIG_DIR"

# ── Done ──────────────────────────────────────────────────────
echo ""
info "Done. Open nvim — lazy.nvim will bootstrap and install all plugins on first launch."
if [ -d "$BACKUP_DIR" ]; then
  info "Your old config is saved at: ${BACKUP_DIR}"
fi
echo ""
