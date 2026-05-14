#!/bin/bash
# Install Agent Team System from git repo
# Usage: ./install.sh <git-repo> <target-dir>

set -e

REPO="$1"
TARGET_DIR="${2:-.}"

if [ -z "$REPO" ]; then
    echo "Usage: ./install.sh <git-repo> [target-dir]"
    echo "Example: ./install.sh git@github.com:org/agent-team.git ."
    exit 1
fi

echo "=== Installing Agent Team System ==="
echo "Repo: $REPO"
echo "Target: $TARGET_DIR"
echo ""

# Create temp dir
TMP_DIR=$(mktemp -d)
echo "[1/4] Cloning to temp directory..."
git clone --depth 1 "$REPO" "$TMP_DIR"

# Create .claude directory
mkdir -p "$TARGET_DIR/.claude"

# Copy agents
echo "[2/4] Copying agents..."
if [ -d "$TMP_DIR/.claude/agents" ]; then
    cp -r "$TMP_DIR/.claude/agents" "$TARGET_DIR/.claude/"
    echo "  Agents copied!"
fi

# Copy subagents
echo "[3/4] Copying subagents..."
if [ -d "$TMP_DIR/.claude/subagents" ]; then
    cp -r "$TMP_DIR/.claude/subagents" "$TARGET_DIR/.claude/"
    echo "  Subagents copied!"
fi

# Copy skill
echo "[4/4] Copying skill..."
if [ -d "$TMP_DIR/.claude/skills" ]; then
    cp -r "$TMP_DIR/.claude/skills" "$TARGET_DIR/.claude/"
    echo "  Skill copied!"
fi

# Copy CLAUDE.md if not exists
if [ ! -f "$TARGET_DIR/CLAUDE.md" ]; then
    echo "Copying CLAUDE.md..."
    cp "$TMP_DIR/CLAUDE.md" "$TARGET_DIR/"
fi

# Copy AGENT_RULES.md if not exists
if [ ! -f "$TARGET_DIR/AGENT_RULES.md" ]; then
    echo "Copying AGENT_RULES.md..."
    cp "$TMP_DIR/AGENT_RULES.md" "$TARGET_DIR/"
fi

# Copy CODING_STANDARDS.md if not exists
if [ ! -f "$TARGET_DIR/CODING_STANDARDS.md" ]; then
    echo "Copying CODING_STANDARDS.md..."
    cp "$TMP_DIR/CODING_STANDARDS.md" "$TARGET_DIR/"
fi

# Cleanup
rm -rf "$TMP_DIR"

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Files installed:"
echo "  .claude/agents/       - Agent definitions"
echo "  .claude/subagents/    - Subagent definitions"
echo "  .claude/skills/       - Skills"
echo "  CLAUDE.md             - Entry point"
echo "  AGENT_RULES.md        - Agent rules"
echo "  CODING_STANDARDS.md   - Coding standards"
echo ""
echo "Usage:"
echo "  /agent-team \"Build REST API\""
echo "  @architect \"Design schema\""