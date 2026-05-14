#!/bin/bash
# Complete installer for Agent Team System
# Usage: ./install-complete.sh [target-dir]

set -e

TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Agent Team System - Complete Installation ==="
echo "Target: $TARGET_DIR"
echo ""

# Step 1: Create .claude directory
echo "[1/5] Creating .claude directory..."
mkdir -p "$TARGET_DIR/.claude"

# Step 2: Copy CLAUDE.md, AGENT_RULES.md, and CODING_STANDARDS.md
echo "[2/5] Setting up documentation..."
CLAUDE_FILE="$TARGET_DIR/CLAUDE.md"
AGENT_RULES_FILE="$TARGET_DIR/AGENT_RULES.md"
CODING_STANDARDS_FILE="$TARGET_DIR/CODING_STANDARDS.md"
SCRIPT_CLAUDE="$SCRIPT_DIR/CLAUDE.md"
SCRIPT_RULES="$SCRIPT_DIR/AGENT_RULES.md"
SCRIPT_CODING="$SCRIPT_DIR/CODING_STANDARDS.md"

# Setup CLAUDE.md
if [ -f "$CLAUDE_FILE" ]; then
    echo "  CLAUDE.md exists, checking for agent-team section..."
    if grep -q "Agent Team Orchestration" "$CLAUDE_FILE" 2>/dev/null; then
        echo "  Agent Team section already exists, skipping..."
    else
        echo "  Appending Agent Team section to CLAUDE.md..."
        cat "$SCRIPT_CLAUDE" >> "$CLAUDE_FILE"
        echo "  Agent Team section appended!"
    fi
else
    echo "  Creating new CLAUDE.md..."
    cp "$SCRIPT_CLAUDE" "$CLAUDE_FILE"
    echo "  CLAUDE.md created!"
fi

# Setup AGENT_RULES.md
if [ -f "$AGENT_RULES_FILE" ]; then
    echo "  AGENT_RULES.md already exists, skipping..."
else
    echo "  Creating new AGENT_RULES.md..."
    cp "$SCRIPT_RULES" "$AGENT_RULES_FILE"
    echo "  AGENT_RULES.md created!"
fi

# Setup CODING_STANDARDS.md
if [ -f "$CODING_STANDARDS_FILE" ]; then
    echo "  CODING_STANDARDS.md already exists, skipping..."
else
    echo "  Creating new CODING_STANDARDS.md..."
    cp "$SCRIPT_CODING" "$CODING_STANDARDS_FILE"
    echo "  CODING_STANDARDS.md created!"
fi

# Step 3: Copy agents and subagents
echo "[3/5] Copying agents and subagents..."
if [ -d "$SCRIPT_DIR/.claude/agents" ]; then
    cp -r "$SCRIPT_DIR/.claude/agents" "$TARGET_DIR/.claude/"
    echo "  Agents copied!"
fi
if [ -d "$SCRIPT_DIR/.claude/subagents" ]; then
    cp -r "$SCRIPT_DIR/.claude/subagents" "$TARGET_DIR/.claude/"
    echo "  Subagents copied!"
fi

# Step 4: Copy skill
echo "[4/5] Copying agent-team skill..."
if [ -d "$SCRIPT_DIR/.claude/skills" ]; then
    cp -r "$SCRIPT_DIR/.claude/skills" "$TARGET_DIR/.claude/"
    echo "  Skill copied!"
fi

# Step 5: Setup config
echo "[5/5] Setting up configuration..."
if [ ! -f "$TARGET_DIR/.claude/settings.json" ]; then
    cp "$SCRIPT_DIR/.claude/settings.json" "$TARGET_DIR/.claude/"
    echo "  settings.json created!"
else
    echo "  settings.json already exists!"
fi

if [ ! -f "$TARGET_DIR/.claude/.env" ]; then
    cp "$SCRIPT_DIR/.claude/.env" "$TARGET_DIR/.claude/"
    echo "  .env template created (edit to add your API key)!"
else
    echo "  .env already exists!"
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Structure:"
echo "  CLAUDE.md                   # Entry point"
echo "  AGENT_RULES.md              # Rules for all agents"
echo "  CODING_STANDARDS.md         # Code quality standards"
echo "  .claude/agents/             # Agent definitions"
echo "  .claude/subagents/          # Subagent definitions"
echo "  .claude/skills/agent-team/  # Agent team skill"
echo "  .claude/settings.json       # Configuration"
echo "  .claude/.env                # API keys (DO NOT COMMIT)"
echo ""
echo "Usage:"
echo "  /agent-team \"<task description>\""
echo ""
echo "Examples:"
echo "  /agent-team \"Build REST API for user authentication\""
echo "  /agent-team \"Debug production error logs\""
echo "  /agent-team \"Create Unity game with player movement\""
echo ""
echo "Next steps:"
echo "1. Review AGENT_RULES.md for workflow rules"
echo "2. Review CODING_STANDARDS.md for code quality requirements"
echo "3. Edit .claude/.env and add your ANTHROPIC_AUTH_TOKEN"
echo "4. Start using /agent-team command"