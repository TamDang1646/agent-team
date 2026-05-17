#!/bin/bash
# One-command install/update Agent Team System from GitHub
# Usage:
#   curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
#   ./setup.sh (from repo)
#
# Auto-detects:
#   - Not installed → Install
#   - Already installed → Update (preserve user configs)
#
# Options:
#   FORCE_UPDATE=true  - Force update all system files
#   DRY_RUN=true       - Preview without making changes

set -e

REPO="${AGENT_TEAM_REPO:-https://github.com/TamDang1646/agent-team.git}"
BRANCH="${AGENT_TEAM_BRANCH:-main}"
CLAUDE_DIR=".claude"
FORCE_UPDATE="${FORCE_UPDATE:-false}"
DRY_RUN="${DRY_RUN:-false}"

# Auto-detect: already installed?
if [ -d "$CLAUDE_DIR/agents" ] || [ -f "CLAUDE.md" ]; then
    AUTO_UPDATE=true
    echo "✅ Agent Team System detected - update mode enabled"
else
    AUTO_UPDATE=false
    echo "📦 Agent Team System not found - install mode enabled"
fi

echo "=== Agent Team System ==="
echo "Repo: $REPO@$BRANCH"
[ "$FORCE_UPDATE" = "true" ] && echo "Mode: FORCE UPDATE (update all system files)"
[ "$AUTO_UPDATE" = "true" ] && [ "$FORCE_UPDATE" != "true" ] && echo "Mode: AUTO UPDATE (update system files, preserve configs)"
[ "$DRY_RUN" = "true" ] && echo "Mode: DRY RUN (no changes will be made)"
echo ""

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
    mkdir -p "$CLAUDE_DIR/agents"
    cp -r "$TMP_DIR/.claude/agents"/* "$CLAUDE_DIR/agents/" 2>/dev/null || true
    [ "$AUTO_UPDATE" = "true" ] && echo "  Updated agents/" || echo "  Installed agents/"
}

echo "Installing subagents..."
[ -d "$TMP_DIR/.claude/subagents" ] && {
    mkdir -p "$CLAUDE_DIR/subagents"
    cp -r "$TMP_DIR/.claude/subagents"/* "$CLAUDE_DIR/subagents/" 2>/dev/null || true
    [ "$AUTO_UPDATE" = "true" ] && echo "  Updated subagents/" || echo "  Installed subagents/"
}

echo "Installing skills..."
[ -d "$TMP_DIR/.claude/skills" ] && {
    mkdir -p "$CLAUDE_DIR/skills"
    cp -r "$TMP_DIR/.claude/skills"/* "$CLAUDE_DIR/skills/" 2>/dev/null || true
    [ "$AUTO_UPDATE" = "true" ] && echo "  Updated skills/" || echo "  Installed skills/"
}

echo "Installing core/..."
[ -d "$TMP_DIR/.claude/core" ] && {
    mkdir -p "$CLAUDE_DIR/core"
    cp -r "$TMP_DIR/.claude/core"/* "$CLAUDE_DIR/core/" 2>/dev/null || true
    [ "$AUTO_UPDATE" = "true" ] && echo "  Updated core/" || echo "  Installed core/"
}

echo "Installing project/..."
[ -d "$TMP_DIR/.claude/project" ] && {
    mkdir -p "$CLAUDE_DIR/project"
    cp -r "$TMP_DIR/.claude/project"/* "$CLAUDE_DIR/project/" 2>/dev/null || true
    [ "$AUTO_UPDATE" = "true" ] && echo "  Updated project/" || echo "  Installed project/"
}

echo "Installing templates/..."
[ -d "$TMP_DIR/.claude/templates" ] && {
    mkdir -p "$CLAUDE_DIR/templates"
    cp -r "$TMP_DIR/.claude/templates"/* "$CLAUDE_DIR/templates/" 2>/dev/null || true
    [ "$AUTO_UPDATE" = "true" ] && echo "  Updated templates/" || echo "  Installed templates/"
}

# Copy rules
echo "Installing rules..."
[ -d "$TMP_DIR/.claude/rules" ] && {
    mkdir -p "$CLAUDE_DIR/rules"
    cp -r "$TMP_DIR/.claude/rules"/* "$CLAUDE_DIR/rules/" 2>/dev/null || true
    [ "$AUTO_UPDATE" = "true" ] && echo "  Updated rules/" || echo "  Installed rules/"
}

# Copy root files
echo "Copying documentation..."
if [ "$FORCE_UPDATE" = "true" ] || [ "$AUTO_UPDATE" = "true" ]; then
    [ -f "$TMP_DIR/CLAUDE.md" ] && cp "$TMP_DIR/CLAUDE.md" . && echo "  Updated CLAUDE.md"
    [ -f "$TMP_DIR/AGENT_RULES.md" ] && cp "$TMP_DIR/AGENT_RULES.md" . && echo "  Updated AGENT_RULES.md"
    [ -f "$TMP_DIR/CODING_STANDARDS.md" ] && cp "$TMP_DIR/CODING_STANDARDS.md" . && echo "  Updated CODING_STANDARDS.md"
    [ -f "$TMP_DIR/README.md" ] && [ ! -f "README.md" ] && cp "$TMP_DIR/README.md" . && echo "  Created README.md"
else
    [ ! -f "CLAUDE.md" ] && [ -f "$TMP_DIR/CLAUDE.md" ] && cp "$TMP_DIR/CLAUDE.md" . && echo "  CLAUDE.md"
    [ ! -f "AGENT_RULES.md" ] && [ -f "$TMP_DIR/AGENT_RULES.md" ] && cp "$TMP_DIR/AGENT_RULES.md" . && echo "  AGENT_RULES.md"
    [ ! -f "CODING_STANDARDS.md" ] && [ -f "$TMP_DIR/CODING_STANDARDS.md" ] && cp "$TMP_DIR/CODING_STANDARDS.md" . && echo "  CODING_STANDARDS.md"
    [ ! -f "README.md" ] && [ -f "$TMP_DIR/README.md" ] && cp "$TMP_DIR/README.md" . && echo "  README.md"
fi

# Copy settings template (preserve user's API token)
if [ "$FORCE_UPDATE" = "true" ] || [ "$AUTO_UPDATE" = "true" ]; then
    if [ -f "$CLAUDE_DIR/settings.local.json" ]; then
        echo "  Preserved settings.local.json (user config)"
    elif [ -f "$TMP_DIR/.claude/settings.example.json" ]; then
        cp "$TMP_DIR/.claude/settings.example.json" "$CLAUDE_DIR/settings.local.json"
        echo "  Created settings.local.json from template"
    fi
else
    if [ ! -f "$CLAUDE_DIR/settings.local.json" ] && [ -f "$TMP_DIR/.claude/settings.example.json" ]; then
        cp "$TMP_DIR/.claude/settings.example.json" "$CLAUDE_DIR/settings.local.json"
        echo "  Created settings.local.json from template"
    fi
fi

# Copy MCP servers template (preserve user's MCP config)
if [ "$FORCE_UPDATE" = "true" ] || [ "$AUTO_UPDATE" = "true" ]; then
    if [ -f "$CLAUDE_DIR/mcp-servers.local.json" ]; then
        echo "  Preserved mcp-servers.local.json (user config)"
    elif [ -f "$TMP_DIR/.claude/mcp-servers.example.json" ]; then
        cp "$TMP_DIR/.claude/mcp-servers.example.json" "$CLAUDE_DIR/mcp-servers.local.json"
        echo "  Created mcp-servers.local.json from template"
    fi
else
    if [ ! -f "$CLAUDE_DIR/mcp-servers.local.json" ] && [ -f "$TMP_DIR/.claude/mcp-servers.example.json" ]; then
        cp "$TMP_DIR/.claude/mcp-servers.example.json" "$CLAUDE_DIR/mcp-servers.local.json"
        echo "  Created mcp-servers.local.json from template"
    fi
fi

# Copy .gitignore
if [ "$FORCE_UPDATE" = "true" ] || [ "$AUTO_UPDATE" = "true" ]; then
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

# Copy .mcp.json to project root
if [ "$FORCE_UPDATE" = "true" ] || [ "$AUTO_UPDATE" = "true" ]; then
    if [ -f "$TMP_DIR/.mcp.json" ]; then
        cp "$TMP_DIR/.mcp.json" ".mcp.json"
        echo "Updated .mcp.json"
    fi
else
    if [ ! -f ".mcp.json" ] && [ -f "$TMP_DIR/.mcp.json" ]; then
        cp "$TMP_DIR/.mcp.json" ".mcp.json"
        echo "Created .mcp.json"
    fi
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Files installed:"
echo "  $CLAUDE_DIR/agents/            ($(ls -1 $CLAUDE_DIR/agents 2>/dev/null | wc -l | tr -d ' ') agents)"
echo "  $CLAUDE_DIR/subagents/         ($(ls -1 $CLAUDE_DIR/subagents 2>/dev/null | wc -l | tr -d ' ') subagents)"
echo "  $CLAUDE_DIR/skills/            ($(ls -1 $CLAUDE_DIR/skills 2>/dev/null | wc -l | tr -d ' ') skills)"
echo "  $CLAUDE_DIR/core/              ($(ls -1 $CLAUDE_DIR/core 2>/dev/null | wc -l | tr -d ' ') files)"
echo "  $CLAUDE_DIR/project/           ($(ls -1 $CLAUDE_DIR/project 2>/dev/null | wc -l | tr -d ' ') files)"
echo "  $CLAUDE_DIR/templates/         ($(ls -1 $CLAUDE_DIR/templates 2>/dev/null | wc -l | tr -d ' ') files)"
echo "  $CLAUDE_DIR/rules/             ($(ls -1 $CLAUDE_DIR/rules 2>/dev/null | wc -l | tr -d ' ') files)"
echo "  $CLAUDE_DIR/settings.local.json (user config)"
[ -f "$CLAUDE_DIR/mcp-servers.local.json" ] && echo "  $CLAUDE_DIR/mcp-servers.local.json (user config)"
[ -f "$CLAUDE_DIR/.gitignore" ] && echo "  $CLAUDE_DIR/.gitignore"
[ -f ".mcp.json" ] && echo "  ./.mcp.json"
echo "  ./CLAUDE.md"
echo "  ./AGENT_RULES.md"
echo "  ./CODING_STANDARDS.md"
echo "  ./README.md"
echo ""
echo "Next steps:"
echo "1. Run: claude"
echo "2. Try: /agent-team \"Build REST API\""
echo ""
echo "Options:"
echo "  FORCE_UPDATE=true  - Force update all system files"
echo "  DRY_RUN=true       - Preview without applying"