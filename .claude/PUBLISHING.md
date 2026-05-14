# Publishing Agent Team System

Guide to publish and install Agent Team System.

## Quick Start

### 1. Push to GitHub

```bash
git push origin main
```

## Installation

### One-Command Install (Recommended)

```bash
curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
```

Or with custom repo:
```bash
AGENT_TEAM_REPO=https://github.com/TamDang1646/agent-team.git \
  curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
```

This will:
- Download all agents, subagents, skills
- Copy CLAUDE.md, AGENT_RULES.md, CODING_STANDARDS.md
- Create .env template
- Setup everything automatically

### Method 2: Git Submodule

```bash
# Add as submodule
git submodule add git@github.com:yourorg/agent-team.git .claude/agent-team

# Run installer
bash .claude/agent-team/setup.sh
```

### Method 3: Manual Clone

```bash
# Clone
git clone git@github.com:yourorg/agent-team.git /tmp/agent-team

# Copy files
cp -r /tmp/agent-team/.claude/* .claude/
cp /tmp/agent-team/CLAUDE.md .
cp /tmp/agent-team/AGENT_RULES.md .
cp /tmp/agent-team/CODING_STANDARDS.md .

# Cleanup
rm -rf /tmp/agent-team
```

## After Installation

```bash
# 1. Add your API token
echo "ANTHROPIC_AUTH_TOKEN=your_token" > .claude/.env

# 2. Verify
ls .claude/agents/
ls .claude/subagents/

# 3. Test
claude
/agent-team "Build REST API"
```

## Updating

```bash
# Pull latest
curl -sL https://raw.githubusercontent.com/yourorg/agent-team/main/setup.sh | bash
```

## File Structure After Install

```
project/
├── CLAUDE.md                # Entry point
├── AGENT_RULES.md           # Agent rules
├── CODING_STANDARDS.md      # Code standards
└── .claude/
    ├── agents/              # 8 agents
    ├── subagents/           # 10 subagents
    ├── skills/              # agent-team skill
    └── .env                 # API token
```

## Troubleshooting

### Script not working
```bash
# Run with debug
bash -x <(curl -sL https://raw.githubusercontent.com/yourorg/agent-team/main/setup.sh)
```

### Permission denied
```bash
# Use HTTPS instead of SSH
AGENT_TEAM_REPO=https://github.com/yourorg/agent-team.git \
  curl -sL https://raw.githubusercontent.com/yourorg/agent-team/main/setup.sh | bash
```