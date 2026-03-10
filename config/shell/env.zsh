# Global Environment Variables
export DOTFILES="$HOME/dotfiles"
export EDITOR="code"
export PATH="$HOME/bin:$HOME/.local/bin:$DOTFILES/bin:$PATH"

# Personal PATH additions
export PATH="$HOME/.cargo/bin:$PATH"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Specific tool paths
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
