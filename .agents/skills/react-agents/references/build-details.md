# Build Details: ReAct Agent

## Overview
Build a ReAct agent connected to the learner's project using LangChain.

---

### Step 1: Design the Agent's Purpose
Connect to their project. What should this agent DO?
- What tasks will it handle autonomously?
- What tools does it need?
- What should it NOT do without asking?

### Step 2: Define Tools
Design 3-5 tools appropriate for the agent:
- Clear names and descriptions
- Well-defined parameter schemas
- Implement each tool as a function

Use web search for current LangChain tool definition patterns.

Checkpoint: Are the tool descriptions clear enough that the model will use them correctly?

### Step 3: Set Up the Agent with LangChain
Use web search for the latest LangChain agent creation API.
Configure:
- The LLM (model selection based on task complexity)
- The tools
- A system prompt that guides agent behavior
- Maximum iteration limit (safety net)

### Step 4: Test with Simple Tasks
Start with tasks that require 1-2 tool calls.
Observe the agent's reasoning -- does it think, act, and observe correctly?
Print or log the full agent execution trace.

Checkpoint: Can the learner trace through the agent's reasoning and explain each step?

### Step 5: Test with Complex Tasks
Give the agent multi-step tasks that require chaining tool calls.
Observe how it plans and adapts based on intermediate results.
Watch for common issues: wrong tool selection, infinite loops, hallucinated tool calls.

### Step 6: Add Error Handling
What happens when a tool fails? Test it.
Implement graceful error handling:
- Return useful error messages from tools
- Let the agent retry or try a different approach
- Set a fallback for when the agent is stuck

### Step 7: Connect to Their Project
Wire the agent into their actual project code.
Connect any existing chatbot, RAG system, or tools.
Test end-to-end with realistic use cases.
