# WebSocket Streaming

## The Problem: HTTP Doesn't Fit Chat

Standard HTTP is request-response: the client sends a request, the server sends back one response, the connection closes. This doesn't work for AI chat because:

- The response streams in token by token over several seconds
- The client needs to send new messages without waiting for the response to finish
- The server needs to push updates (tool status, progress indicators) without the client asking

WebSockets solve this with a persistent, bidirectional connection. Both client and server can send messages at any time. The connection stays open for the duration of the conversation.

---

## How WebSockets Work

### The Handshake
A WebSocket connection starts as a regular HTTP request. The client sends an "upgrade" request, the server agrees, and the connection is upgraded from HTTP to WebSocket. From that point on, both sides can send messages freely.

### Message Flow
Unlike HTTP (one request, one response), WebSocket messages flow independently in both directions:
- Client sends a chat message
- Server sends streaming tokens (many small messages)
- Server sends a completion signal
- Client sends another message
- Server sends tool call status updates

### Connection Lifecycle
1. **Connect** — Client opens the WebSocket connection (handshake)
2. **Authenticate** — Client sends credentials, server validates
3. **Message exchange** — Both sides send messages as needed
4. **Disconnect** — Either side closes the connection (or it times out)

---

## Streaming Agent Responses

The core use case: streaming the agent's response token by token to the frontend.

### The Flow

1. Client sends a user message over the WebSocket
2. Server receives it, starts the agent with streaming enabled
3. For each token the LLM generates, server sends a small message to the client
4. Client appends each token to the display in real time
5. When the response is complete, server sends a "done" message
6. Client finalizes the display

### Message Types

A well-designed WebSocket protocol uses different message types:

| Type | Direction | Purpose |
|---|---|---|
| user_message | Client to Server | User's chat message |
| token | Server to Client | Single token of streaming output |
| tool_call | Server to Client | Agent is calling a tool |
| tool_result | Server to Client | Tool call completed |
| response_complete | Server to Client | Full response is done |
| error | Server to Client | Something went wrong |

---

## Connection Management

### Reconnection
Network interruptions happen. Your client needs reconnection logic: detect disconnection, wait briefly (with exponential backoff), reconnect, and resume the conversation (load the thread from the server).

### Heartbeats
Many proxies and load balancers close idle connections after a timeout. Send periodic "ping" messages to keep the connection alive during periods of silence.

### Scaling
WebSocket connections are stateful — the connection is tied to a specific server process. This complicates horizontal scaling. Solutions include sticky sessions (route each user to the same server) or a shared message bus (Redis) that bridges server instances.

---

## WebSockets vs. Server-Sent Events

**Server-Sent Events (SSE)** are simpler: one-directional streaming from server to client over a regular HTTP connection.

**Use SSE when:** You only need to stream from server to client, and the client can make separate HTTP requests for sending messages. Simpler infrastructure.

**Use WebSockets when:** You need bidirectional communication, real-time interaction, or the ability for the server to push different types of messages. Standard for chat applications.

---

## Key Takeaways

- WebSockets provide persistent, bidirectional communication — essential for streaming chat
- Use typed messages (token, tool_call, error, etc.) so the frontend handles each type appropriately
- Implement reconnection logic, heartbeats, and proper cleanup for production reliability
- WebSocket connections are stateful, which complicates horizontal scaling — plan for this
- SSE is simpler for one-directional streaming; WebSockets are standard for interactive chat
