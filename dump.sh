#!/usr/bin/env bash
# Refresh the Brewfile from what is installed on this Mac right now.
# Review the diff before committing: `git diff Brewfile`
set -euo pipefail
cd "$(dirname "$0")"
brew bundle dump --file=Brewfile --force --tap --formula --cask --mas --vscode
git --no-pager diff --stat Brewfile || true
