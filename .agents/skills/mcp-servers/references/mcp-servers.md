# MCP Servers

## The Problem: Every Tool Is a Snowflake

Building an agent with tools means integrating external capabilities — search APIs, databases, file systems, third-party services. Every integration is different. Every API has its own authentication, its own request format, its own response structure. If you want your agent to use 10 different services, you write 10 different integrations.

And those integrations are tied to your specific agent. Someone else building a different agent needs the same tools? They write them again from scratch.

The Model Context Protocol (MCP) solves this with standardization. It defines a universal protocol for how tools are exposed to AI models, so any tool built as an MCP server works with any client that speaks MCP.

---

## What MCP Is

MCP is an open protocol that standardizes how AI applications connect to external tools, data sources, and services. Think of it like USB for AI tools — a standard interface that lets any tool plug into any agent.

### The Architecture

**MCP Server** — A process that exposes tools (and optionally resources and prompts) via the MCP protocol. Each server focuses on a specific domain: a GitHub MCP server exposes GitHub operations, a database MCP server exposes query capabilities, a file system MCP server exposes file operations.

**MCP Client** — An application that connects to MCP servers and makes their tools available to a model. Claude Code, Cursor, and other coding agents are MCP clients. Your agent application can also be an MCP client.

**The Protocol** — The standard communication format between clients and servers. JSON-RPC based, supporting tool listing, tool invocation, and result handling.

### How It Works

1. The client connects to one or more MCP servers
2. It asks each server: "What tools do you offer?"
3. Each server responds with its tool definitions (name, description, parameters)
4. The client includes these tools in its LLM context
5. When the model calls a tool, the client routes the call to the appropriate server
6. The server executes the tool and returns the result
7. The client passes the result back to the model

---

## Why MCP Matters

### Tool Reusability
Build a tool once as an MCP server, use it everywhere. A web search MCP server works with Claude Code, Cursor, your custom agent, and any other MCP-compatible client. No rewiring needed.

### Ecosystem Growth
MCP servers are emerging for almost every common integration — GitHub, Slack, databases, file systems, web search, APIs. You can connect your agent to a growing library of pre-built capabilities without writing integration code.

### Separation of Concerns
The MCP server handles the complexity of the external service (authentication, API specifics, error handling). The client just sends standard tool calls. This is a clean architectural boundary.

### Security Boundary
MCP servers can run in their own process with their own permissions. The agent doesn't need direct access to your database credentials — the MCP server handles authentication. This limits the blast radius of agent actions.

---

## Building an MCP Server

An MCP server is a program that:

1. **Declares its capabilities** — what tools it offers, with full schemas
2. **Handles tool invocations** — receives calls from clients, executes the logic, returns results
3. **Communicates via the MCP protocol** — typically over stdio (for local servers) or HTTP/SSE (for remote servers)

### Transport Types

**stdio** — The server communicates via standard input/output. The client launches the server as a subprocess. Simple, local, no network setup needed. Best for local development and personal tools.

**HTTP with SSE** — The server runs as an HTTP service. Clients connect over the network. Supports remote servers, multiple clients, and deployment as a service. Better for production and shared infrastructure.

### What a Server Exposes

**Tools** — The primary capability. Functions the model can call. Each tool has a name, description, and parameter schema.

**Resources** (optional) — Data the model can read. Files, database records, API responses. These are exposed as readable content, not as function calls.

**Prompts** (optional) — Pre-defined prompt templates the model or user can invoke. Useful for packaging complex instructions into a single command.

---

## When to Build an MCP Server vs. a Regular Tool

### Build an MCP Server When

- The tool is general-purpose and would be useful across multiple agents or projects
- You want the tool to be usable from Claude Code, Cursor, and other MCP clients
- The tool wraps a complex service with authentication and stateful connections
- You want to share the tool with others

### Build a Regular Tool When

- The tool is specific to one agent and one application
- Simplicity matters more than reusability
- You don't need the tool to work outside your application
- The overhead of running a separate server process isn't worth the architectural benefit

---

## The MCP Ecosystem

The MCP ecosystem is growing rapidly. Pre-built servers exist for:

- **Development tools** — GitHub, GitLab, file system access
- **Communication** — Slack, email, webhooks
- **Data** — PostgreSQL, SQLite, various APIs
- **Search** — Web search, documentation search
- **Cloud services** — AWS, GCP, various SaaS platforms

Before building your own MCP server, check if one already exists. The ecosystem saves significant development time.

---

## Key Takeaways

- MCP standardizes how AI tools are exposed, making them reusable across agents and clients
- MCP servers expose tools (and optionally resources and prompts) via a standard protocol
- Any MCP client (Claude Code, Cursor, your custom agent) can connect to any MCP server
- Build MCP servers for general-purpose, reusable tools; use regular tools for application-specific functions
- The ecosystem is growing fast — check for existing servers before building your own
- MCP provides a clean architectural boundary and security isolation between agents and external services
