#!/usr/bin/env bash
# One-command Mac restore. Safe to re-run.
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nazrulislambhat/mac/main/install.sh)"
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/nazrulislambhat/mac/main"
NODE_VERSION="22"
FAILED=0

say() { printf "\n\033[1;34m==> %s\033[0m\n" "$*"; }

[[ "$(uname)" == "Darwin" ]] || { echo "This script is for macOS only."; exit 1; }

# 1. Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  say "Installing Xcode Command Line Tools (accept the dialog that pops up)"
  xcode-select --install || true
  until xcode-select -p >/dev/null 2>&1; do sleep 5; done
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  say "Installing Homebrew (may ask for your password)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x "$p" ]]; then eval "$("$p" shellenv)"; break; fi
done
BREW_BIN="$(command -v brew)"

# 3. Find the Brewfile (next to this script, or download it)
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-}")" 2>/dev/null && pwd || true)"
if [[ -n "$HERE" && -f "$HERE/Brewfile" ]]; then
  BREWFILE="$HERE/Brewfile"
else
  BREWFILE="$(mktemp -d)/Brewfile"
  curl -fsSL "$REPO_RAW/Brewfile" -o "$BREWFILE"
fi

# 4. Install everything
say "Installing apps, CLI tools and VS Code extensions"
brew update
brew bundle --file="$BREWFILE" || FAILED=1

# 5. Node via nvm
say "Installing Node $NODE_VERSION"
export NVM_DIR="$HOME/.nvm"; mkdir -p "$NVM_DIR"
NVM_SH="$(brew --prefix)/opt/nvm/nvm.sh"
if [[ -s "$NVM_SH" ]]; then
  set +eu
  # shellcheck disable=SC1090
  . "$NVM_SH"
  nvm install "$NODE_VERSION" && nvm alias default "$NODE_VERSION" && npm install -g vercel || FAILED=1
  set -eu
else
  echo "nvm not found, skipping Node."; FAILED=1
fi

# 6. Shell config (only adds lines that aren't already there)
say "Wiring up your shell"
touch "$HOME/.zshrc" "$HOME/.zprofile"
grep -q 'brew shellenv' "$HOME/.zprofile" || echo "eval \"\$($BREW_BIN shellenv)\"" >> "$HOME/.zprofile"
grep -q 'nvm.sh' "$HOME/.zshrc" || cat >> "$HOME/.zshrc" <<'ZSH'

# nvm (added by mac)
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
ZSH
grep -q 'powerlevel10k' "$HOME/.zshrc" || cat >> "$HOME/.zshrc" <<'ZSH'

# powerlevel10k (added by mac)
source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
ZSH

say "Done. Open a new terminal window."
if [[ "$FAILED" -ne 0 ]]; then
  echo "Some items failed. Scroll up, or re-run this script; brew skips what is already installed."
  echo "Mac App Store apps need you to be signed in to the App Store first."
fi
echo "Manual installs: Mi Home, Samsung Smart Switch (not in Homebrew)."
