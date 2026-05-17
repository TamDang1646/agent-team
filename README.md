# Agent Team System

Multi-agent orchestration system for software engineering workflows. Auto-classifies tasks, coordinates agent teams, and enforces quality gates.

## Features

- **4 Routing Levels**: Auto-classify tasks (simple fix → complex migration)
- **10 Agents**: orchestrator, architect, backend/frontend/unity/mobile, qa, devops-security, code-reviewer, test-runner
- **10 Subagents**: code-explorer, planner, code-reviewer, test-runner, log-analyst, security-reviewer, performance-analyst, db-reviewer, doc-writer, integration-checker
- **Rules**: behavioral-guidelines.md
- **Coding Standards**: TypeScript, Python, C#, Unity, SQL
- **Quality Gates**: Enforced before delivery

## Installation

### One-Command Install (Recommended)

```bash
curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
```

That's it! Script will:
- Download agents, subagents, skills
- Copy CLAUDE.md, AGENT_RULES.md, CODING_STANDARDS.md
- Copy `.claude/settings.local.json` and `mcp-servers.local.json` templates
- Create `.claude/.gitignore`

### Next Steps

```bash
# 1. Add your API token to settings.local.json
nano .claude/settings.local.json
# Add: "ANTHROPIC_AUTH_TOKEN": "your_token_here" in env section

# 2. Run claude
claude

# 3. Try agent-team
/agent-team "Build REST API for user authentication"
```

### Update System

**Safe update (preserves your config):**
```bash
curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
```

**Force update (overwrites everything including settings.local.json):**
```bash
FORCE_UPDATE=true curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
```

**Preview before updating:**
```bash
DRY_RUN=true curl -sL https://raw.githubusercontent.com/TamDang1646/agent-team/main/setup.sh | bash
```

## Architecture

```
.claude/
├── agents/              # 10 agents
├── subagents/           # 10 subagents
├── skills/
│   └── agent-team/
├── core/
├── project/
├── templates/
├── rules/               # Behavioral guidelines
├── settings.local.json  # Your config with API token
├── mcp-servers.local.json # MCP servers config
└── .gitignore

CLAUDE.md                # Entry point
AGENT_RULES.md           # Agent workflow rules
CODING_STANDARDS.md      # Code quality standards
```

## Routing Levels

| Level | When Used | Example |
|-------|-----------|---------|
| **0** | Simple fixes | "Fix typo" |
| **1** | Debug, analyze | "Debug production error" |
| **2** | Feature development | "Build REST API" |
| **3** | Migration, refactor | "Migrate database" |

## Usage

```bash
# Auto-classify and execute
/agent-team "Build REST API for user authentication"

# Direct agent invocation
@architect "Design database schema"
@code-reviewer "Review this PR"

# CLI tools
.claude/core/orchestrator.sh classify "Build REST API"
.claude/core/orchestrator.sh agents
```

## Documentation

- [PUBLISHING.md](.claude/PUBLISHING.md) - Full install guide
- [AGENT_RULES.md](.claude/AGENT_RULES.md) - Agent workflow rules
- [CODING_STANDARDS.md](.claude/CODING_STANDARDS.md) - Code quality standards
- [INSTALL.md](.claude/INSTALL.md) - Detailed installation
- [rules/](.claude/rules/) - Behavioral guidelines for all agents