# FAANG-style .zshrc
# Keep this file minimal. Real logic lives in ~/dotfiles/config/shell/

# Define base path
export DOTFILES="$HOME/dotfiles"

# 1. Load Environment Variables
source "$DOTFILES/config/shell/env.zsh"

# 2. Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

# 3. Load Modules Logic
source "$DOTFILES/config/shell/aliases.zsh"
source "$DOTFILES/config/shell/functions.zsh"

# Load OS-specific configuration if exists
if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$DOTFILES/config/shell/macos_aliases.zsh"
fi

# 4. Tool Initializations
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(rbenv init -)"
eval "$(pyenv init - zsh)"

# Load Angular CLI autocompletion.
source <(ng completion script)
