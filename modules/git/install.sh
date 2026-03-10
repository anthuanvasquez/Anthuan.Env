#!/usr/bin/env bash
# modules/git/install.sh: Programmatic Git configuration.

set -e

echo "📦 Configuring Git..."

# Global settings (Replace with your actual data if needed)
git config --global user.name "Anthuan Vasquez"
git config --global user.email "anthuan@vasquez.dev"

# Preferences
git config --global core.editor "code --wait"
git config --global push.default current
git config --global pull.rebase true
git config --global init.defaultBranch master

# Delta (Rich diffs)
if command -v delta &>/dev/null; then
  git config --global core.pager "delta"
  git config --global interactive.diffFilter "delta --color-only"
  git config --global delta.navigate true
  git config --global delta.light false
  git config --global delta.side-by-side true
fi

echo "✅ Git configuration updated."
