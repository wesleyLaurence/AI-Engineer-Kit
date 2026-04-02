# Build Details: WebSocket Streaming

## Overview
Harden and extend the WebSocket streaming endpoint to be production-ready with a structured message protocol, connection lifecycle management, and comprehensive error handling.

---

### Step 1: Define a Structured Message Protocol
Design the message format for server-to-client communication:
- `token` -- a chunk of the agent's response text
- `tool_call` -- the agent is invoking a tool (include tool name and arguments)
- `tool_result` -- the result of a tool call
- `response_complete` -- the agent has finished responding (include full response text)
- `error` -- something went wrong (include error message and error type)

Each message is a JSON object with at minimum a `type` field and a `data` field.

Define the client-to-server message format:
- `message` -- a user message (include text and thread_id)
- `ping` -- heartbeat from client

Document the protocol so the frontend developer (or the learner building the frontend) knows what to expect.

Checkpoint: Is the protocol documented? Does each message type have a clear purpose?

### Step 2: Implement Connection Lifecycle Management
Handle each phase of a WebSocket connection:
- **On connect:** Accept the connection. Optionally validate authentication (can be added later). Log the connection.
- **On message:** Parse and validate the incoming message. Route to the appropriate handler.
- **On disconnect:** Clean up any resources. Log the disconnection. Handle both clean and dirty closes.

Track active connections. Each connection should have an identifier.

Checkpoint: Does the server log connections and disconnections? Does it handle dirty closes without crashing?

### Step 3: Add Heartbeat/Ping-Pong
Implement a heartbeat mechanism:
- Client sends a `ping` message periodically
- Server responds with a `pong`
- If no ping is received within a timeout window, consider the connection dead and clean up
- This detects silently dropped connections (common with mobile networks, laptops sleeping, etc.)

Checkpoint: Can they demonstrate that a stale connection is detected and cleaned up?

### Step 4: Add Error Handling for All Failure Modes
Handle every way things can go wrong:
- **Agent error during streaming:** Catch the exception, send an `error` message to the client, clean up. Do not crash the server or leave the client hanging.
- **Malformed client message:** Validate incoming JSON. If it is invalid, send an error message back. Do not crash.
- **Timeout:** If the agent takes too long (configurable limit), send a timeout error to the client.
- **Connection lost during agent execution:** The agent may still be running. Cancel or clean up the agent task.

The key principle: the client must ALWAYS receive a terminal message (either `response_complete` or `error`). If the client never gets a terminal message, it will be stuck in a loading state forever.

Checkpoint: For each failure mode, does the client receive a clear error message? Does the server remain healthy?

### Step 5: Implement Reconnection Support
Support clients that reconnect after a dropped connection:
- On reconnect, the client sends its thread ID
- The server loads the thread history and sends it back (or the client loads it via REST)
- If a response was in progress when the connection dropped, the client gets the partial response from thread history
- The client can then resume the conversation

This does not require complex server-side state -- the thread history (loaded from memory or database) is the source of truth.

Checkpoint: Can they disconnect, reconnect, and resume a conversation without losing messages?

### Step 6: Test with Concurrent Connections and Failures
Test the full implementation:
- Multiple clients connected simultaneously, each streaming independently
- Client disconnects mid-stream -- server handles it gracefully
- Agent throws an error -- client gets an error message
- Rapid connect/disconnect cycles -- server stays stable
- Malformed messages -- server validates and responds without crashing
