# Frontend Stack Profile
# Usage: source profiles/frontend.sh

echo "🎨 Loading Frontend Development Stack..."

# Node.js (fnm)
if command -v fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Package Manager Config
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Framework Aliases
alias nr="npm run"
alias ns="npm start"
alias pr="pnpm run"
alias ps="pnpm start"
alias ag="ng" # Angular CLI

# Theme (Optional override)
# export ZSH_THEME="frontend-theme"

echo "✅ Frontend stack ready (Node, pnpm, Angular/Vue)."
