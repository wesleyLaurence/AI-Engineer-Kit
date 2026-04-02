---
name: context-engineering
description: Teaches the art of managing what the model sees -- token budgets, context prioritization, what to include and exclude, and how context size affects performance and cost. Use when the learner asks about context windows, token limits, context management, or optimizing what goes into a prompt.
---

# Topic: Context Engineering

## When to Use
- Phase 3, after agent-skills
- Learner asks about context windows, token limits, or managing context
- Learner asks about why responses degrade with long conversations
- Learner encounters context-related issues (truncation, lost information, cost spikes)

## Prerequisites
- `agent-skills` topic complete (they have seen context engineering at the repo level)
- Working familiarity with agents and tool calling

## Concept References
- `references/context-engineering.md` -- read this before teaching
- `wisdom/performance-and-cost.md` -- the practical cost and performance implications

---

## Teaching Flow

### Open with the Problem
Start with a concrete experience: "Have you noticed that sometimes a model seems to forget things from earlier in a conversation? Or that a long conversation costs dramatically more than a short one? Or that stuffing everything into the prompt sometimes makes the model worse, not better? That is all context engineering -- and it might be the most underappreciated skill in AI engineering."

### Core Points to Cover

**What context is and why it matters:**
- The context window is everything the model sees: system prompt, conversation history, retrieved documents, tool results, everything
- The model has no memory beyond this window. If it is not in the context, it does not exist.
- Context is finite, expensive, and not all equally useful

**Token budgets:**
- Every model has a context window limit (4K, 8K, 32K, 128K, 200K, 1M)
- Bigger is not always better -- cost scales with input tokens, and attention degrades over very long contexts
- Reference `wisdom/performance-and-cost.md` for the cost implications
- The practical calculation: how much room do you have for the system prompt, history, retrieved docs, and the model's response?

**Context prioritization -- what to include and exclude:**
- Not everything is relevant. Stuffing irrelevant information hurts performance.
- The prioritization hierarchy: instructions > immediately relevant context > background context > nice-to-have
- Techniques: summarization of older history, selective retrieval (RAG), truncation strategies
- The "lost in the middle" problem -- models pay more attention to the beginning and end of context

**Context engineering strategies:**
- System prompt design -- what goes in the persistent instructions vs. what is dynamic
- Conversation management -- when to summarize, when to truncate, when to start fresh
- RAG as context engineering -- retrieving only what is relevant rather than including everything
- Tool results -- return concise, structured results rather than dumping raw data

**The connection to everything they have built:**
- RAG is context engineering (putting the right documents in context)
- Memory management is context engineering (deciding what conversation history to keep)
- Agent skills are context engineering (scoping what the agent knows about)
- System prompts are context engineering (setting the baseline instructions)

### Close
"Context engineering is not a separate skill -- it is the thread that runs through everything you have built. Every time you decide what the model should see, you are doing context engineering. The best AI engineers think about this constantly."

---

## Adaptive Notes

**Experienced developers:** They will appreciate the systems-level framing. Focus on the quantitative aspects -- token costs, performance characteristics, the tradeoff curves. Draw parallels to memory management in traditional systems. 15-20 minutes.

**Beginners:** Use concrete examples throughout. Show them a short prompt vs. a long prompt and discuss what changes. Walk through a token budget calculation for their project. Make the abstract concrete. 25-35 minutes.

**Returning learners (review mode):** Ask them to audit their own project's context usage. Where are they wasting tokens? Where are they missing important context? This is a great diagnostic exercise.

---

## Understanding Checks
- Can the learner explain what the context window is and why its size matters?
- Can they describe how context size affects both cost and performance?
- Can they articulate strategies for managing context -- what to include, what to exclude, and why?
- Can they connect context engineering to the systems they have already built (RAG, memory, agents)?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Context Engineering" complete in `learner/progress.md`
- Add observations about their context awareness to `learner/notes.md`
- Proceed to `human-in-the-loop`
