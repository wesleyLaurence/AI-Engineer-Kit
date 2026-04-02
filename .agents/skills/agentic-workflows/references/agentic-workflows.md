# Agentic Workflows

## The Problem: Not Everything Needs an Agent

"Agent" is the buzzword of AI engineering, and it's overused. Most AI applications don't need a fully autonomous agent making decisions in a loop. Many can be solved with a simple LLM call, a chain of calls, or a basic router. Understanding the spectrum of complexity — and choosing the right level — is what separates good architecture from hype-driven architecture.

The rule of thumb: **start with the simplest approach that works and add complexity only when forced.** Every level of autonomy you add brings capability but also brings unpredictability, debugging difficulty, and cost.

---

## The Complexity Spectrum

### Level 1: Simple LLM Call
A single prompt-in, response-out API call. The model reads input, generates output, done.

**Use when:** The task is straightforward and self-contained. Summarization, classification, translation, simple question answering. No external data needed, no multi-step reasoning required.

**Example:** "Classify this support ticket as billing, technical, or general."

### Level 2: Chain (Sequential Steps)
Multiple LLM calls executed in a fixed sequence, where each step's output feeds into the next step's input.

**Use when:** The task has distinct stages that benefit from being handled separately. The sequence is predictable and doesn't change based on intermediate results.

**Example:** Extract key facts from a document → Generate a summary from those facts → Translate the summary to Spanish. Three steps, always in the same order.

### Level 3: Router (Conditional Branching)
An LLM examines the input and routes it to the appropriate handler — which might be another LLM call, a specific function, or a different chain.

**Use when:** Different inputs need fundamentally different handling. The branching logic is based on the input, not on intermediate results.

**Example:** A customer support system that routes "billing" questions to one handler, "technical" questions to another, and "general" questions to a third.

### Level 4: Agent (Autonomous Decision-Making)
An LLM in a loop that decides what to do next based on what's happened so far. It has access to tools and can call them as needed, iterating until it achieves the goal.

**Use when:** The task requires multi-step reasoning where the steps aren't predictable in advance. The model needs to adapt its approach based on intermediate results. External tools or data sources need to be consulted dynamically.

**Example:** "Research the latest pricing for AWS EC2 instances, compare them to our current costs, identify optimization opportunities, and write a summary report." The model needs to search, read, analyze, and write — and the specific steps depend on what it finds.

---

## When Agents Are the Right Choice

- The task requires **dynamic tool use** — the model needs to decide which tools to call and in what order
- The steps aren't predictable — the model needs to **react to intermediate results**
- The task involves **multi-step reasoning** across external data sources
- The task is **goal-directed** — there's a clear objective but the path to it varies

## When Agents Are Overkill

- The task can be solved with a single well-crafted prompt
- The processing steps are always the same (use a chain)
- The routing logic is based on input classification only (use a router)
- You need predictable, deterministic behavior (agents are non-deterministic by nature)
- Cost and latency are critical constraints (agents make multiple LLM calls)

---

## The Cost of Agency

Each level of the spectrum adds cost:

| Level | LLM Calls | Predictability | Debuggability | Cost |
|---|---|---|---|---|
| Simple call | 1 | High | Easy | Low |
| Chain | 2-5 | High | Moderate | Moderate |
| Router | 2+ | Moderate | Moderate | Moderate |
| Agent | Unknown | Low | Hard | High |

The "unknown" number of LLM calls for agents is the key concern. An agent might solve a task in 3 calls or 15. It might get stuck in a loop. Each call costs money and adds latency.

---

## Building Up, Not Down

The right approach is to start at the simplest level and move up only when you need to:

1. Can a single LLM call solve this? Try it first.
2. Does it need multiple steps? Build a chain.
3. Does it need to route different types of input? Add a router.
4. Does it need to make dynamic decisions with tools? Build an agent.

Most people jump to "agent" because it sounds impressive. Most production applications are better served by chains and routers.

---

## Key Takeaways

- Agents are one point on a spectrum of complexity — not the default choice
- Simple LLM calls, chains, and routers solve most problems with less cost and more predictability
- Agents are the right choice when tasks require dynamic, multi-step reasoning with tools
- Every level of autonomy you add makes the system harder to debug and more expensive to run
- Start simple and add complexity only when the simpler approach genuinely can't solve the problem
