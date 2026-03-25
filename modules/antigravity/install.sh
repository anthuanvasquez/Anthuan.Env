#!/usr/bin/env bash

echo "Setting up Antigravity extensions..."

# Antigravity uses Open VSX marketplace
# Check if antigravity CLI is available
if ! command -v antigravity &>/dev/null; then
    echo "   [SKIP] antigravity CLI not found. Install Antigravity IDE first."
    exit 0
fi

extensions=(
    # Editor essentials
    editorconfig.editorconfig
    esbenp.prettier-vscode
    dbaeumer.vscode-eslint
    formulahendry.auto-rename-tag
    christian-kohler.path-intellisense
    christian-kohler.npm-intellisense
    mikestead.dotenv
    gruntfuggly.todo-tree
    oderwat.indent-rainbow

    # Git
    eamodio.gitlens
    vivaxy.vscode-conventional-commits

    # TypeScript / JavaScript
    yoavbls.pretty-ts-errors
    dsznajder.es7-react-js-snippets

    # Frameworks
    bradlc.vscode-tailwindcss
    vue.volar
    astro-build.astro-vscode
    unifiedjs.vscode-mdx

    # Theme & Icons
    enkia.tokyo-night
    vscode-icons-team.vscode-icons

    # YAML / Config
    redhat.vscode-yaml
)

for extension in "${extensions[@]}"; do
    antigravity --install-extension "$extension" --force 2>/dev/null || \
        echo "   [WARN] Could not install: $extension"
done

echo "✅ Antigravity extensions installed."