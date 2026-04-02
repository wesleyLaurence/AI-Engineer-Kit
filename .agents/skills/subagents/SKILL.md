---
name: subagents
description: Teaches how to break complex tasks into subtasks delegated to specialized agents. Covers orchestration patterns and when multi-agent is the right architecture. Use when the learner asks about subagents, multi-agent systems, agent orchestration, or dividing work across agents.
---

# Topic: Subagents and Multi-Agent Systems

## When to Use
- Phase 3, after human-in-the-loop
- Learner asks about subagents, multi-agent systems, or agent orchestration
- Learner has a task that is too complex for a single agent
- Learner asks about dividing work across specialized agents

## Prerequisites
- `react-agents` topic complete (they understand single-agent architecture)
- `agentic-workflows` topic complete (they understand the complexity spectrum)
- `human-in-the-loop` topic complete (they understand oversight patterns)

## Concept References
- `references/subagents.md` -- read this before teaching
- `references/multi-agent-systems.md` -- the broader multi-agent landscape

---

## Teaching Flow

### Open with the Problem
Start with a complexity problem: "Your agent is doing research, writing code, reviewing its own code, running tests, and fixing bugs -- all in one loop. It works for simple tasks, but for complex ones it gets confused, loses track of what it was doing, and makes mistakes. Sound familiar? The solution is the same as in human teams: specialize and delegate."

### Core Points to Cover

**What subagents are:**
- An orchestrator agent that delegates specific tasks to specialized child agents
- Each subagent has a focused purpose, its own tools, and its own context
- The orchestrator decides what to delegate, coordinates results, and maintains the big picture
- This is not two agents chatting -- it is a clear hierarchy with a single point of control

**Why subagents help:**
- Focused context -- each subagent only sees what it needs for its task. No context pollution.
- Specialized prompts -- a code review agent can have review-specific instructions without cluttering the main agent
- Parallel execution -- independent subtasks can run simultaneously
- Failure isolation -- if a subtask fails, it does not corrupt the orchestrator's state

**Orchestration patterns:**
- **Sequential delegation** -- one subtask at a time, results fed back to orchestrator
- **Parallel delegation** -- multiple independent subtasks launched simultaneously
- **Pipeline** -- output of one subagent feeds into the next
- **Iterative** -- orchestrator sends work to a subagent, reviews the result, sends it back for revision

**When multi-agent is the right architecture:**
- The task naturally decomposes into distinct, well-defined subtasks
- Different subtasks need different tools, models, or context
- A single agent's context window is getting overloaded
- You need parallelism for performance

**When multi-agent is unnecessary complexity:**
- The task is simple enough for one agent
- The subtasks are tightly coupled (constant communication overhead negates the benefit)
- You are adding agents for the sake of it rather than solving a real problem
- Reference the agentic-workflows principle: start simple, add complexity only when justified

**Practical considerations:**
- How subagents communicate (structured outputs, shared state, message passing)
- Error handling and retry at the orchestration level
- Cost implications -- each subagent is a separate LLM invocation
- Debugging multi-agent systems -- tracing becomes critical

### Close
"Subagents are powerful when the task genuinely requires specialization and delegation. But remember the agentic-workflows lesson: if one agent can handle it, one agent should handle it. Multi-agent is a tool for managing complexity, not a default architecture."

---

## Adaptive Notes

**Experienced developers:** They will immediately see the parallels to microservices vs. monoliths. Draw the analogy explicitly -- same tradeoffs apply. Focus on the orchestration patterns and when each is appropriate. 15-20 minutes.

**Beginners:** Walk through a concrete example step by step. Take a complex task (like "research a topic and write a report with code examples"), decompose it into subtasks, assign each to a subagent, and trace through the orchestration. 25-35 minutes.

**Returning learners (review mode):** Ask them to evaluate their project. Is there a task that would benefit from subagents? Have them design the decomposition and explain their reasoning.

---

## Understanding Checks
- Can the learner explain what subagents are and how they differ from a single complex agent?
- Can they describe at least two orchestration patterns?
- Can they identify a task in their project that would benefit from subagents, and explain the decomposition?
- Can they articulate when multi-agent adds unjustified complexity?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Subagents" complete in `learner/progress.md`
- Add observations about their multi-agent thinking to `learner/notes.md`
- Proceed to `deep-agents`
