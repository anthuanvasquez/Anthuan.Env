# Infrastructure & Cloud Stack Profile
# Usage: source profiles/infra.sh

echo "☁️ Loading Cloud & Infra Stack..."

# Kubernetes (kubectl + aliases)
if command -v kubectl &>/dev/null; then
    alias k="kubectl"
    source <(kubectl completion zsh)
fi

# Terraform
if command -v terraform &>/dev/null; then
    alias tf="terraform"
fi

# Cloud CLI
# export AWS_PROFILE="default"
# export GOOGLE_APPLICATION_CREDENTIALS="path/to/creds.json"

echo "✅ Infrastructure stack ready (Kubernetes, Terraform, Cloud Tools)."
