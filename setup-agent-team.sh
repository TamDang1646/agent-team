#!/bin/bash
# One-command install Agent Team System
# Copy this to your project root and run: ./setup-agent-team.sh

set -e

REPO="git@github.com:yourorg/agent-team.git"
CLAUDE_DIR=".claude"

echo "=== Installing Agent Team System ==="

# Create .claude directory
mkdir -p "$CLAUDE_DIR"

# Clone to temp
TMP_DIR=$(mktemp -d)
git clone --depth 1 "$REPO" "$TMP_DIR" 2>/dev/null || {
    echo "Failed to clone from $REPO"
    echo "Please check the repository URL and your git credentials."
    rm -rf "$TMP_DIR"
    exit 1
}

# Copy all required directories
echo "Copying agents..."
[ -d "$TMP_DIR/.claude/agents" ] && cp -r "$TMP_DIR/.claude/agents" "$CLAUDE_DIR/"

echo "Copying subagents..."
[ -d "$TMP_DIR/.claude/subagents" ] && cp -r "$TMP_DIR/.claude/subagents" "$CLAUDE_DIR/"

echo "Copying skills..."
[ -d "$TMP_DIR/.claude/skills" ] && cp -r "$TMP_DIR/.claude/skills" "$CLAUDE_DIR/"

# Copy root files if not exist
[ ! -f "CLAUDE.md" ] && cp "$TMP_DIR/CLAUDE.md" .
[ ! -f "AGENT_RULES.md" ] && cp "$TMP_DIR/AGENT_RULES.md" .
[ ! -f "CODING_STANDARDS.md" ] && cp "$TMP_DIR/CODING_STANDARDS.md" .

# Create .env template if not exists
if [ ! -f "$CLAUDE_DIR/.env" ]; then
    echo "Creating .env template..."
    cat > "$CLAUDE_DIR/.env" << 'EOF'
ANTHROPIC_AUTH_TOKEN=your_token_here
EOF
fi

# Cleanup
rm -rf "$TMP_DIR"

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Edit $CLAUDE_DIR/.env and add your ANTHROPIC_AUTH_TOKEN"
echo "2. Run: claude"
echo "3. Type: /agent-team \"Build REST API\""
echo ""
echo "Files installed:"
ls -la "$CLAUDE_DIR/agents/" 2>/dev/null | head -5
ls -la "$CLAUDE_DIR/subagents/" 2>/dev/null | head -5