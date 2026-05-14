# Agent Team Orchestration

This project uses the **Agent Team System** for multi-agent workflow orchestration.

## Quick Start

For complex tasks, let Claude automatically select the right agents, or invoke explicitly:

```
/agent-team "Build REST API for user authentication"
/agent-team "Debug production error logs"
/agent-team "Create Unity game with player movement"
```

Or use agents directly:
```
@orchestrator-lead "Coordinate a team to build API"
@architect "Design database schema"
@code-reviewer "Review this PR"
```

The system will:
1. **Auto-classify** task routing level (0-3)
2. **Select** appropriate agent team
3. **Generate** task graph with dependencies
4. **Execute** with quality gates

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

## Rules

All agents follow rules in [`AGENT_RULES.md`](AGENT_RULES.md):
- Routing classification before starting
- Subagent selection guidelines
- Quality gate requirements
- Communication protocols

All code MUST follow [`CODING_STANDARDS.md`](CODING_STANDARDS.md):
- Comments and documentation requirements
- Naming conventions
- Error handling patterns
- Input validation
- API design conventions
- Performance guidelines
- Test requirements

## Configuration

- Agent list: `.claude/settings.json`
- API keys: `.claude/.env` (DO NOT COMMIT)

## Documentation

- Full guide: [README.md](README.md)
- Installation: [INSTALL.md](INSTALL.md)