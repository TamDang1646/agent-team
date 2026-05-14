# Agent Team System Rules

Rules for agents working with the Agent Team orchestration system.

## Routing Rules

### Before Starting Any Task

1. **Classify the routing level:**
   - Simple fix/doc → Level 0 (single agent)
   - Debug/analyze → Level 1 (main + subagent)
   - Feature build → Level 2 (agent team)
   - Migration/refactor → Level 3 (team + subagents)

2. **Never skip classification** - always determine level first

3. **When in doubt**, choose higher level for complex tasks

## Agent Selection Rules

### Level 0 Tasks
- Single agent only
- No subagents needed
- Direct execution

### Level 1 Tasks
- Main coordinator + 1 specialized subagent
- Examples:
  - `code-explorer` for codebase search
  - `log-analyst` for debugging
  - `code-reviewer` for review

### Level 2 Tasks
- Agent team (3-5 agents)
- Required roles:
  - `orchestrator-lead` - always present
  - `architect` - for design work
  - `backend-engineer` - for APIs
  - `frontend-engineer` - for UI
  - `qa-engineer` - for testing
  - `devops-security` - for security concerns

### Level 3 Tasks
- Full agent team + multiple subagents
- Add specialized subagents:
  - `db-reviewer` - database migrations
  - `planner` - phased planning
  - `doc-writer` - documentation

## Subagent Usage Rules

### When to Spawn Subagents

| Subagent | When to Use |
|----------|-------------|
| `code-explorer` | Need to find files, trace code, understand structure |
| `planner` | Complex refactor, migration, multi-phase work |
| `code-reviewer` | After writing code, before merge |
| `test-runner` | Run test suite, check coverage |
| `log-analyst` | Debug production errors, analyze stack traces |
| `security-reviewer` | Auth code, user input, secrets, endpoints |
| `performance-analyst` | Slow queries, render issues, bundle size |
| `db-reviewer` | Schema changes, migrations, query optimization |
| `doc-writer` | ADRs, runbooks, handover docs |
| `integration-checker` | API contracts, frontend/backend sync |

### When NOT to Use Subagents

- Simple single-file edits
- Trivial changes
- When overhead exceeds value

## Quality Gate Rules

### Before Marking Task Complete

All agents MUST verify:

- [ ] **Requirements met** - Did we solve the actual problem?
- [ ] **Code quality** - Follows project patterns?
- [ ] **Tests pass** - No regressions introduced?
- [ ] **Security** - No obvious vulnerabilities?
- [ ] **Documentation** - Updated if needed?

### Specific by Agent Role

**architect:**
- [ ] ADRs written for major decisions
- [ ] API contracts documented
- [ ] Data model validated

**backend-engineer:**
- [ ] Input validation at boundaries
- [ ] Error handling comprehensive
- [ ] No N+1 queries
- [ ] Tests cover happy + edge cases

**frontend-engineer:**
- [ ] Responsive design works
- [ ] Accessibility (keyboard, ARIA)
- [ ] No console errors
- [ ] Performance within budget

**qa-engineer:**
- [ ] Test coverage >= 80%
- [ ] Critical paths tested
- [ ] Flaky tests identified

**devops-security:**
- [ ] Secrets not hardcoded
- [ ] Security scans passing
- [ ] Monitoring configured
- [ ] Runbooks for critical paths

**unity-engineer:**
- [ ] Scripts compile without errors
- [ ] No runtime allocations in Update
- [ ] Object pooling for spawning
- [ ] Prefabs configured correctly
- [ ] Build succeeds for target platform

## Communication Rules

### Between Agents

- Share context through task graph
- Document decisions in ADRs
- Flag blockers to orchestrator-lead
- Don't assume knowledge - explain context

### To User

- Report progress at milestones
- Flag blockers immediately
- Provide clear completion criteria
- Summarize changes made

## Forbidden Actions

### Never Do Without Approval

- Production deployments
- Database destructive changes
- Secret rotation
- Breaking API changes
- Major architecture changes

### Always Validate

- External API integrations
- Third-party dependencies
- Performance assumptions
- Security claims

## Error Handling Rules

### When Something Fails

1. Stop and report to orchestrator-lead
2. Document what failed and why
3. Suggest alternatives
4. Don't silently skip failed steps

### When Uncertain

1. Ask for clarification
2. Document assumptions
3. Propose multiple options
4. Don't guess on critical decisions