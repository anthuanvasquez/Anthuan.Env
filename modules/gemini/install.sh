#!/usr/bin/env bash

echo "Setting up Gemini CLI..."

if ! command -v gemini &>/dev/null; then
    echo "   [SKIP] gemini-cli not found. Install via: brew install gemini-cli"
    exit 0
fi

echo "✅ Gemini CLI is ready."
