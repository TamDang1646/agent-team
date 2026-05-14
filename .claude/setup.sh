#!/bin/bash
# One-command install Agent Team System from GitHub
# Run this in your project directory:
#   curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
#
# Options:
#   FORCE_UPDATE=true  - Overwrite existing files (including settings.local.json)
#   DRY_RUN=true       - Show what would be done without making changes

set -e

REPO="${AGENT_TEAM_REPO:-https://github.com/TamDang1646/agent-team.git}"
BRANCH="${AGENT_TEAM_BRANCH:-main}"
CLAUDE_DIR=".claude"
FORCE_UPDATE="${FORCE_UPDATE:-false}"
DRY_RUN="${DRY_RUN:-false}"

echo "=== Installing Agent Team System ==="
echo "Repo: $REPO@$BRANCH"
[ "$FORCE_UPDATE" = "true" ] && echo "Mode: FORCE UPDATE (will overwrite existing files)"
[ "$DRY_RUN" = "true" ] && echo "Mode: DRY RUN (no changes will be made)"

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
[ -d "$TMP_DIR/.claude/agents" ] && {
    if [ "$FORCE_UPDATE" = "true" ]; then
        rm -rf "$CLAUDE_DIR/agents"
        cp -r "$TMP_DIR/.claude/agents" "$CLAUDE_DIR/"
    else
        cp -rn "$TMP_DIR/.claude/agents" "$CLAUDE_DIR/" 2>/dev/null || true
    fi
}

echo "Installing subagents..."
[ -d "$TMP_DIR/.claude/subagents" ] && {
    if [ "$FORCE_UPDATE" = "true" ]; then
        rm -rf "$CLAUDE_DIR/subagents"
        cp -r "$TMP_DIR/.claude/subagents" "$CLAUDE_DIR/"
    else
        cp -rn "$TMP_DIR/.claude/subagents" "$CLAUDE_DIR/" 2>/dev/null || true
    fi
}

echo "Installing skills..."
[ -d "$TMP_DIR/.claude/skills" ] && {
    if [ "$FORCE_UPDATE" = "true" ]; then
        rm -rf "$CLAUDE_DIR/skills"
        cp -r "$TMP_DIR/.claude/skills" "$CLAUDE_DIR/"
    else
        cp -rn "$TMP_DIR/.claude/skills" "$CLAUDE_DIR/" 2>/dev/null || true
    fi
}

echo "Installing core/..."
[ -d "$TMP_DIR/.claude/core" ] && {
    if [ "$FORCE_UPDATE" = "true" ]; then
        rm -rf "$CLAUDE_DIR/core"
        cp -r "$TMP_DIR/.claude/core" "$CLAUDE_DIR/"
    else
        cp -rn "$TMP_DIR/.claude/core" "$CLAUDE_DIR/" 2>/dev/null || true
    fi
}

echo "Installing project/..."
[ -d "$TMP_DIR/.claude/project" ] && {
    if [ "$FORCE_UPDATE" = "true" ]; then
        rm -rf "$CLAUDE_DIR/project"
        cp -r "$TMP_DIR/.claude/project" "$CLAUDE_DIR/"
    else
        cp -rn "$TMP_DIR/.claude/project" "$CLAUDE_DIR/" 2>/dev/null || true
    fi
}

echo "Installing templates/..."
[ -d "$TMP_DIR/.claude/templates" ] && {
    if [ "$FORCE_UPDATE" = "true" ]; then
        rm -rf "$CLAUDE_DIR/templates"
        cp -r "$TMP_DIR/.claude/templates" "$CLAUDE_DIR/"
    else
        cp -rn "$TMP_DIR/.claude/templates" "$CLAUDE_DIR/" 2>/dev/null || true
    fi
}

# Copy root files
echo "Copying documentation..."
if [ "$FORCE_UPDATE" = "true" ]; then
    [ -f "$TMP_DIR/CLAUDE.md" ] && cp "$TMP_DIR/CLAUDE.md" . && echo "  Updated CLAUDE.md"
    [ -f "$TMP_DIR/AGENT_RULES.md" ] && cp "$TMP_DIR/AGENT_RULES.md" . && echo "  Updated AGENT_RULES.md"
    [ -f "$TMP_DIR/CODING_STANDARDS.md" ] && cp "$TMP_DIR/CODING_STANDARDS.md" . && echo "  Updated CODING_STANDARDS.md"
