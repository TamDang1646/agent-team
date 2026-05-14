# Agent Team System - Complete Setup

## One-Command Installation

```bash
# From any project directory
/path/to/agent-team/install-complete.sh .
```

This will:
1. Create `CLAUDE.md` entry point (or append to existing)
2. Copy agents to `.claude/agents/`
3. Copy subagents to `.claude/subagents/`
4. Setup `.claude/settings.json`
5. Create `.claude/.env` template

## Manual Installation

```bash
# Step 1: Copy CLAUDE.md
cp /path/to/agent-team/CLAUDE.md ./CLAUDE.md

# Step 2: Copy agents and subagents
cp -r /path/to/agent-team/.claude/agents ./.claude/
cp -r /path/to/agent-team/.claude/subagents ./.claude/

# Step 3: Copy settings
cp /path/to/agent-team/.claude/settings.json ./.claude/

# Step 4: Setup API key
echo "ANTHROPIC_AUTH_TOKEN=your_token" > .claude/.env
```

## Usage

Once installed, Claude will read `CLAUDE.md` at the start of every session and know how to use agents.

### Direct Invocation

```
/agent-team "Build REST API for user authentication"
@orchestrator-lead "Coordinate a team to build API"
@architect "Design database schema"
@code-reviewer "Review this PR"
```

### CLI Tools

```bash
# Classify task level
./core/orchestrator.sh classify "Build REST API"

# List available agents
./core/orchestrator.sh agents

# Show configuration
./core/orchestrator.sh config
```

## File Structure

```
project/
├── CLAUDE.md                    # Entry point
├── .claude/
│   ├── settings.json            # Agent configuration
│   ├── .env                     # API keys (DO NOT COMMIT)
│   ├── agents/
│   │   ├── orchestrator-lead.md
│   │   ├── architect.md
│   │   ├── backend-engineer.md
│   │   ├── frontend-engineer.md
│   │   ├── mobile-engineer.md
│   │   ├── unity-engineer.md
│   │   ├── qa-engineer.md
│   │   └── devops-security.md
│   └── subagents/
│       ├── code-explorer.md
│       ├── planner.md
│       ├── code-reviewer.md
│       ├── test-runner.md
│       ├── log-analyst.md
│       ├── security-reviewer.md
│       ├── performance-analyst.md
│       ├── db-reviewer.md
│       ├── doc-writer.md
│       └── integration-checker.md
└── core/
    └── orchestrator.sh          # CLI tools
```

## Verification

```bash
# Check installation
ls -la .claude/agents/
ls -la .claude/subagents/

# Test CLI
./core/orchestrator.sh classify "Fix typo"
# Should output: level_0
```