# Hybrid Agent-Team + Subagent Architecture

## Overview

The agent-team extension now supports **hybrid orchestration** — combining team-based delegation (`dispatch_agent`) with tactical subagent execution (`subagent`). This enables sophisticated workflows where:

- **Team delegation** handles complex feature work, cross-cutting refactoring, and domain-specific tasks
- **Subagent execution** handles batch processing, quick exploration, and external tool usage
- **Both tools work together** for sophisticated multi-step workflows

This document defines the architecture, patterns, and decision criteria for when to use each tool.

---

## Tool Comparison Table

| Aspect | `dispatch_agent` | `subagent` |
|--------|-----------------|-----------|
| **Context** | Team member agent | Isolated subagent session |
| **Session** | Persistent (resumed) | Fresh start by default |
| **Best For** | Feature building, refactoring, domain-specific work | Batch processing, exploration, external tools |
| **Domain** | Specialized tools per team member | General toolset (read, grep, find, ls, bash, etc.) |
| **Parallelization** | Multiple team members concurrently | Single execution, sequential |
| **Latency** | Higher (team context, history) | Lower (fresh session, no history) |
| **Error Recovery** | Agent-specific retry logic | Manual task adjustment |
| **Output Integration** | Direct team context integration | Requires manual result processing |

---

## Architecture Patterns

### Pattern 1: Sequential Exploration + Delegation
**Scenario:** Complex refactoring task with unknown dependencies.

```
user request
    ↓
[subagent] Quick exploration (find dependencies, analyze impact)
    ↓
result data
    ↓
[dispatch_agent → builder] Implement refactoring with context
    ↓
team output
```

**Decision:** Use `subagent` for reconnaissance, then `dispatch_agent` to builder with findings.

---

### Pattern 2: Batch Processing + Results Handoff
**Scenario:** Process 100 files, then apply a transformation to each.

```
user request
    ↓
[subagent] Batch read / transform (no team context needed)
    ↓
aggregated results
    ↓
[dispatch_agent → builder] Apply bulk update to codebase
    ↓
team output
```

**Decision:** Use `subagent` for I/O-heavy work, `dispatch_agent` for codebase mutation.

---

### Pattern 3: Parallel Team Delegation
**Scenario:** Multiple independent features can be built simultaneously.

```
user request
    ↓
[dispatch_agent → agent1] Feature A (concurrent)
[dispatch_agent → agent2] Feature B (concurrent)
[dispatch_agent → agent3] Feature C (concurrent)
    ↓
consolidate results
    ↓
[dispatch_agent → reviewer] Validate & merge
```

**Decision:** Only `dispatch_agent` supports true parallelization within the team context.

---

### Pattern 4: Exploratory Subagent Chain
**Scenario:** User is uncertain about the approach; need quick iterations.

```
user question
    ↓
[subagent] Quick prototype / POC (exploratory)
    ↓
review learnings
    ↓
[subagent] Iterate on approach (fresh session each time)
    ↓
validated approach
    ↓
[dispatch_agent → builder] Production implementation
```

**Decision:** Fast iteration with `subagent`, then production-ready `dispatch_agent`.

---

## Configuration

### Enabling Hybrid Mode

In `agent-team.ts` line ~729:

```typescript
// Enable hybrid delegation: both dispatch_agent and subagent tools
pi.setActiveTools(["dispatch_agent", "subagent"]);
```

Both tools are now available to the orchestrator agent.

### System Prompt Delegation Strategy

The `before_agent_start` event now includes explicit guidance:

```
## Delegation Strategy
**dispatch_agent** → Use when:
- Delegating work to team members who specialize in specific domains
- The task is complex and requires a specialist's expertise
- You want to parallelize work across multiple agents

**subagent** → Use when:
- You need to run focused, tactical commands outside the team context
- Working with external tools or batch processing
- Quick exploration before full team delegation
```

---

## Risk Mitigation

### Session State Conflicts
**Risk:** Multiple simultaneous subagent executions interfere with team sessions.

**Mitigation:**
- Subagent sessions are isolated and time-scoped
- Team agent sessions are persistent and isolated from subagent runs
- Session files are stored in `.pi/agent-sessions/` with unique names per agent

### Context Window Bloat
**Risk:** Hybrid mode increases context usage (team history + subagent outputs).

**Mitigation:**
- Subagent outputs are explicitly truncated (8000 char max) before returning to orchestrator
- Team sessions retain selective history, not full conversation
- Monitor context usage via the footer status bar

### Tool Availability Mismatch
**Risk:** Subagent task assumes tools that aren't available in subagent mode.

**Mitigation:**
- Orchestrator should frame subagent tasks with tool awareness
- Subagent has standard tools (read, grep, find, ls, bash)
- Complex domain-specific work should use `dispatch_agent` to specialists

### Session Resume Behavior
**Risk:** Resuming a team agent session after subagent work confuses state.

**Mitigation:**
- Team sessions and subagent sessions are entirely separate
- Subagent never interferes with team agent `.json` session files
- Sessions are explicitly cleared only via `/agents-reset` (future command)

---

## Implementation Timeline

### Phase 1: Hybrid Enablement (Current)
✅ Enable both `dispatch_agent` and `subagent` tools  
✅ Update system prompt with delegation strategy  
✅ Document architecture and patterns  

### Phase 2: Smart Routing (Future)
- [ ] Add intent detection to automatically suggest dispatch_agent vs subagent
- [ ] Implement `/agents-reset` to explicitly clear team sessions
- [ ] Add metrics (context usage, tool invocations per pattern)

### Phase 3: Advanced Orchestration (Future)
- [ ] Support named subagent profiles (e.g., "explorer", "batch-processor")
- [ ] Implement inter-agent communication (subagent result → dispatch_agent context)
- [ ] Add workflow templates (common patterns as quick-start)

---

## Example Usage

### Example 1: Exploratory Refactoring
```
User: "Refactor the auth module to use dependency injection"

Orchestrator Decision:
1. [subagent] Quick scan: Find all auth module imports, current structure
2. Review findings with context
3. [dispatch_agent → builder] Implement refactoring with explorer's output
```

### Example 2: Batch Update + Validation
```
User: "Update all package.json files to use ^2.0.0 for @lodash packages"

Orchestrator Decision:
1. [subagent] Find all package.json files, extract lodash versions
2. Aggregate list of files
3. [dispatch_agent → builder] Batch update to ^2.0.0
4. [dispatch_agent → reviewer] Validate changes
```

### Example 3: Parallel Feature Development
```
User: "Implement auth, logging, and database connection features"

Orchestrator Decision:
1. [dispatch_agent → backend-specialist] Build database connection
2. [dispatch_agent → security-specialist] Build auth module
3. [dispatch_agent → ops-specialist] Build logging integration
(All 3 run in parallel if available)
```

---

## Deployment Notes

- **No breaking changes** — Hybrid mode is opt-in via `pi.setActiveTools([...])` configuration
- **Backward compatible** — Teams without hybrid mode continue to use dispatch_agent only
- **Session persistence** — Team agent sessions are preserved across hybrid calls (non-destructive)
- **Gradual adoption** — Start with Pattern 1 (exploration + delegation), then expand to other patterns

---

## See Also

- `agent-team.ts` — Implementation details
- `../agents/` — Specialist agent definitions
- `.pi/agents/teams.yaml` — Team membership and composition
