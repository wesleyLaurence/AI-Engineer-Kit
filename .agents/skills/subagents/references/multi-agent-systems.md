# Multi-Agent Systems

## The Problem: Complexity Beyond One Agent

Some tasks are genuinely too complex for a single agent — even with subagents. They require different specialists collaborating, different perspectives being synthesized, or different phases of work with distinct requirements.

Multi-agent systems coordinate multiple agents working together toward a shared goal. Each agent has its own role, tools, and expertise. They communicate, share results, and build on each other's work.

But here's the honest truth: **multi-agent systems are often over-engineered.** The field is full of impressive demos that don't translate to practical applications. Before building a multi-agent system, be very sure a single agent with subagents can't do the job.

---

## When Multi-Agent Actually Makes Sense

### Genuine Role Separation
Different parts of the task require fundamentally different expertise and tools. A code writer and a code reviewer have different objectives — combining them in one agent creates conflicting instructions. Separate agents with separate system prompts work better.

### Adversarial Validation
Having one agent check another's work is more reliable than having an agent check its own work. A "generator" and a "critic" working in tandem catch errors that self-review misses.

### Simulation and Debate
Multiple agents representing different perspectives (customer, engineer, designer) can explore a problem space more thoroughly than a single agent trying to hold all perspectives simultaneously.

### Pipeline Architecture
Tasks with distinct phases where the output of one phase is the input to the next, and each phase has very different requirements. Data collection → Analysis → Report generation, where each phase benefits from a specialized agent.

---

## Orchestration Patterns

### Hierarchical
One manager agent directs multiple worker agents. The manager plans, delegates, reviews results, and decides next steps. Workers have no direct communication with each other — everything flows through the manager.

**Strengths:** Clear control structure, easy to reason about, deterministic coordination.
**Weaknesses:** The manager is a bottleneck. If it fails or makes poor decisions, the whole system fails.

### Pipeline (Sequential)
Agents form a chain. Each agent processes the output of the previous one and passes its result to the next. Like an assembly line — each station adds something specific.

**Strengths:** Simple to implement, predictable flow, easy to debug by examining each stage's output.
**Weaknesses:** No parallelism, failure at any stage stops the pipeline, total latency is the sum of all stages.

### Peer-to-Peer
Agents communicate directly with each other. No central coordinator. Each agent decides when to share information and with whom.

**Strengths:** Flexible, resilient to individual failures, can self-organize.
**Weaknesses:** Hard to control, unpredictable behavior, difficult to debug, easy to create infinite loops.

### Blackboard
A shared workspace (the "blackboard") where agents post information and read from. Agents work independently, monitoring the blackboard for relevant updates and contributing their results.

**Strengths:** Decoupled agents, natural asynchrony, easy to add or remove agents.
**Weaknesses:** Coordination is implicit (agents need to know what to look for), the blackboard can get noisy.

---

## Communication Between Agents

### Structured Messages
Agents communicate via structured messages with clear schemas. "I found these 5 relevant papers: [...]" rather than free-form text. Structure makes parsing reliable and reduces misinterpretation.

### Shared State
A shared data store (database, file system, or in-memory structure) that all agents can read and write. Good for accumulating results. Requires careful management of concurrent access.

### Direct Invocation
One agent directly calls another as if it were a tool. The "calling" agent passes input and receives output. Simple but creates tight coupling between agents.

---

## State Management

Multi-agent systems have a state management challenge: each agent has its own context, but they need shared understanding.

### What Each Agent Needs
- Its own system prompt (role-specific instructions)
- The current task or subtask
- Results from other agents that are relevant to its work
- Shared facts or decisions that affect everyone

### What to Share vs. Isolate
- **Share:** Task objectives, key decisions, constraints, final results from other agents
- **Isolate:** Agent-specific reasoning, intermediate tool call results, internal scratchpad

Over-sharing floods agents with irrelevant context. Under-sharing causes agents to duplicate work or make contradictory decisions.

---

## The Complexity Tax

Every agent you add multiplies complexity:
- More LLM calls (cost)
- More points of failure (reliability)
- More communication overhead (latency)
- Harder to debug (observability)
- More difficult to reproduce results (determinism)

### The Single-Agent Baseline

Before building a multi-agent system, try:
1. A single agent with well-chosen tools
2. A single agent with subagents for parallelism
3. A chain of prompts with no agent loop

If any of these work, they're almost certainly better than a multi-agent system. Multi-agent should be the last resort, not the first idea.

---

## Practical Multi-Agent Patterns That Work

### Generator-Critic
Two agents: one generates output, the other reviews it. The generator revises based on feedback. This back-and-forth continues until the critic approves or a maximum number of iterations is reached. Simple, effective, and one of the few multi-agent patterns that consistently outperforms single-agent approaches.

### Specialist Router
A routing agent examines the task and delegates to the appropriate specialist. Each specialist is optimized for a specific domain. The router doesn't coordinate between specialists — it just picks the right one for each task.

### Staged Pipeline
Agents form a production line. Researcher → Analyst → Writer → Editor. Each stage has clear input/output contracts. Easy to test each stage independently.

---

## Key Takeaways

- Multi-agent systems coordinate multiple specialized agents toward a shared goal
- They're often over-engineered — most tasks are better served by a single agent with good tools
- Use multi-agent when you have genuine role separation, adversarial validation, or pipeline architectures
- The generator-critic pattern is the most reliably useful multi-agent design
- Every agent added multiplies cost, complexity, and failure modes
- Always try single-agent solutions first — add agents only when single-agent genuinely can't solve the problem
- State management is the hardest challenge: share enough for coordination, isolate enough for focus
