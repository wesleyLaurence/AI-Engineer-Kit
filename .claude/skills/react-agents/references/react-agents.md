# ReAct Agents

## What Problem This Solves

Simple LLM calls answer questions. Chains process data through fixed steps. But what happens when you need an AI system that can figure out its own plan, execute it, adjust based on results, and keep going until the job is done?

That's what ReAct agents do. ReAct stands for **Reasoning + Acting** — the model reasons about what to do, takes an action (usually a tool call), observes the result, and decides what to do next. It's the core pattern behind most AI agents.

---

## The ReAct Loop

The agent runs in a loop with three phases:

### Think (Reasoning)
The model examines the current state — the user's original request, the conversation so far, the results of any previous tool calls — and reasons about what to do next. What information do I need? Which tool should I call? Am I done?

### Act (Tool Calling)
Based on its reasoning, the model calls a tool. Search the web, query a database, run a calculation, call an API. The model specifies which tool and what arguments.

### Observe (Processing Results)
The tool returns a result. The model incorporates this new information into its understanding. Does this answer the question? Do I need more information? Should I try a different approach?

### Repeat
The model returns to the Think phase with updated context. The loop continues until the model decides it has enough information to answer the user's question or complete the task.

---

## How the Model Decides What to Do

The model's decisions are driven by the prompt and context. At each step, it sees:

- The original user request
- The system prompt (which may include instructions about how to approach tasks)
- The available tools (with descriptions of when to use each)
- The history of previous actions and results (the "scratchpad")

Based on all of this, the model generates either a tool call (continue working) or a final response (done).

The quality of these decisions depends heavily on:
- How well the tools are described (clear descriptions = better tool selection)
- How well the system prompt defines the agent's approach
- The model's inherent reasoning capability (bigger models make better decisions)

---

## The Agent Scratchpad

The scratchpad is the accumulated history of the agent's actions within a single task. It grows with each loop iteration:

1. User request
2. Agent thinks: "I need to search for X"
3. Agent calls: search_web("X")
4. Result: "..."
5. Agent thinks: "Now I need to check Y"
6. Agent calls: lookup_database("Y")
7. Result: "..."
8. Agent thinks: "I now have enough to answer"
9. Agent generates final response

The entire scratchpad is sent to the model at each step, which is why agent runs can get expensive — the context grows with every iteration.

---

## Stop Conditions

An agent needs to know when to stop. Without clear stop conditions, it can loop indefinitely (burning tokens and money).

### Natural Completion
The model decides it has achieved the goal and generates a final response instead of another tool call. This is the ideal stop condition.

### Maximum Iterations
A hard limit on how many think-act-observe cycles the agent can perform. If it hasn't finished after N iterations, stop and return whatever it has. This is a safety net, not a normal exit condition.

### Error Accumulation
If the agent encounters multiple errors in a row (failed tool calls, irrelevant results), it may be stuck. Implement logic to detect this and either ask the user for help or return a partial result.

### Token Budget
Set a maximum token budget for the agent run. When approaching the limit, the agent should wrap up with what it has rather than trying to continue.

---

## Building with LangChain

LangChain is the most mature framework for building ReAct agents. It provides:

- **Agent executors** that implement the ReAct loop
- **Tool definitions** that integrate with the agent framework
- **Memory management** for the agent scratchpad
- **Callback handlers** for logging and tracing agent execution
- **Built-in tools** for common operations (web search, code execution, etc.)

The framework handles the loop mechanics — you define the tools, the system prompt, and the configuration. The framework runs the loop, passes results back to the model, and manages the scratchpad.

---

## Common Agent Architectures

### Conversational Agent
An agent embedded in a chat interface. It can use tools to answer questions, take actions, and maintain conversation context. The user interacts naturally, and the agent decides when tools are needed.

### Task Agent
Given a specific task, the agent works autonomously to complete it. Less interactive, more focused. "Research X and produce a report." The agent plans and executes without further user input.

### Plan-and-Execute Agent
A two-phase approach: first, the agent creates a plan (a list of steps). Then it executes the plan step by step. If a step fails, it can replan. More structured than pure ReAct, better for complex tasks.

---

## Error Handling and Recovery

Agents make mistakes. Tools fail. Results are unexpected. Robust error handling is essential.

### Tool Failures
When a tool call fails, return a clear error message to the model. The model can then try a different approach, use a different tool, or adjust its parameters.

### Hallucinated Tool Calls
Sometimes the model invents tool calls — calling tools that don't exist or passing invalid arguments. Validate every tool call against your tool definitions before executing.

### Infinite Loops
The model might get stuck trying the same approach repeatedly. Track the history of tool calls and detect patterns. If the model calls the same tool with the same arguments twice, it's stuck.

### Graceful Degradation
When the agent can't complete a task, it should explain what it tried, what went wrong, and what information it was able to gather — rather than just failing silently.

---

## Key Takeaways

- ReAct agents loop through think → act → observe until the task is complete
- The model decides what to do at each step based on the prompt, tools, and history
- Good tool descriptions and system prompts are crucial for good agent decisions
- Always implement stop conditions — max iterations, token budgets, error detection
- The agent scratchpad grows with each iteration, making long runs expensive
- LangChain provides the standard framework for building ReAct agents
- Error handling is essential — agents encounter failures regularly and need to recover gracefully
- Start with simple agents (few tools, clear tasks) before building complex ones
