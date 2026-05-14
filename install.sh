#!/bin/bash
# Installation script for agent-team system
# Usage: ./install.sh <target-project-path>

set -e

TARGET_DIR="${1:-.}"
AGENT_TEAM_REPO="${2:-git@github.com:yourorg/agent-team.git}"

echo "Installing Agent Team System..."
echo "Target: $TARGET_DIR"
echo "Repo: $AGENT_TEAM_REPO"
echo ""

# Navigate to target directory
cd "$TARGET_DIR"

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Check if already installed
if [ -d ".claude/agent-team" ]; then
    echo "Error: .claude/agent-team already exists"
    echo "Remove it first or choose a different directory"
    exit 1
fi

# Add as git submodule
echo "Adding as git submodule..."
git submodule add "$AGENT_TEAM_REPO" .claude/agent-team

# Run setup script
echo "Running setup..."
cd .claude/agent-team
./setup.sh

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Review .claude/settings.local.json and customize enabled agents"
echo "2. Add custom agents to .claude/agent-team/project/custom-agents/"
echo "3. Start using the orchestrator"