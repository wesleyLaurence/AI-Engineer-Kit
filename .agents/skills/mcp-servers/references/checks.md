# Understanding Checks: MCP Servers

## Check Questions
1. What is MCP and what problem does it solve? Why does standardization matter?
2. Describe the MCP architecture: what is a server, what is a client, what is a transport?
3. Walk through the flow: how does a client discover and invoke a tool on an MCP server?
4. When would you build an MCP server instead of defining tools directly in your agent?
5. Show your MCP server working with a client. What tools does it expose and how do they work?

## Completion Criteria
- The learner can explain MCP as a standardization protocol for AI tool access
- They understand the client-server architecture and can describe the communication flow
- They have a working MCP server with 2-4 tools tested against a real client
- They can reason about when MCP is the right approach vs. native tool definitions
- They see the connection to the broader ecosystem (Claude Code, other MCP clients)

## What to Update
- `learner/progress.md` -- mark "MCP Servers" complete
- `learner/notes.md` -- record their understanding of MCP, the server they built, any insights about tool reusability
