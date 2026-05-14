# Publishing Agent Team System

This guide explains how to publish this repo so it can be used as a submodule in other projects.

## Quick Start

### 1. Create a GitHub Repository

```bash
# Create new repo on GitHub (e.g., https://github.com/yourorg/agent-team)
# Then:
git remote add origin git@github.com:yourorg/agent-team.git
git branch -M main
git push -u origin main
```

### 2. Commit All Files

```bash
git add .
git commit -m "Initial commit: Agent Team System

- 8 agents: orchestrator, architect, backend/frontend/unity/mobile, qa, devops
- 10 subagents: explorer, planner, reviewer, test-runner, log-analyst, etc.
- Coding standards for TypeScript, Python, C#, Unity, SQL
- Agent rules and quality gates
- One-command install script"
git push -u origin main
```

### 3. Test in Another Project

```bash
# In any project
cd /path/to/other-project

# Install as submodule
git submodule add git@github.com:yourorg/agent-team.git .claude/agent-team

# Run installer
.cloude/agent-team/install-complete.sh .

# Verify installation
ls -la .claude/agents/
ls -la .claude/subagents/

# Commit the submodule
git add .claude
git commit -m "Add agent-team system for multi-agent orchestration"
```

## File Structure for Publishing

Files that SHOULD be committed:
```
CLAUDE.md
AGENT_RULES.md
CODING_STANDARDS.md
INSTALL.md
README.md
install-complete.sh
install.sh
setup.sh
core/orchestrator.sh
.templates/
```

Files that should NOT be committed (.gitignore):
```
.claude/.env           # API keys
.claude/settings.local.json  # Local config
.claude/agents/        # Generated during install
.claude/subagents/     # Generated during install
.claude/skills/        # Generated during install
```

## Using the Published Repo

### Option A: As Git Submodule (Recommended)

```bash
# Add as submodule
git submodule add git@github.com:yourorg/agent-team.git .claude/agent-team

# Install
.cloude/agent-team/install-complete.sh .
```

### Option B: Clone Directly

```bash
# Clone into .claude
git clone git@github.com:yourorg/agent-team.git .claude/agent-team

# Install
.cloude/agent-team/install-complete.sh .
```

### Option C: Download ZIP

```bash
# Download and extract
curl -sL https://github.com/yourorg/agent-team/archive/main.zip -o agent-team.zip
unzip agent-team.zip -d .claude/
mv .claude/agent-team-main .claude/agent-team

# Install
.cloude/agent-team/install-complete.sh .
```

## Updating the System

### In the Agent-Team Repo

```bash
# Make changes
# ... edit files ...

git add .
git commit -m "Update: added new subagent"
git push
```

### In Projects Using It

```bash
# Pull latest changes
cd .claude/agent-team
git pull origin main

# Re-run installer if needed
./install-complete.sh ../..
```

## Best Practices

1. **Semantic Versioning**
   ```bash
   git tag -a v1.0.0 -m "Initial stable release"
   git push origin v1.0.0
   ```

2. **Keep Documentation Updated**
   - Update README.md when adding features
   - Update INSTALL.md with new install methods
   - Update CODING_STANDARDS.md with new conventions

3. **Backward Compatibility**
   - Don't break existing install scripts
   - Support both old and new install methods during transition
   - Deprecate slowly, not abruptly

4. **Testing Before Publish**
   ```bash
   # Test in a fresh project
   mkdir test-project && cd test-project
   git init
   ../install-complete.sh .
   # Verify everything works
   ```

## Troubleshooting

### Submodule not updating

```bash
# Force update
git submodule update --remote .claude/agent-team
```

### Install script fails

```bash
# Check permissions
chmod +x .claude/agent-team/install-complete.sh

# Run with debug
bash -x .claude/agent-team/install-complete.sh .
```

### Files not copying

```bash
# Check source files exist
ls -la .claude/agent-team/.claude/agents/

# Manual copy
cp -r .claude/agent-team/.claude/agents .claude/
```