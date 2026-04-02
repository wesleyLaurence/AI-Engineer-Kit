# Subagents

## The Problem: Some Tasks Are Too Big for One Agent

A single agent working on a complex task faces two problems: the context window fills up with accumulated history, and the agent has to hold too many concerns in mind at once. Complex multi-step tasks with diverse requirements often exceed what a single agent loop can handle well.

Subagents solve this by delegation. An orchestrator agent breaks a complex task into smaller pieces and delegates each piece to a specialized subagent. Each subagent has a focused context, clear responsibility, and returns its results to the orchestrator. The orchestrator synthesizes everything into a final result.

---

## The Orchestrator-Worker Pattern

This is the fundamental architecture for subagent systems.

### The Orchestrator

The orchestrator is the "manager" agent. It:
- Receives the overall task from the user
- Breaks it into subtasks
- Delegates subtasks to specialized subagents
- Collects and synthesizes results
- Returns the final result to the user

The orchestrator doesn't do the detailed work itself. Its job is planning, delegation, and synthesis.

### The Workers (Subagents)

Each subagent is a focused specialist. It:
- Receives a specific subtask with clear instructions
- Has its own tools relevant to its specialty
- Works in its own context (clean, focused, not polluted by other tasks)
- Returns a structured result to the orchestrator

### Why This Works

**Focused context.** Each subagent only sees what's relevant to its specific task. A research subagent doesn't need deployment tools in its context. A code review subagent doesn't need the web search results from the research phase.

**Parallel execution.** Independent subtasks can run simultaneously. If you need research AND code analysis AND documentation review, three subagents can work at the same time.

**Specialization.** Different subagents can use different models, tools, and prompts optimized for their specific task. A summarization task might use a fast, cheap model. A complex reasoning task might use the most capable model available.

---

## When to Delegate vs. Do It Yourself

### Use Subagents When

- The overall task has clearly separable subtasks
- Different subtasks need different tools or context
- Subtasks can run in parallel for speed
- The context would get too large for a single agent
- Different subtasks benefit from different models

### Keep It in One Agent When

- The task is sequential and each step depends on the previous
- The context is manageable (under ~50K tokens)
- The overhead of orchestration isn't worth the benefit
- Subtasks are so interrelated that separating them loses important context

---

## Communication Between Agents

### Input to Subagents

Be specific in the instructions you pass to subagents. Include:
- The specific task (not the overall goal — just this subtask)
- Relevant context (only what this subagent needs)
- Expected output format (so the orchestrator can process results)
- Constraints (time limits, token budgets, scope boundaries)

### Output from Subagents

Subagent results should be structured and predictable:
- A status indicator (success, partial, failed)
- The actual result in a consistent format
- Any warnings or caveats
- Metadata (tokens used, tools called, time taken)

---

## Parallel vs. Sequential Execution

### Parallel
Independent subtasks run simultaneously. Dramatically faster when tasks don't depend on each other. The orchestrator launches all subtasks, waits for all to complete, then synthesizes.

### Sequential
Each subtask depends on the previous one's output. The orchestrator runs them one at a time, passing results forward. Necessary when there are real dependencies.

### Mixed
Some tasks are parallel, some are sequential. Research and data gathering run in parallel; analysis depends on the gathered data and runs after; reporting depends on the analysis. A good orchestrator identifies the dependency graph and maximizes parallelism.

---

## Error Handling

### When a Subagent Fails

The orchestrator needs a strategy:
- **Retry** — Run the subagent again, possibly with modified instructions
- **Skip** — Continue without this subtask's results (if it's optional)
- **Substitute** — Try a different approach to get the same information
- **Escalate** — Ask the user for help or report partial results

### Partial Results

If some subagents succeed and others fail, the orchestrator should still return useful output with clear indication of what's missing and why.

---

## Managing State

### Context Isolation

Each subagent gets a clean context. It doesn't see other subagents' work, the orchestrator's internal planning, or the user's full conversation history. It gets only what it needs for its specific task.

### Result Aggregation

The orchestrator collects results from all subagents and holds them in its own context. This is where the context can grow large — if you have 10 subagents each returning 2K tokens of results, the orchestrator needs 20K tokens just for results plus its own instructions and the original task.

Plan for this. The orchestrator might need to summarize subagent results rather than including them verbatim.

---

## Key Takeaways

- Subagents solve the problem of tasks too complex for a single agent's context
- The orchestrator-worker pattern: plan, delegate, collect, synthesize
- Each subagent gets focused context and clear instructions — this is the main benefit
- Parallelize independent subtasks for speed; sequence dependent ones
- Error handling is critical — subagents will fail, and the orchestrator needs strategies
- Keep communication structured: clear inputs, predictable outputs
- Don't use subagents when a single agent can handle the task — orchestration adds overhead
