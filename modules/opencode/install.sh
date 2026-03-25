#!/usr/bin/env bash

echo "Setting up OpenCode..."

if ! command -v opencode &>/dev/null; then
    echo "   [SKIP] opencode not found."
    exit 0
fi

echo "✅ OpenCode is ready."
