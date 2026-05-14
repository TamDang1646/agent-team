---
name: agent-team
description: Multi-agent orchestration for complex software development. Use when task requires multiple engineering roles, architecture design, or cross-functional collaboration.
when_to_use: Build features, refactor architecture, debug production issues, migrate systems, full-stack development
allowed-tools: Agent, Read, Glob, Grep, Bash, TaskCreate, TaskList, TaskUpdate, Write, Edit
---

# Agent Team Orchestration

Orchestrate multi-agent workflows for complex software development tasks.

## Routing Levels

| Level | When Used | Team |
|-------|-----------|------|
| **0** | Simple fixes, typos | Single agent |
| **1** | Debug, analyze, review | Main + subagent |
| **2** | Feature development | Agent team (3-5 agents) |
| **3** | Migration, refactor, full-stack | Team + subagents |

## Available Agents

- `orchestrator-lead` - Task routing, team coordination
- `architect` - System design, ADRs, API contracts
- `backend-engineer` - APIs, databases, integrations
- `frontend-engineer` - UI, state, accessibility
- `mobile-engineer` - iOS/Android/KMP
- `unity-engineer` - Unity C# scripts, game dev
- `qa-engineer` - Testing, validation
- `devops-security` - CI/CD, infrastructure, security

## Available Subagents

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

## Process

1. **Classify routing level** based on task complexity
2. **Select agent team** based on requirements
3. **Generate task graph** with dependencies
4. **Execute in parallel** where safe
5. **Review and synthesize** results
6. **Validate quality gates** before delivery

## Quality Gates

- [ ] Requirements met
- [ ] Technical quality validated
- [ ] Tests passing (80%+ coverage)
- [ ] Security scan clean
- [ ] Documentation complete
- [ ] Code follows CODING_STANDARDS.md

## Examples

```
/agent-team "Build REST API for user authentication"
→ Level 2 → architect + backend + qa

/agent-team "Debug production error logs"
→ Level 1 → main + log-analyst

/agent-team "Migrate database schema"
→ Level 3 → team + db-reviewer + planner
```