else
    [ ! -f "CLAUDE.md" ] && [ -f "$TMP_DIR/CLAUDE.md" ] && cp "$TMP_DIR/CLAUDE.md" . && echo "  CLAUDE.md"
    [ ! -f "AGENT_RULES.md" ] && [ -f "$TMP_DIR/AGENT_RULES.md" ] && cp "$TMP_DIR/AGENT_RULES.md" . && echo "  AGENT_RULES.md"
    [ ! -f "CODING_STANDARDS.md" ] && [ -f "$TMP_DIR/CODING_STANDARDS.md" ] && cp "$TMP_DIR/CODING_STANDARDS.md" . && echo "  CODING_STANDARDS.md"
fi

# Copy settings template
if [ "$FORCE_UPDATE" = "true" ]; then
    if [ -f "$TMP_DIR/.claude/settings.example.json" ]; then
        cp "$TMP_DIR/.claude/settings.example.json" "$CLAUDE_DIR/settings.local.json"
        echo "Updated settings.local.json from template (you will need to re-add your API token)"
    fi
else
    if [ ! -f "$CLAUDE_DIR/settings.local.json" ] && [ -f "$TMP_DIR/.claude/settings.example.json" ]; then
        cp "$TMP_DIR/.claude/settings.example.json" "$CLAUDE_DIR/settings.local.json"
        echo "Created settings.local.json from template"
    fi
fi

# Copy MCP servers template
if [ "$FORCE_UPDATE" = "true" ]; then
    if [ -f "$TMP_DIR/.claude/mcp-servers.example.json" ]; then
        cp "$TMP_DIR/.claude/mcp-servers.example.json" "$CLAUDE_DIR/mcp-servers.local.json"
        echo "Updated mcp-servers.local.json from template"
    fi
else
    if [ ! -f "$CLAUDE_DIR/mcp-servers.local.json" ] && [ -f "$TMP_DIR/.claude/mcp-servers.example.json" ]; then
        cp "$TMP_DIR/.claude/mcp-servers.example.json" "$CLAUDE_DIR/mcp-servers.local.json"
        echo "Created mcp-servers.local.json from template"
    fi
fi

# Copy .gitignore
if [ "$FORCE_UPDATE" = "true" ]; then
    if [ -f "$TMP_DIR/.claude/.gitignore" ]; then
        cp "$TMP_DIR/.claude/.gitignore" "$CLAUDE_DIR/.gitignore"
        echo "Updated .claude/.gitignore"
    fi
else
    if [ ! -f "$CLAUDE_DIR/.gitignore" ] && [ -f "$TMP_DIR/.claude/.gitignore" ]; then
        cp "$TMP_DIR/.claude/.gitignore" "$CLAUDE_DIR/.gitignore"
        echo "Created .claude/.gitignore"
    fi
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Files installed:"
echo "  $CLAUDE_DIR/agents/            ($(ls $CLAUDE_DIR/agents 2>/dev/null | wc -l | tr -d ' ') agents)"
echo "  $CLAUDE_DIR/subagents/         ($(ls $CLAUDE_DIR/subagents 2>/dev/null | wc -l | tr -d ' ') subagents)"
echo "  $CLAUDE_DIR/skills/            ($(ls $CLAUDE_DIR/skills 2>/dev/null | wc -l | tr -d ' ') skills)"
echo "  $CLAUDE_DIR/core/              ($(ls $CLAUDE_DIR/core 2>/dev/null | wc -l | tr -d ' ') files)"
echo "  $CLAUDE_DIR/project/           ($(ls $CLAUDE_DIR/project 2>/dev/null | wc -l | tr -d ' ') files)"
echo "  $CLAUDE_DIR/templates/         ($(ls $CLAUDE_DIR/templates 2>/dev/null | wc -l | tr -d ' ') files)"
[ -f "$CLAUDE_DIR/settings.local.json" ] && echo "  $CLAUDE_DIR/settings.local.json"
[ -f "$CLAUDE_DIR/mcp-servers.local.json" ] && echo "  $CLAUDE_DIR/mcp-servers.local.json"
[ -f "$CLAUDE_DIR/.gitignore" ] && echo "  $CLAUDE_DIR/.gitignore"
echo "  ./CLAUDE.md"
echo "  ./AGENT_RULES.md"
echo "  ./CODING_STANDARDS.md"
echo ""
echo "Next steps:"
[ "$FORCE_UPDATE" = "true" ] && echo "⚠️  WARNING: settings.local.json was overwritten. Re-add your API token!"
echo "1. Edit $CLAUDE_DIR/settings.local.json and add your ANTHROPIC_AUTH_TOKEN in env section"
echo "2. Review $CLAUDE_DIR/mcp-servers.local.json and update MCP paths for your system"
echo "3. Run: claude"
echo "4. Try: /agent-team \"Build REST API for user authentication\""
echo ""
echo "Update options:"
echo "  FORCE_UPDATE=true  - Overwrite all files (including settings.local.json)"
echo "  DRY_RUN=true       - Preview changes without applying"