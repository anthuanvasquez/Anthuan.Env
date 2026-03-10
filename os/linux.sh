#!/usr/bin/env bash
# linux.sh: Linux specific system settings.

echo "🐧 Applying Linux system settings..."

# 1. Ensure Zsh is the default shell
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "   [ZSH] Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

# 2. Add specific Linux aliases if needed
# source "$DOTFILES/config/shell/linux_aliases.zsh"

echo "✅ Linux settings applied."
