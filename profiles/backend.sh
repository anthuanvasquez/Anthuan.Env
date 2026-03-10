# Backend Stack Profile
# Usage: source profiles/backend.sh

echo "⚙️ Loading Backend Development Stack..."

# Go Configuration
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python (pyenv)
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init - zsh)"
  eval "$(pyenv init --path)"
fi

# Tools
alias db="docker-compose exec -T db"
alias logs="docker-compose logs -f"

echo "✅ Backend stack ready (Go, Python, Docker flows)."
