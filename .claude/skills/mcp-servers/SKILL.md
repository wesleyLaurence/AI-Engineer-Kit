---
name: mcp-servers
description: Teaches the Model Context Protocol -- what it is, why standardization matters, and how to build MCP servers. Use when the learner asks about MCP, building MCP servers, standardized tool interfaces, or the MCP ecosystem.
---

# Topic: MCP Servers

## When to Use
- Phase 3, after react-agents
- Learner asks about MCP, the Model Context Protocol, or standardized tool interfaces
- Learner asks about building tools that work with Claude Code or other MCP clients
- Learner is deciding between MCP servers and regular tool definitions

## Prerequisites
- `react-agents` topic complete (they have a working agent with tools)
- Tool calling concepts understood

## Concept References
- `references/mcp-servers.md` -- read this before teaching

---

## Teaching Flow

### Open with the Problem
Start with a real frustration: "You have built tools for your LangChain agent. Great. But those tools only work with LangChain. If you want to use them with Claude Code, or a different framework, or share them with another team, you have to rewrite them. What if there was a standard protocol -- like HTTP for the web -- that let any tool work with any agent? That is MCP."

### Core Points to Cover

**What MCP is:**
- The Model Context Protocol -- an open standard for connecting AI models to tools and data sources
- Think of it like USB for AI: a standardized interface that lets any client talk to any server
- Created by Anthropic, adopted across the ecosystem
- Defines how tools are discovered, described, and invoked

**Why standardization matters:**
- Without MCP: every framework has its own tool format. Tools are locked to their framework.
- With MCP: build a tool once, use it everywhere. Claude Code, Cursor, custom agents -- they all speak MCP.
- The network effect: as more clients and servers adopt MCP, the ecosystem gets more valuable
- This is the same pattern as HTTP, USB, or any successful standard

**How MCP works architecturally:**
- **Server** -- exposes tools (and optionally resources and prompts)
- **Client** -- discovers and invokes tools from a server
- **Transport** -- how they communicate (stdio for local, SSE/HTTP for remote)
- The flow: client connects to server, discovers available tools, invokes them as needed

**Building an MCP server:**
- Choose a domain: what capability to expose
- Define tools with clear names, descriptions, and parameter schemas
- Implement handlers for each tool
- Test with a real MCP client

**When to build an MCP server vs. regular tools:**
- MCP server: the capability is reusable across agents and contexts
- MCP server: you want to share tools with others or use them from different clients
- Regular tools: quick prototyping, tightly coupled to one agent, no need for reuse
- The decision: "Will this tool ever be used outside of this one agent?"

### Close
Transition to the build: "Now let's build one. You are going to create an MCP server that exposes part of your project's functionality to any MCP client -- including Claude Code."

---

## Build

Build an MCP server that exposes tools relevant to the learner's project.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Choose what capability to expose
2. Set up the MCP server scaffold with the Python SDK
3. Define and register tools
4. Implement tool handlers
5. Test with an MCP client (Claude Code or similar)
6. Optionally connect to their existing agent

---

## Adaptive Notes

**Experienced developers:** They will immediately understand the protocol/standard analogy. Focus on the architecture and the practical tradeoff of MCP vs. native tools. The build should be focused and efficient -- 30-45 minutes.

**Beginners:** Spend more time on the "why" -- why standards matter, the USB analogy. Walk through the architecture diagram carefully. The build may need more hand-holding on the SDK setup -- 60-90 minutes.

**Returning learners (review mode):** Focus on the MCP ecosystem -- what clients exist, what community servers are available. Have them evaluate whether their existing tools should be converted to MCP servers.

---

## Understanding Checks
- Can the learner explain what MCP is and what problem it solves?
- Can they describe the client-server architecture and transport options?
- Can they articulate when to build an MCP server vs. use regular tool definitions?
- Is their MCP server working and tested with a real client?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Working MCP server with 2-4 tools
- Server tested with an MCP client
- Learner understands when to build MCP servers vs. regular tools
- Code saved in `projects/`
- Mark "MCP Servers" complete in `learner/progress.md`
- Add observations about their understanding of standards and protocols to `learner/notes.md`
- Proceed to `agent-skills`
