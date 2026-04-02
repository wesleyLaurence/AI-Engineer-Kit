# Tool Calling

## The Problem: LLMs Are Trapped in a Box

An LLM is powerful but isolated. It can reason, write, and analyze — but only based on what's in its context window. It can't check today's weather. It can't look up a user in your database. It can't send an email. It can't do anything in the real world.

This is because LLMs are frozen in time. Their knowledge comes from training data with a cutoff date. They don't have internet access, they can't query APIs, they can't execute code. They process text in and produce text out. That's the boundary.

Tool calling breaks through this boundary. It's the mechanism that lets an LLM interact with the outside world — calling functions, querying APIs, searching the web, executing code. It's what turns a chatbot into an agent.

---

## How Tool Calling Works

The fundamental pattern is a structured conversation between your application and the model:

### Step 1: You Describe Available Tools

When you make an API call, you include a list of tool definitions alongside your messages. Each tool definition describes:
- **Name** — What the tool is called (e.g., "search_web", "get_weather", "create_ticket")
- **Description** — What the tool does and when to use it
- **Parameters** — What inputs the tool accepts, defined as a JSON schema

This tells the model: "Here are the actions you can take. Here's what each one does. Here's what information each one needs."

### Step 2: The Model Decides to Use a Tool

Based on the conversation and the available tools, the model may decide that it needs to call a tool. Instead of generating a text response, it generates a **tool call** — a structured request specifying which tool to call and what arguments to pass.

This is the key insight: **the model doesn't execute the tool.** It generates a request. Your application is responsible for actually executing it.

### Step 3: You Execute the Tool

Your application receives the tool call, executes the corresponding function (makes the API call, queries the database, performs the search), and gets the result.

### Step 4: You Send the Result Back

You send the tool result back to the model as a new message in the conversation. The model then uses this result to continue generating its response — perhaps incorporating the data into its answer, or deciding to call another tool.

### The Complete Flow

1. User: "What's the weather in Tokyo?"
2. Your app sends the message + tool definitions to the model
3. Model responds: tool_call("get_weather", {"city": "Tokyo"})
4. Your app calls the weather API → "72°F, partly cloudy"
5. Your app sends the result back to the model
6. Model responds: "The weather in Tokyo is 72°F and partly cloudy."

---

## Tool Definitions: The Schema Matters Enormously

The tool definition is essentially a prompt. The model uses the name, description, and parameter descriptions to decide when and how to use the tool. Poor definitions lead to poor tool usage.

### The Name

Clear, descriptive, action-oriented. "search_web" is better than "web" or "search" or "do_search_on_internet". The name should make the tool's purpose immediately obvious.

### The Description

This is where you tell the model WHEN to use the tool. "Search the web for current information. Use this when the user asks about recent events, current data, or anything that might have changed after your training cutoff."

A description that only says "searches the web" leaves the model guessing about when to use it. A description that explains the use cases gives the model clear decision criteria.

### Parameters

Each parameter needs:
- A clear name
- A description explaining what it is and any constraints
- A type (string, number, boolean, array, object)
- Whether it's required or optional
- Enum values if the parameter has a fixed set of options

### The Quality Test

Ask yourself: if a human developer read only the tool definition (name, description, parameters), would they know exactly when and how to use this tool? If not, the model won't either.

---

## Types of Tools

### Information Retrieval Tools
Fetch data from external sources. Web search, database queries, API lookups, file reading. These give the model access to information it doesn't have in its training data.

### Action Tools
Do something in the world. Send an email, create a ticket, update a database record, deploy code. These let the model take actions, not just retrieve information.

### Computation Tools
Perform calculations or processing. Code execution, math computation, data transformation. These augment the model's reasoning with precise computation.

### Communication Tools
Interact with other systems or people. Send messages, make API calls to external services, trigger webhooks.

---

## Parallel Tool Calls

Modern models can call multiple tools simultaneously when the tasks are independent. If a user asks "What's the weather in Tokyo and New York?", the model can call `get_weather` twice in parallel rather than sequentially.

Your application needs to handle this — execute both calls, collect both results, and send them back together. This significantly reduces latency for multi-tool requests.

---

## Multi-Step Tool Usage

Complex tasks often require multiple sequential tool calls:

1. User: "Find the latest research paper on transformer architectures and summarize it"
2. Model calls: search_papers("transformer architectures latest")
3. Result: list of papers with URLs
4. Model calls: fetch_paper(url)
5. Result: full paper text
6. Model: generates summary

The model decides at each step what to do next based on the results it's received. This is the foundation of agentic behavior — the model autonomously planning and executing a multi-step task.

---

## Designing Good Tools

### Keep Tools Focused

Each tool should do one thing well. "search_and_create_ticket" is a bad tool — it combines two unrelated actions. "search_issues" and "create_ticket" are better. The model can compose simple tools into complex workflows; it can't decompose a monolithic tool.

### Return Useful Responses

Tool responses should give the model what it needs to continue. Don't return raw API responses with 50 fields when the model only needs 3. Don't return success/failure with no details. Return structured, relevant information that helps the model take the next step.

### Handle Errors in Tool Responses

When a tool fails, return a clear error message as the tool result rather than crashing your application. "Error: User not found with ID 12345" tells the model what went wrong so it can adjust. An unhandled exception tells the model nothing.

### Limit the Number of Tools

Model performance degrades as the number of available tools grows. Each tool definition consumes tokens in the context window, and the model has more difficulty choosing the right tool from a large set.

The practical limit is around 10-15 tools. Beyond that, consider:
- Grouping related tools and only providing relevant groups based on context
- Using a routing step where a simpler model selects which tool category is relevant
- Implementing an MCP server architecture where tools are loaded dynamically

---

## Tool Calling vs. Function Calling

These terms are used interchangeably, but historically:
- **Function calling** was OpenAI's original term for this capability
- **Tool calling** is the more general, provider-agnostic term

They describe the same mechanism. The industry has largely converged on "tool calling" as the standard terminology.

---

## Key Takeaways

- Tool calling is what turns an isolated LLM into an agent that can interact with the world
- The model doesn't execute tools — it requests them. Your application executes and returns results.
- Tool definitions are prompts — clear names, descriptions, and parameter schemas determine whether the model uses tools correctly
- Keep tools focused (one action each), return useful responses, and handle errors gracefully
- Limit tools to ~10-15 per request — more than that degrades performance
- Multi-step tool usage is the foundation of agentic behavior
- The model decides when to use tools based on the conversation and tool descriptions — good descriptions lead to good decisions
