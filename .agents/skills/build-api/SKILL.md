---
name: build-api
description: Guides building a FastAPI backend with REST and WebSocket endpoints to serve an AI agent as a web service. Use at the start of Phase 4 after the agent is feature-complete locally.
compatibility: Requires Python 3.10+, FastAPI, and uvicorn
---

# Skill: Build a FastAPI Backend

## What This Skill Does
Guides the learner through wrapping their agent in a FastAPI web service with REST and WebSocket endpoints.

## When to Use
At the start of Phase 4 (Production), after the agent is feature-complete locally.

## Prerequisites
- Working agent with tools (and optionally RAG)
- Understands FastAPI concepts (from concept teaching)

## Context to Load
- `concepts/production/fastapi-backend.md`
- `concepts/production/websocket-streaming.md`
- `wisdom/production-lessons.md`
- `learner/project.md`

---

## Process

### Step 1: Set Up FastAPI Project
Use web search for current FastAPI best practices.
Install FastAPI and uvicorn.
Create the project structure:
- Separate agent module from API module
- Config file for settings
- Requirements.txt

### Step 2: Build a Health Endpoint
Simple GET endpoint that returns status. Verify the server runs.

### Step 3: Build the Chat Endpoint (REST)
POST endpoint that accepts a message and returns the agent's response.
Wire in the agent module.
Test with curl or the auto-generated Swagger docs.

**Checkpoint:** Can they send a message and get a response via HTTP?

### Step 4: Add WebSocket Streaming
WebSocket endpoint for real-time chat.
Stream agent responses token by token.
Implement message types (token, tool_call, response_complete, error).

Use web search for current FastAPI WebSocket patterns.

**Checkpoint:** Can they connect via WebSocket and see tokens streaming in?

### Step 5: Add Thread Management
REST endpoints:
- POST /threads — create a new thread
- GET /threads — list user's threads
- GET /threads/{id}/messages — get thread messages
- DELETE /threads/{id} — delete a thread

For now, use in-memory storage. Database comes later.

### Step 6: Add Middleware
- CORS (allow frontend connections from different origins)
- Error handling (catch exceptions, return useful errors)
- Request logging (timing, token counts)

### Step 7: Test End-to-End
Send messages, verify streaming, test thread management.
Test error cases: what happens when the LLM API fails?

---

## When Done
- FastAPI backend with REST and WebSocket endpoints
- Agent served as an API
- Thread management working
- Error handling and logging in place
- Code saved in `projects/`
- Update `learner/progress.md`: mark FastAPI backend complete
- **Milestone:** Agent accessible via API
