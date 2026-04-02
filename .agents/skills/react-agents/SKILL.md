---
name: react-agents
description: Teaches the ReAct agent loop -- think, act, observe, repeat -- and guides building a ReAct agent with tools. Use when the learner asks about ReAct agents, agent loops, or how agents decide what to do next.
---

# Topic: ReAct Agents

## When to Use
- Phase 3, after agentic-workflows
- Learner asks about ReAct agents, agent loops, or how agents reason through tasks
- Learner is ready to build their first full agent

## Prerequisites
- `agentic-workflows` topic complete (they understand when agents are the right architecture)
- Tool calling concepts understood
- Working chatbot or RAG system

## Concept References
- `references/react-agents.md` -- read this before teaching
- `wisdom/debugging-agents.md` -- essential for when things go wrong

---

## Teaching Flow

### Open with the Problem
Start with what they already know and extend it: "Your chatbot can call tools when asked. But right now, you decide which tool to call and when. What if the model could decide for itself -- call a tool, look at the result, decide what to do next, call another tool, and keep going until the task is done? That is a ReAct agent, and it is the foundation of everything else in this phase."

### Core Points to Cover

**The ReAct loop:**
Walk through the core cycle, making each step concrete:
- **Think** -- the model reasons about what to do next. This is visible in the agent's "thought" or "reasoning" step.
- **Act** -- the model decides on an action (calling a tool with specific parameters)
- **Observe** -- the model receives the result of the action
- **Repeat** -- based on the observation, the model decides whether to take another action or produce a final response

This loop continues until the model decides the task is complete or a safety limit is hit.

**How it works mechanically:**
- The system prompt tells the model it has access to tools and should use them to accomplish tasks
- The model's response includes a tool call (structured output with tool name and parameters)
- The framework executes the tool and feeds the result back as a new message
- The model sees the full history: its reasoning, the tool call, and the result
- It then decides: do I need another tool call, or am I done?

**What makes a good agent:**
- Clear tool descriptions -- the model can only use tools it understands
- A focused system prompt that guides behavior without over-constraining
- Appropriate model selection -- more complex reasoning needs more capable models
- Safety limits -- maximum iterations to prevent infinite loops

**Common agent failures:**
Reference `wisdom/debugging-agents.md`:
- Wrong tool selection (vague descriptions, overlapping tools)
- Infinite loops (model retries the same failed approach)
- Hallucinated tool calls (inventing tools that do not exist)
- Over-reasoning (thinking too much instead of acting)
- Under-reasoning (acting without thinking)

**Tracing and debugging:**
- Always log the full execution trace: every thought, action, and observation
- The trace is how you debug agent behavior
- When something goes wrong, read the trace step by step -- the model's reasoning is visible

### Close
Transition to the build: "Now you understand the loop. Let's build one. You are about to create your first ReAct agent -- it will think, act, observe, and solve real tasks for your project."

---

## Build

Build a ReAct agent connected to their project using LangChain.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Design the agent's purpose and scope
2. Define 3-5 tools with clear descriptions
3. Set up the agent with LangChain
4. Test with simple tasks, tracing the reasoning
5. Test with complex multi-step tasks
6. Add error handling
7. Connect to their project

**Milestone:** First full ReAct agent.

---

## Adaptive Notes

**Experienced developers:** They may already be familiar with agent frameworks. Focus on the reasoning loop, debugging strategies, and the wisdom from `wisdom/debugging-agents.md`. The build should move quickly -- 30-45 minutes total.

**Beginners:** Spend more time on the conceptual understanding of the loop before building. Walk through a hand-traced example of think-act-observe before touching code. The build will take longer -- 60-90 minutes.

**Returning learners (review mode):** If they already have an agent, focus on debugging and optimization. Have them trace through their agent's execution and identify where it could be improved.

---

## Understanding Checks
- Can the learner explain each step of the ReAct loop: think, act, observe, repeat?
- Can they trace through their agent's reasoning and explain each step?
- Can they identify common agent failures and how to debug them?
- Is their agent working with real tools connected to their project?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Working ReAct agent with multiple tools
- Learner can trace agent reasoning and debug failures
- Error handling implemented
- Code saved in `projects/`
- Mark "ReAct Agents" complete in `learner/progress.md`
- Add observations about their agent-building intuition to `learner/notes.md`
- **Milestone:** First full ReAct agent
- Proceed to `mcp-servers`
