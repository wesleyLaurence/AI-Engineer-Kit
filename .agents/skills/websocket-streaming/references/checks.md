# Understanding Checks: WebSocket Streaming

## Check Questions
1. Why are WebSockets better than HTTP for streaming AI responses? What would the user experience be like with only REST endpoints?
2. Describe your message protocol. What message types do you have and what is each one for?
3. Walk through the connection lifecycle: what happens when a client connects, sends a message, and disconnects?
4. What happens if the agent throws an error mid-stream? How does the client know something went wrong?
5. How would a client reconnect after losing connection? How does it recover its state?
6. What is a heartbeat and why do you need one for WebSocket connections?

## Completion Criteria
- The learner can explain the advantages of WebSockets over HTTP for streaming chat applications
- They have a structured message protocol with defined types (token, tool_call, response_complete, error)
- Connection lifecycle is explicitly handled: connect, active, idle, disconnect
- Error handling is comprehensive: agent errors send error messages instead of crashing, malformed input is validated, timeouts are handled
- They understand reconnection strategy and state recovery
- The WebSocket endpoint handles concurrent connections without issues

## What to Update
- `learner/progress.md` -- mark "WebSocket Streaming" complete
- `learner/notes.md` -- record their protocol design decisions, any edge cases they discovered, insights about real-time communication
