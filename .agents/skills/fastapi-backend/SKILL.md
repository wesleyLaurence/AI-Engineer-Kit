---
name: fastapi-backend
description: Teaches serving an AI agent as a web API with FastAPI -- endpoint design, request/response patterns, REST and WebSocket. Use when the learner asks about building an API for their agent, serving their agent over HTTP, or starting Phase 4 production.
---

# Topic: FastAPI Backend

## When to Use
- Phase 4, first topic (start of Production phase)
- Learner asks about serving their agent as an API
- Learner asks about FastAPI, building a backend, or connecting a frontend to their agent
- Learner is ready to move from local scripts to a web service

## Prerequisites
- Phase 3 complete (working agent with tools)
- Python fundamentals solid
- Agent is feature-complete locally

## Concept References
- `references/fastapi-backend.md` -- read this before teaching
- `wisdom/production-lessons.md` -- weave in production lessons throughout

---

## Teaching Flow

### Open with the Problem
Start with where they are: "Your agent works. You run it in a terminal, you type a message, you get a response. That is great for development. But no user is going to SSH into your machine and run a Python script. You need to put your agent behind an API -- a web service that any client can talk to. A frontend, a mobile app, another service. That is what we are building today."

### Core Points to Cover

**Why an API:**
- Separation of concerns -- the agent logic is decoupled from how users interact with it
- Multiple clients can connect: web frontend, mobile app, other services
- Scalability -- you can run multiple instances behind a load balancer
- This is how every production AI application works: ChatGPT, Claude, all of them have an API behind the UI

**Why FastAPI:**
- Modern Python web framework, built for async (which matters for LLM calls that take seconds)
- Automatic OpenAPI/Swagger documentation -- you get a testing UI for free
- Type hints and Pydantic models give you request validation without writing validation code
- First-class WebSocket support (critical for streaming)
- The dominant choice for Python AI backends

**Endpoint design for AI applications:**
- Health endpoint -- simple GET that confirms the server is running
- Chat endpoint (REST) -- POST with a message, get a response. Simple but blocks until complete.
- Chat endpoint (WebSocket) -- persistent connection, stream tokens as they are generated. This is what production apps use.
- Thread management -- CRUD endpoints for conversation threads

**Request/response patterns:**
- REST for simple request/response: send a message, get the full response back
- WebSocket for streaming: open a connection, send a message, receive tokens one at a time
- Both have their place -- REST is simpler, WebSocket is better UX for chat

**Project structure:**
- Separate the agent module from the API module
- The API imports and calls the agent, not the other way around
- Configuration, environment variables, requirements management

### Close
Transition to the build: "Let's build it. By the end of this session, your agent will be accessible via API -- you will be able to talk to it with curl, with Swagger, and soon with a real frontend."

---

## Adaptive Notes

**Experienced developers:** They likely know REST APIs and possibly FastAPI already. Focus on the AI-specific patterns: how to wire in an agent, streaming over WebSocket, thread management. The build should move quickly -- 30-45 minutes.

**Beginners:** Spend more time on what an API is and why it matters. The Swagger UI is a great teaching tool -- let them see the auto-generated docs and test endpoints interactively. The build will take longer -- 60-90 minutes.

**Returning learners (review mode):** Focus on areas they may have glossed over: error handling, middleware, WebSocket edge cases. Review their existing API code against production best practices.

---

## Build

Build a FastAPI backend that serves the learner's agent as a web API.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Set up FastAPI project with proper structure
2. Build a health endpoint
3. Build the chat endpoint (REST)
4. Add WebSocket streaming
5. Add thread management
6. Add middleware (CORS, error handling, logging)
7. Test end-to-end

**Milestone:** Agent accessible via API.

---

## Understanding Checks
- Can the learner explain why an API is needed to serve an agent to users?
- Can they describe the difference between REST and WebSocket approaches for chat?
- Can they explain the project structure and why agent logic is separated from API code?
- Is their API running with working endpoints?

See `references/checks.md` for detailed check criteria.

---

## When Done
- FastAPI backend running with health, chat, and WebSocket endpoints
- Thread management implemented (in-memory for now)
- Middleware configured (CORS, error handling, logging)
- Tested end-to-end with curl or Swagger
- Code saved in `projects/`
- Mark "FastAPI Backend" complete in `learner/progress.md`
- Add observations about their understanding of API design to `learner/notes.md`
- **Milestone:** Agent accessible via API
- Proceed to `websocket-streaming`
