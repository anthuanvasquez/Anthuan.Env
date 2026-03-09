#!/usr/bin/env bash

set -e

echo "======================================"
echo "    Installation Tool                 "
echo "======================================"

## Validate: check the OS to install scripts.

# Determine directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "1. Installing via Homebrew..."
bash "$DIR/brew.sh"

echo "2. Setting up Node.js..."
bash "$DIR/node.sh"

echo "3. Setting up Python..."
bash "$DIR/python.sh"

echo "4. Setting up VS Code..."
bash "$DIR/_VSCode/vscode.sh"

## check os mac/wsl



echo "5. Setting up macOS defaults..."
bash "$DIR/_Osx/macos.sh

echo "======================================"
echo "    Installation Complete! 🚀         "
echo "======================================"
echo "Please restart your terminal."
