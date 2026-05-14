#!/bin/bash
# Setup script for agent-team system

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Agent Team System..."

mkdir -p "$SCRIPT_DIR/.claude"

# Copy .env if doesn't exist
if [ ! -f "$SCRIPT_DIR/.claude/.env" ]; then
    cp "$SCRIPT_DIR/project/.env.example" "$SCRIPT_DIR/.claude/.env"
    echo "Created .claude/.env - Add your ANTHROPIC_AUTH_TOKEN"
else
    echo ".claude/.env already exists"
fi

# Copy settings.local.json if doesn't exist
if [ ! -f "$SCRIPT_DIR/.claude/settings.local.json" ]; then
    cp "$SCRIPT_DIR/project/config.json" "$SCRIPT_DIR/.claude/settings.local.json"
    echo "Created .claude/settings.local.json"
else
    echo ".claude/settings.local.json already exists"
fi

# Add to .gitignore if not present
if ! grep -q ".claude/.env" "$SCRIPT_DIR/.gitignore" 2>/dev/null; then
    echo ".claude/.env" >> "$SCRIPT_DIR/.gitignore"
    echo "Added .claude/.env to .gitignore"
fi

echo ""
echo "Setup complete!"
echo "1. Edit .claude/.env and add your ANTHROPIC_AUTH_TOKEN"
echo "2. Customize .claude/settings.local.json if needed"