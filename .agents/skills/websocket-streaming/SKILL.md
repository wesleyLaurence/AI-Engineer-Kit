---
name: websocket-streaming
description: Teaches real-time bidirectional communication with WebSockets -- streaming agent responses, connection management, message protocols, and reconnection. Use when the learner asks about WebSocket streaming, real-time communication, or improving their API's streaming capabilities.
---

# Topic: WebSocket Streaming

## When to Use
- Phase 4, after fastapi-backend
- Learner asks about WebSocket streaming, real-time agent output, or connection management
- Learner wants to deepen their understanding of the WebSocket endpoint they built
- Learner is preparing to connect a frontend to their API

## Prerequisites
- `fastapi-backend` topic complete (working API with basic WebSocket endpoint)
- Understands streaming concepts from Phase 2

## Concept References
- `references/websocket-streaming.md` -- read this before teaching

---

## Teaching Flow

### Open with the Problem
Start from what they built: "You have a WebSocket endpoint that streams tokens. It works for the happy path. But what happens when the connection drops mid-response? What if the client sends malformed data? What if the agent takes 30 seconds and the client gives up? Production WebSocket connections need to handle all of these cases. Let's make your streaming bulletproof."

### Core Points to Cover

**Why WebSockets for AI chat:**
- HTTP request/response is one-shot: you send a request, you wait, you get everything back at once
- WebSockets are persistent and bidirectional: the server can push data to the client at any time
- For an AI agent streaming tokens, this is the natural fit -- each token is pushed as it is generated
- This is what ChatGPT, Claude, and every real-time AI application uses under the hood

**Message protocols:**
- You need a structured message format, not just raw text
- Define message types: token (a piece of the response), tool_call (agent is using a tool), response_complete (done), error (something went wrong)
- Each message should be a JSON object with a `type` field and a `data` field
- The client uses the type to decide how to render: accumulate tokens, show a tool indicator, stop the loading state
- Version your protocol -- you will want to add message types later without breaking existing clients

**Connection lifecycle:**
- **Connect** -- client opens a WebSocket, server accepts, optionally authenticates
- **Active** -- messages flow back and forth. Client sends user messages, server streams responses.
- **Idle** -- no messages flowing. Need heartbeat/ping to detect dead connections.
- **Disconnect** -- clean close (client navigates away) or dirty close (network drop, timeout)
- Handle each state explicitly -- do not assume connections are always healthy

**Reconnection strategy:**
- Connections will drop. Networks are unreliable. Browsers close tabs.
- The client must be able to reconnect and resume or restart
- Exponential backoff with jitter for reconnection attempts
- On reconnect, the client should be able to recover state (load thread history from the API)

**Error handling in streams:**
- Agent errors mid-stream: send an error message type, do not just close the connection
- Malformed client messages: validate and respond with a clear error, do not crash
- Timeouts: if the agent takes too long, send a timeout error and clean up
- Always ensure the client gets a terminal message (response_complete or error) so it knows the stream is done

### Close
Transition to the build: "Let's harden your WebSocket implementation. We are going to add a proper message protocol, connection lifecycle handling, and error recovery. When we are done, your streaming will be ready for a real frontend."

---

## Adaptive Notes

**Experienced developers:** They may have WebSocket experience from other domains (real-time apps, gaming). Focus on the AI-specific patterns: message protocol design for streaming tokens and tool calls, handling long-running agent responses. Quick build -- 20-30 minutes.

**Beginners:** Spend more time on the conceptual model of bidirectional communication vs. request/response. Demonstrate with a simple WebSocket client tool so they can see messages flowing both directions. Build will take 45-60 minutes.

**Returning learners (review mode):** Focus on edge cases they may not have handled: reconnection, heartbeat, concurrent connections. Review their protocol design against production patterns.

---

## Build

Harden and extend the WebSocket streaming implementation from the fastapi-backend build.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Define a structured message protocol
2. Implement connection lifecycle management
3. Add heartbeat/ping-pong
4. Add error handling for all failure modes
5. Implement reconnection support
6. Test with concurrent connections and failure scenarios

---

## Understanding Checks
- Can the learner explain why WebSockets are used instead of HTTP for streaming chat?
- Can they describe their message protocol and the purpose of each message type?
- Can they explain what happens when a connection drops mid-response?
- Do they handle errors gracefully without crashing the server?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Robust WebSocket implementation with structured message protocol
- Connection lifecycle handled (connect, active, idle, disconnect)
- Error handling covers agent errors, malformed messages, and timeouts
- Tested with concurrent connections and failure scenarios
- Code saved in `projects/`
- Mark "WebSocket Streaming" complete in `learner/progress.md`
- Add observations about their understanding of real-time communication to `learner/notes.md`
- Proceed to `frontend-chat-ui`
