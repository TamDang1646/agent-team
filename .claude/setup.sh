#!/bin/bash
# One-command install Agent Team System from GitHub
# Run this in your project directory:
#   curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash

set -e

REPO="${AGENT_TEAM_REPO:-https://github.com/TamDang1646/agent-team.git}"
BRANCH="${AGENT_TEAM_BRANCH:-main}"
CLAUDE_DIR=".claude"

echo "=== Installing Agent Team System ==="
echo "Repo: $REPO@$BRANCH"

# Check if already installed
if [ -d "$CLAUDE_DIR/agents" ] && [ -d "$CLAUDE_DIR/subagents" ]; then
    echo "⚠️  Agent Team already installed."
    read -p "Reinstall? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Create .claude directory
mkdir -p "$CLAUDE_DIR"

# Clone to temp
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo "Cloning from $REPO..."
git clone --branch "$BRANCH" --depth 1 "$REPO" "$TMP_DIR" 2>&1 | head -5 || {
    echo "❌ Failed to clone. Check repo URL and git credentials."
    exit 1
}

# Copy all required directories into .claude/
echo "Installing agents..."
[ -d "$TMP_DIR/.claude/agents" ] && cp -r "$TMP_DIR/.claude/agents" "$CLAUDE_DIR/"

echo "Installing subagents..."
[ -d "$TMP_DIR/.claude/subagents" ] && cp -r "$TMP_DIR/.claude/subagents" "$CLAUDE_DIR/"

echo "Installing skills..."
[ -d "$TMP_DIR/.claude/skills" ] && cp -r "$TMP_DIR/.claude/skills" "$CLAUDE_DIR/"

echo "Installing core/..."
[ -d "$TMP_DIR/.claude/core" ] && cp -r "$TMP_DIR/.claude/core" "$CLAUDE_DIR/"

echo "Installing project/..."
[ -d "$TMP_DIR/.claude/project" ] && cp -r "$TMP_DIR/.claude/project" "$CLAUDE_DIR/"

echo "Installing templates/..."
[ -d "$TMP_DIR/.claude/templates" ] && cp -r "$TMP_DIR/.claude/templates" "$CLAUDE_DIR/"

# Copy root files
echo "Copying documentation..."
[ ! -f "CLAUDE.md" ] && cp "$TMP_DIR/CLAUDE.md" . && echo "  CLAUDE.md"
[ ! -f "AGENT_RULES.md" ] && cp "$TMP_DIR/AGENT_RULES.md" . && echo "  AGENT_RULES.md"
[ ! -f "CODING_STANDARDS.md" ] && cp "$TMP_DIR/CODING_STANDARDS.md" . && echo "  CODING_STANDARDS.md"

# Copy settings template if settings.local.json doesn't exist
if [ ! -f "$CLAUDE_DIR/settings.local.json" ]; then
    if [ -f "$TMP_DIR/.claude/settings.example.json" ]; then
        cp "$TMP_DIR/.claude/settings.example.json" "$CLAUDE_DIR/settings.local.json"
        echo "Created settings.local.json from template"
    fi
fi

# Copy MCP servers template if mcp-servers.local.json doesn't exist
if [ ! -f "$CLAUDE_DIR/mcp-servers.local.json" ]; then
    if [ -f "$TMP_DIR/.claude/mcp-servers.example.json" ]; then
        cp "$TMP_DIR/.claude/mcp-servers.example.json" "$CLAUDE_DIR/mcp-servers.local.json"
        echo "Created mcp-servers.local.json from template"
    fi
fi

# Create .env template
if [ ! -f "$CLAUDE_DIR/.env" ]; then
    echo "Creating .env template..."
    cat > "$CLAUDE_DIR/.env" << 'EOF'
# Add your Anthropic API token here
ANTHROPIC_AUTH_TOKEN=your_token_here
EOF
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Files installed:"
echo "  $CLAUDE_DIR/agents/         ($(ls $CLAUDE_DIR/agents 2>/dev/null | wc -l) agents)"
echo "  $CLAUDE_DIR/subagents/      ($(ls $CLAUDE_DIR/subagents 2>/dev/null | wc -l) subagents)"
echo "  $CLAUDE_DIR/skills/         ($(ls $CLAUDE_DIR/skills 2>/dev/null | wc -l) skills)"
echo "  $CLAUDE_DIR/core/           ($(ls $CLAUDE_DIR/core 2>/dev/null | wc -l) files)"
echo "  $CLAUDE_DIR/project/        ($(ls $CLAUDE_DIR/project 2>/dev/null | wc -l) files)"
echo "  $CLAUDE_DIR/templates/      ($(ls $CLAUDE_DIR/templates 2>/dev/null | wc -l) files)"
echo "  ./CLAUDE.md"
echo "  ./AGENT_RULES.md"
echo "  ./CODING_STANDARDS.md"
echo ""
echo "Next steps:"
echo "1. Edit $CLAUDE_DIR/.env and add your ANTHROPIC_AUTH_TOKEN"
echo "2. Run: claude"
echo "3. Try: /agent-team \"Build REST API for user authentication\""