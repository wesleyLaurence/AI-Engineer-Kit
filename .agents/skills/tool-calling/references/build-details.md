# Build Details: Adding Tools to the Chatbot

### Step 1: Understand the Pattern
Before writing any code, walk through the tool calling flow on paper or verbally:
1. You define tool schemas and send them with the API call
2. The model decides to call a tool and returns a structured request
3. Your code parses the request, executes the tool, and sends the result back
4. The model generates a response that incorporates the tool result

Use web search for the current SDK tool calling documentation. The exact API shape matters.

### Step 2: Add a Simple First Tool
Start with something that produces an immediate, visible result. Good first tools:
- A calculator (takes an expression, returns the result)
- A get-current-time tool (takes a timezone, returns the time)
- A random-number generator

The goal is to see the full flow working before dealing with external API complexity.

Write the tool function, define the schema, wire it into the chatbot.

Checkpoint: Does the model call the tool when appropriate? Does it use the result in its response?

### Step 3: Add a Useful Tool
Now add a tool that connects to something real:
- Web search (if using an API that supports it, or integrate a search API)
- A custom API call relevant to their project
- File reading or data lookup

Discuss the tool description carefully — this determines when the model chooses to use it.

Checkpoint: Does the model use the tool at the right times? Does it pass reasonable arguments?

### Step 4: Handle Errors Gracefully
What happens when a tool call fails? Test it:
- Pass invalid arguments
- Simulate a network error
- Return an unexpected result format

Add error handling so the model gets useful error messages it can reason about, rather than crashing.

Checkpoint: Does the chatbot handle tool failures gracefully instead of crashing?

### Step 5: Add Project-Relevant Tools
Work with the learner to design tools specific to their project:
- What information does their agent need access to?
- What actions should it be able to take?
- What external systems should it interact with?

Design the schemas together. Focus on clear descriptions and well-defined parameters.
Implement and test each tool.

### Step 6: Test Multi-Tool Scenarios
Ask questions that require the model to use multiple tools or decide between tools.
Observe the model's reasoning about which tool to use and when.

Discuss: Is the model making good decisions? If not, how can the tool descriptions be improved?

Save the updated chatbot code in their project directory.
