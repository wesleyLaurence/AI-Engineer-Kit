---
name: coding-agents
description: Teaches how to work effectively with coding agents — giving clear instructions, reviewing AI-generated code, knowing when to intervene, and debugging agent mistakes. Use when the learner asks about working with coding agents, giving good instructions to AI, or reviewing AI-generated code.
---

# Topic: Working with Coding Agents Effectively

## When to Use
- Phase 0, second topic
- Learner asks about how to work with coding agents
- Learner asks about giving good instructions to AI or reviewing AI-generated code
- Learner is struggling with agent interactions and needs to revisit fundamentals

## Prerequisites
- `learning-experience` topic complete (learner understands the paradigm)

## Concept References
- `references/coding-agents.md` — read this before teaching

---

## Teaching Flow

### Open
Frame this as meta-learning: "You're about to learn AI engineering by working with me — a coding agent. So the first thing to learn is how to work with coding agents effectively. This is recursive, and it is also the single most practical skill you will develop."

Point out that they are already doing it right now. Every question they ask, every instruction they give — that is the skill.

### Core Points to Cover

**What coding agents are:**
- An LLM with the ability to take actions — read files, write code, run commands, search the web
- Not just autocomplete. They understand codebases, build features, debug errors
- The major agents: Claude Code, Cursor, Codex — same concepts apply across all of them

**How to give clear instructions:**
- Be specific about what you want. "Make this better" vs. "Add error handling that catches network errors and rate limits separately."
- Describe the outcome, not just the steps. Let the agent choose the implementation.
- Provide context about why. The "why" helps the agent make better decisions.
- Break complex work into steps. One thing at a time gives you checkpoints to review.

**How to review agent output:**
- Read before you accept. Does it make sense? Does it handle edge cases?
- Check architecture, not just syntax. The agent rarely makes syntax errors — it sometimes gets the bigger picture wrong.
- Test it. Run the code. Try edge cases. Break it intentionally.
- Watch for hallucinations. Verify unfamiliar APIs or library features.

**When to let the agent drive vs. take control:**
- Agent drives: boilerplate, well-defined tasks, refactoring, debugging, learning/exploring
- You drive: architectural decisions, security-sensitive code, subtle business logic, when the agent is going in circles

**How to debug agent mistakes:**
- Do not just say "that is wrong." Say what is wrong and why.
- Common failures: wrong library version, over-engineering, missing context, going in circles
- The effective debugging pattern: "Stop. Read [file]. The issue is [problem]. Here is what I think is happening. Fix it with [approach]."

**The agent as a learning tool:**
- Ask "why" constantly — why this approach, why this library, why async here
- Ask for alternatives and tradeoffs
- Ask it to explain, not just build

### Close
This is the most meta part of the curriculum. Reinforce that they will get better at this naturally as they progress — every topic from here on is practice.

---

## Adaptive Notes

**Experienced developers:** They likely already have intuitions about working with AI tools. Focus on the nuances — reviewing architecture vs. syntax, when to take manual control, the debugging pattern. Keep it to 10-15 minutes.

**Beginners:** Spend more time here. The idea that they should review and question AI output (rather than blindly accepting it) is critical to establish early. Emphasize that asking questions is the primary skill.

**Returning learners (review mode):** Focus on whatever they are struggling with. If they are giving vague instructions, drill into specificity. If they are accepting code without reviewing, drill into the review process.

---

## Understanding Checks
- Can the learner articulate what makes a good vs. bad instruction to a coding agent?
- Do they understand the difference between letting the agent drive and taking manual control?
- Can they describe how they would debug an agent mistake?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Working with Coding Agents Effectively" complete in `learner/progress.md`
- Add observations about their comfort level with agent interaction to `learner/notes.md`
- Proceed to Phase 1: `python-for-ai` (or `environment-setup` depending on learner background)
