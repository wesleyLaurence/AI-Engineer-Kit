# Build Details: MCP Server

## Overview
Build an MCP server that exposes tools from the learner's project to any MCP client.

---

### Step 1: Choose What to Expose
Pick a capability from the learner's project that would make a good MCP server:
- Something reusable across different agents
- A clear domain (database access, API integration, specific service)
- 2-4 focused tools

### Step 2: Set Up the MCP Server Scaffold
Use web search for the latest MCP Python SDK documentation.
Install the MCP SDK.
Create the basic server structure with transport (stdio for local development).

### Step 3: Define Tools
Register tools with the server:
- Clear names and descriptions
- JSON Schema for parameters
- Return types

Connect to the actual implementation (API calls, database queries, etc.).

Checkpoint: Does the server start and list its tools correctly?

### Step 4: Implement Tool Handlers
Write the handler for each tool.
Handle errors gracefully -- return useful error messages.
Test each tool individually.

### Step 5: Test with an MCP Client
Connect the server to Claude Code or another MCP client.
Test the tools through the client.
Verify the model uses the tools correctly.

Checkpoint: Can they invoke the tools from Claude Code and get correct results?

### Step 6: Connect to Their Agent
If applicable, show how to use the MCP server from their LangChain agent.
Discuss when MCP makes sense vs. regular tool definitions.
