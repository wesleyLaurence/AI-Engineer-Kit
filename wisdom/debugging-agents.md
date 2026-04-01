# Debugging Agents

How to figure out why your agent is broken. Systematic approaches to the most common agent failures.

---

### The First Rule: Print the Full Prompt

When an agent misbehaves, the first thing to check is what the model actually saw. Print or log the complete prompt — system message, conversation history, tool definitions, everything. Nine times out of ten, the problem is obvious when you see the actual input.

### The Debugging Hierarchy

When your agent isn't doing what you want, check in this order:

1. **The prompt** — Is the system prompt clear? Are the instructions unambiguous? Would a human reading this know what to do?
2. **The context** — Is the right information in the context? Is irrelevant information polluting it? Is the context too long?
3. **The tools** — Are tool descriptions clear? Do the parameters make sense? Is the model choosing the right tools?
4. **The model** — Is this model capable enough for the task? Would a more capable model solve the problem?

Most issues are in 1 or 2. People jump to blaming the model (4) when the problem is usually their prompt or context.

---

## Common Failure Modes

### Tool Schema Issues

The model isn't calling tools correctly — wrong arguments, wrong tool selection, or not calling tools at all.

**Diagnosis:** Read the tool definitions as if you were a human who'd never seen these tools. Are the names clear? Do the descriptions explain WHEN to use each tool? Are the parameters well-described?

**Fix:** Improve tool descriptions. Add examples of when to use the tool. Make parameter descriptions more explicit. Reduce the number of tools if there are too many.

### Context Overflow

The agent works fine for short conversations but degrades for long ones. Responses become less relevant, instructions are forgotten, the model seems confused.

**Diagnosis:** Check the total context size. Are you approaching the model's context window limit? Is conversation history growing unbounded?

**Fix:** Implement conversation summarization. Use a sliding window for history. Reduce system prompt size. Remove irrelevant tools.

### Infinite Loops

The agent calls the same tool repeatedly with the same or similar arguments, never making progress.

**Diagnosis:** Log every tool call. Look for patterns — same tool, same args, or oscillating between two tools.

**Fix:** Add loop detection (if the same tool is called with the same args twice, force the agent to try something different). Set a maximum iteration limit. Improve the system prompt to give the agent better decision-making guidance.

### Hallucinated Tool Calls

The model calls tools that don't exist, passes arguments that don't match the schema, or invents parameter values.

**Diagnosis:** Validate every tool call against your tool definitions before executing. Log invalid calls.

**Fix:** Simplify tool schemas. Use enum parameters where possible to constrain options. Ensure tool names are distinctive (avoid similar names that the model might confuse).

### Wrong Model for the Task

The agent technically works but makes poor decisions — choosing the wrong tools, misunderstanding complex instructions, producing low-quality output.

**Diagnosis:** Try the same task with a more capable model. If it works perfectly with a better model, the issue is model capability, not your code.

**Fix:** Upgrade to a more capable model for complex tasks. Or simplify the task — break it into smaller, simpler steps that a less capable model can handle.

---

## Debugging Techniques

### Step-by-Step Replay

Take the failing conversation and replay it step by step. At each step, read what the model saw and what it produced. Identify the specific step where things went wrong. This narrows the problem from "the agent is broken" to "the agent made a bad decision at step 4 because it didn't have X in context."

### Minimal Reproduction

Strip the failing case down to the minimum needed to reproduce it. Remove tools, simplify the prompt, shorten the conversation. When you find the simplest case that still fails, the cause is usually obvious.

### Prompt Ablation

Change one thing at a time in the prompt and see what happens. Remove a tool, change an instruction, add context. This isolates which part of the prompt is causing the issue.

### Tracing Tools

Use LangSmith, Langfuse, or custom logging to get full visibility into agent execution. Visual trace viewers make it easy to spot where the agent went wrong.

---

### When All Else Fails

If you've checked the prompt, context, tools, and model, and the agent is still misbehaving — simplify. Reduce the task complexity, reduce the number of tools, reduce the context. Build back up from something that works rather than debugging something complex that doesn't.
