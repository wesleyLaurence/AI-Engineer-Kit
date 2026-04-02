---
name: agentic-workflows
description: Teaches when and why to use agents vs. simple chains or pipelines. Covers the spectrum from simple prompts to full agents and when added complexity is justified. Use when the learner asks about agent architectures, when to use agents, or how to choose between chains and agents.
---

# Topic: Agentic Workflows

## When to Use
- Phase 3, first topic
- Learner asks about agent architectures or when to use agents
- Learner asks about the difference between chains, pipelines, and agents
- Learner is considering whether their project needs an agent

## Prerequisites
- Phase 2 complete (RAG, tool calling, memory concepts understood)
- Learner has a working chatbot or RAG system

## Concept References
- `references/agentic-workflows.md` -- read this before teaching
- `wisdom/architecture-decisions.md` -- the tradeoffs that matter when choosing architectures

---

## Teaching Flow

### Open with the Problem
Start with a real decision: "You have a working chatbot that can call tools and retrieve documents. Now the question is -- should you make it an agent? And what does that even mean? The answer is not always yes, and getting this wrong is one of the most common mistakes in AI engineering."

The point: agents add complexity. That complexity must be justified by the task.

### Core Points to Cover

**The spectrum of autonomy:**
Walk through the progression, using concrete examples at each level:
- **Simple prompt** -- one input, one output. No decisions. "Summarize this document."
- **Chain** -- a fixed sequence of steps. Each step feeds the next. "Extract key points, then generate a summary, then translate." The steps are predetermined.
- **Router** -- the model decides which path to take, but each path is predefined. "Is this a billing question or a technical question? Route to the right handler."
- **Agent** -- the model decides what to do, does it, observes the result, and decides what to do next. The path is not predetermined. The model has genuine autonomy.

**When agents are the right choice:**
- The task requires dynamic decision-making -- the next step depends on what you learn
- Multiple tools need to be composed in ways you cannot predict in advance
- The problem space is open-ended -- you cannot enumerate all paths

**When agents are overkill:**
- The steps are predictable -- just use a chain
- You only need to classify and route -- use a router
- The task is simple enough for a single prompt
- Reference `wisdom/architecture-decisions.md` -- the principle that simpler architectures are cheaper, faster, more predictable, and easier to debug

**The cost of agency:**
- More tokens (the model thinks out loud)
- More latency (multiple LLM calls in a loop)
- Less predictable (harder to test, harder to guarantee behavior)
- Harder to debug (agent reasoning can be opaque)

### Close
The key takeaway: "Start with the simplest architecture that solves the problem. Upgrade to agents only when the task genuinely requires dynamic decision-making. Most production AI systems are chains or routers, not agents."

---

## Adaptive Notes

**Experienced developers:** They will likely appreciate the architecture framing. Focus on the decision framework -- when to use what. Draw parallels to other engineering decisions about complexity vs. capability. Keep it to 15-20 minutes.

**Beginners:** Spend more time on the spectrum with concrete examples. Make each level tangible before moving to the next. The chain vs. agent distinction is the most important one to nail. 25-35 minutes.

**Returning learners (review mode):** Ask them to classify their own project's architecture. Are they using an agent where a chain would suffice? Or vice versa?

---

## Understanding Checks
- Can the learner explain the difference between a chain, a router, and an agent?
- Can they give an example of a task suited to each architecture level?
- Can they articulate when an agent adds unjustified complexity?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Agentic Workflows" complete in `learner/progress.md`
- Add observations about their architecture intuition to `learner/notes.md`
- Proceed to `react-agents`
