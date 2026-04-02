---
name: tool-calling
description: Teaches tool calling — how LLMs use tools, function definitions, schemas, and the call-and-response pattern. Use when the learner is ready to add tools to their agent or asks about function calling.
---

# Topic: Tool Calling

## When to Use
- Phase 2, fourth topic (after streaming)
- Learner asks about function calling, tools, or how to let an LLM interact with external systems
- Learner wants to add capabilities (search, APIs, databases) to their chatbot
- Revisiting to add new tools or improve tool design for their project

## Prerequisites
- `streaming` topic complete (working chatbot with memory and streaming)
- Understands system prompts and the messages format

## Concept References
- `references/tool-calling.md` — read this before teaching
- `wisdom/tool-design.md` — weave in tool design principles and common mistakes

---

## Teaching Flow

### Open
Start with the problem: "Your chatbot can have a conversation, but it is trapped in its own head. Ask it what the weather is right now. Ask it to look something up on the web. Ask it about data that was created after its training cutoff. It cannot do any of these things because it has no way to interact with the outside world. Tools fix that."

Frame tools as what turns a chatbot into an agent. This is a pivotal moment in the curriculum.

### Core Points to Cover

**Why tools matter:**
- LLMs are frozen in time — they know nothing after their training cutoff.
- LLMs cannot take actions — they can only generate text.
- Tools give the model the ability to do things: search the web, call APIs, read files, query databases, perform calculations.
- This is the bridge from "chatbot" to "agent."

**The tool calling flow:**
- You define tools by giving the model a list of function schemas (name, description, parameters).
- The model does NOT call the tools itself. It generates a structured request saying "I want to call this tool with these arguments."
- Your code actually executes the tool and sends the result back to the model.
- The model then incorporates the tool result into its response.
- Walk through this flow step by step — it is the most important thing to understand.

**Tool definitions and schemas:**
- Each tool has a name, a description, and a JSON Schema for its parameters.
- The description is critical — it tells the model WHEN to use the tool. A bad description means the model will use it at the wrong times or not at all.
- Parameter descriptions matter too — they guide the model to pass the right arguments.
- Good schema design is a skill. Reference the tool-design wisdom.

**Types of tools:**
- Information retrieval (web search, database queries, API calls)
- Computation (calculations, data processing)
- Actions (sending emails, creating files, updating records)
- Each type has different considerations for error handling and confirmation flows.

**The multi-step pattern:**
- The model can call multiple tools in sequence to answer a complex question.
- Tool results become part of the conversation context for subsequent reasoning.
- This is the foundation of agentic behavior — the model reasoning about what to do, doing it, observing the result, and deciding what to do next.

### Close
Connect to the build: "Let's give your chatbot some real capabilities. What tools would be most useful for your project?"

---

## Adaptive Notes

**Experienced developers:** They will grasp the pattern quickly — it is essentially an API-mediated callback system. Focus on the nuances: schema design, description writing, error handling, and when the model chooses the wrong tool. Spend more time on the build and less on the concept.

**Beginners:** The indirection can be confusing — "the model asks you to call a tool, then you call it, then you send the result back." Walk through a complete example step by step, tracing the data flow. Use a diagram or write out the sequence explicitly. Do not move on until the flow makes sense.

**Returning learners (review mode):** Focus on improving their existing tools. Review their tool schemas for clarity. Check if the model is using tools correctly or making errors. Add new tools relevant to their project.

---

## Build

Add tools to their chatbot. Start with something simple and immediately useful, then add tools that connect to their project.

See `references/build-details.md` for the complete step-by-step build guide.

**Milestone:** First agent with tools.

---

## Understanding Checks
- Can they explain the tool calling flow — from definition to invocation to result?
- Can they design a good tool schema with clear descriptions?
- Do they understand that the model does not execute tools — it generates requests that your code executes?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Tool Calling" complete in `learner/progress.md`
- Working chatbot with at least one functional tool
- Add observations about their tool design instincts to `learner/notes.md`
- Update `learner/project.md` with tools added and any architecture decisions
- **Milestone:** First agent with tools
- Proceed to the next topic: `rag`
