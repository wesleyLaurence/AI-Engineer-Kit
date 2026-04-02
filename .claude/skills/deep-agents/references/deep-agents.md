# Deep Agents

## What Makes an Agent "Deep"

Most agents handle short, interactive tasks — a user asks something, the agent works for a few seconds to a few minutes, and returns a result. Deep agents are different. They're long-running, autonomous workflows that can work for minutes to hours on complex tasks with minimal human intervention.

Think of a regular agent as a conversation. Think of a deep agent as delegating a project.

"Research every competitor in this space, analyze their pricing models, identify gaps in the market, and produce a strategy document." That's not a quick chat response — it's hours of work involving dozens of tool calls, multiple research paths, intermediate analysis, and document generation.

---

## When Deep Agents Are the Right Architecture

### Complex Research Tasks
Tasks that require exploring multiple sources, following chains of information, synthesizing findings across many documents. The agent needs autonomy to pursue leads and adjust its approach based on what it finds.

### Code Generation and Refactoring at Scale
Large-scale code changes across many files — migrating an API, refactoring a pattern throughout a codebase, implementing a feature that touches many components. The agent plans, executes, tests, and iterates.

### Data Processing Pipelines
Processing large datasets with intelligent decision-making at each step. Cleaning, categorizing, analyzing, summarizing — tasks that require judgment, not just mechanical processing.

### Automated Testing and Evaluation
Running comprehensive test suites, analyzing results, diagnosing failures, and proposing fixes. The iterative nature of debugging benefits from autonomous operation.

---

## Sandboxes and Code Execution

Deep agents often need to run code — test their changes, execute scripts, process data. Running arbitrary agent-generated code in your production environment is dangerous. Sandboxes solve this.

### What a Sandbox Provides

- **Isolation** — Agent-generated code runs in a contained environment that can't affect your main system
- **Resource limits** — CPU, memory, and time limits prevent runaway processes
- **Network control** — Restrict what the agent's code can access on the network
- **Clean state** — Each execution starts from a known state, preventing accumulated side effects

### Types of Sandboxes

**Container-based** — Docker containers provide strong isolation with flexible configuration. The agent can install packages, run complex scripts, and access files within the container.

**VM-based** — Virtual machines provide the strongest isolation. Used when security is paramount.

**Language-level** — Python's subprocess with restricted permissions, or WebAssembly sandboxes. Lighter weight but less isolation.

---

## Async Patterns

Deep agents work asynchronously — you kick off the task and check back later. This requires different architecture than synchronous chat.

### The Async Workflow

1. **Submit** — The user describes the task. The system acknowledges and begins processing.
2. **Progress** — The agent works autonomously. Progress updates are available for monitoring.
3. **Check-in** — The user can check status, view intermediate results, or provide course corrections.
4. **Complete** — The agent finishes and presents results for review.

### Progress Reporting

Long-running agents should report progress:
- What phase they're in (researching, analyzing, writing)
- What they've accomplished so far
- How much is remaining (estimated)
- Any issues or decision points that might need human input

### Checkpointing

Save intermediate state periodically. If the agent fails or is interrupted, it can resume from the last checkpoint rather than starting over. This is especially important for tasks that take hours.

---

## Monitoring and Intervention

### Why Monitoring Matters

A deep agent running for hours with no oversight is risky. It might:
- Get stuck in a loop (burning tokens with no progress)
- Pursue the wrong approach (spending time on something irrelevant)
- Accumulate errors (each step builds on potentially flawed previous steps)
- Exceed budget (token costs accumulate)

### What to Monitor

- **Token usage** — Track cumulative tokens against a budget
- **Tool call patterns** — Detect loops (same tool, same args, repeated)
- **Progress indicators** — Is the agent making forward progress or spinning?
- **Error rate** — How many tool calls are failing?
- **Time** — Is the agent taking longer than expected?

### Intervention Options

**Pause** — Stop the agent and review its current state and approach.
**Redirect** — Give the agent new instructions or correct its approach without restarting.
**Abort** — Stop the agent and discard its work (or save intermediate results).
**Budget adjustment** — Give the agent more tokens or time if the task is proving larger than expected.

---

## Risks and Safeguards

### Cost Explosion
Deep agents can burn through large amounts of tokens. Always set a budget with a hard cap. Alert when the agent reaches 50%, 75%, and 90% of its budget.

### Quality Degradation
As the context fills with intermediate results, the agent's reasoning quality can degrade. Strategies: periodically summarize and compress the context, use subagents for independent subtasks to keep contexts focused.

### Cascading Errors
An error early in a long workflow can corrupt all subsequent work. Build validation checkpoints that verify intermediate results before the agent proceeds.

### Scope Creep
Deep agents can wander — exploring tangential paths, going deeper than necessary on interesting but irrelevant details. Clear task boundaries and periodic scope checks prevent this.

---

## Key Takeaways

- Deep agents handle long-running, complex tasks that require sustained autonomous work
- Sandboxes are essential for safe code execution — never run agent-generated code in production without isolation
- Async patterns (submit, progress, check-in, complete) are the architecture for deep agents
- Monitoring is non-negotiable — track tokens, progress, errors, and time
- Set hard budget limits to prevent cost explosions
- Checkpoint intermediate state so the agent can recover from interruptions
- Not every task needs a deep agent — use them when the task genuinely requires sustained autonomous work
