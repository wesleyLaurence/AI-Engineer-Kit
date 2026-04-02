# Build Details: FastAPI Backend

## Overview
Build a FastAPI backend that serves the learner's agent as a web API with REST and WebSocket endpoints.

---

### Step 1: Set Up FastAPI Project
Install FastAPI and uvicorn. Create the project structure:
- Separate agent module from API module
- Config file for settings (host, port, model, etc.)
- Requirements file with all dependencies

The agent logic should be importable -- the API calls the agent, not the other way around.

Checkpoint: Does the project structure make sense? Can they explain why the agent is separate from the API?

### Step 2: Build a Health Endpoint
Simple GET endpoint at `/health` that returns a status message.
Start the server with uvicorn. Verify it runs and the health endpoint responds.

This is a confidence builder -- the server works before any complexity is added.

Checkpoint: Can they hit the health endpoint with curl or a browser and get a response?

### Step 3: Build the Chat Endpoint (REST)
POST endpoint at `/chat` that accepts a message and returns the agent's response.
- Define request/response models with Pydantic
- Wire in the agent -- the endpoint calls the agent and returns the result
- Test with curl and Swagger UI

This is the simplest path: send a message, wait, get a response. It blocks until the agent finishes.

Checkpoint: Can they send a message via curl or Swagger and get a correct agent response?

### Step 4: Add WebSocket Streaming
WebSocket endpoint at `/ws/chat` that streams the agent's response token by token.
- Accept a WebSocket connection
- Receive a message from the client
- Stream the agent's response as individual tokens
- Define message types: token, tool_call, response_complete, error
- Handle connection lifecycle (connect, disconnect, errors)

This is the endpoint the frontend will actually use. REST is for simple integrations; WebSocket is for the real-time chat experience.

Checkpoint: Can they connect via a WebSocket client and see tokens streaming in real time?

### Step 5: Add Thread Management
REST endpoints for conversation thread management:
- POST `/threads` -- create a new thread
- GET `/threads` -- list all threads
- GET `/threads/{id}` -- get a specific thread with its messages
- DELETE `/threads/{id}` -- delete a thread

Use in-memory storage (a dictionary) for now. This will be replaced with a database later.

Update the chat endpoints to accept a thread ID so messages are associated with threads.

Checkpoint: Can they create a thread, send messages to it, and retrieve the conversation history?

### Step 6: Add Middleware
- CORS middleware -- allow the frontend to call the API from a different origin
- Error handling -- catch exceptions and return clean error responses instead of stack traces
- Request logging -- log incoming requests for debugging

Checkpoint: Does the API handle errors gracefully? Do CORS headers appear in responses?

### Step 7: Test End-to-End
Full flow test:
1. Start the server
2. Create a thread
3. Send a message via WebSocket, see streaming response
4. Retrieve the thread and verify messages are stored
5. Test error cases: invalid thread ID, malformed requests, agent errors
