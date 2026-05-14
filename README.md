# Agent Team System

A reusable multi-agent orchestration system for software engineering workflows. Dynamically creates agent teams and subagents based on task complexity, with quality gates and validation workflows.

## Features

- **4 Routing Levels**: Auto-classify tasks from simple fixes to complex multi-layer projects
- **8 Agents**: orchestrator, architect, backend/frontend/unity/mobile engineers, QA, DevOps
- **10 Subagents**: code-explorer, planner, reviewer, test-runner, log-analyst, security, performance, db-reviewer, doc-writer, integration-checker
- **CLI Tools**: Task classification, team listing, config management
- **Coding Standards**: Full coding conventions for all languages
- **Quality Gates**: Enforced before delivery

## Quick Start

### One-Command Install (Recommended)

```bash
/path/to/agent-team/install-complete.sh /path/to/project
```

### Manual Install

```bash
# Copy CLAUDE.md
cp /path/to/agent-team/CLAUDE.md ./CLAUDE.md

# Copy agents and subagents
cp -r /path/to/agent-team/.claude/agents ./.claude/
cp -r /path/to/agent-team/.claude/subagents ./.claude/subagents

# Copy skill
cp -r /path/to/agent-team/.claude/skills ./.claude/

# Copy settings
cp /path/to/agent-team/.claude/settings.json ./.claude/

# Copy rules
cp /path/to/agent-team/AGENT_RULES.md .
cp /path/to/agent-team/CODING_STANDARDS.md .

# Setup API key
echo "ANTHROPIC_AUTH_TOKEN=your_token" > .claude/.env
```

## Architecture

```
agent-team/
├── CLAUDE.md                           # Entry point
├── AGENT_RULES.md                      # Rules for all agents
├── CODING_STANDARDS.md                 # Code quality standards
├── INSTALL.md                          # Installation guide
├── README.md                           # Documentation
├── install-complete.sh                 # Auto installer
├── .claude/
│   ├── settings.json                   # Configuration
│   ├── agents/                         # 8 agents
│   ├── subagents/                      # 10 subagents
│   └── skills/
│       └── agent-team/
│           └── SKILL.md
└── core/
    └── orchestrator.sh                 # CLI tools
```

## Routing Levels

| Level | When Used | Example |
|-------|-----------|---------|
| **0** | Simple fixes, typos | "Fix typo in README" |
| **1** | Debug, analyze, review | "Debug production error" |
| **2** | Feature development | "Build REST API" |
| **3** | Migration, refactor, full-stack | "Migrate database schema" |

## Available Agents

Located in `.claude/agents/`:

- `orchestrator-lead` - Task routing, team coordination
- `architect` - System design, ADRs, API contracts
- `backend-engineer` - APIs, databases, integrations
- `frontend-engineer` - UI, state, accessibility
- `mobile-engineer` - iOS/Android/KMP
- `unity-engineer` - Unity C# scripts, game dev
- `qa-engineer` - Testing, validation
- `devops-security` - CI/CD, infrastructure, security

## Available Subagents

Located in `.claude/subagents/`:

- `code-explorer` - Codebase navigation
- `planner` - Implementation planning
- `code-reviewer` - Quality review
- `test-runner` - Test execution
- `log-analyst` - Log analysis
- `security-reviewer` - Security audit
- `performance-analyst` - Performance optimization
- `db-reviewer` - Database review
- `doc-writer` - Documentation
- `integration-checker` - API contract validation

## Rules & Standards

- **AGENT_RULES.md** - Agent workflow rules (routing, quality gates, communication)
- **CODING_STANDARDS.md** - Code quality standards (comments, naming, error handling, testing)

All code MUST follow both documents before being considered complete.

## Usage

### Direct Agent Invocation

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

## Documentation

- Installation: [INSTALL.md](INSTALL.md)
- Agent Rules: [AGENT_RULES.md](AGENT_RULES.md)
- Coding Standards: [CODING_STANDARDS.md](CODING_STANDARDS.md)