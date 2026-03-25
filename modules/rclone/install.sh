#!/usr/bin/env bash

echo "Setting up rclone..."

if ! command -v rclone &>/dev/null; then
    echo "   [SKIP] rclone not found. Install via: brew install rclone"
    exit 0
fi

echo "✅ rclone is ready. Configure remotes with: rclone config"
