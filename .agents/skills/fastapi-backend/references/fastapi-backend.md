# FastAPI Backend

## The Problem: Your Agent Needs to Be a Service

Your agent works locally — you run a script, it does its thing. But real users can't SSH into your laptop. To serve your agent to users, you need to wrap it in an API: a web service that accepts requests, runs the agent, and returns responses over HTTP.

FastAPI is the framework of choice for AI backends. It's Python-native (so your agent code stays in Python), async-first (critical for LLM workloads that spend most of their time waiting for API responses), type-safe (catches errors early), and fast (one of the fastest Python web frameworks).

---

## Why FastAPI for AI Applications

### Async-Native
LLM API calls take 2-30 seconds. During that time, your server is just waiting. With synchronous frameworks, each waiting request ties up a server thread — 10 concurrent users need 10 threads. With FastAPI's async support, those 10 users share resources efficiently because the server can handle other requests while waiting for LLM responses.

### Type Safety with Pydantic
FastAPI uses Pydantic models for request/response validation. Define your data structures with types, and FastAPI automatically validates incoming requests and generates API documentation. This catches malformed requests before they reach your agent.

### WebSocket Support
Chat applications need real-time, bidirectional communication. FastAPI has native WebSocket support, making it straightforward to implement streaming chat endpoints.

### Automatic Documentation
FastAPI generates interactive API documentation (Swagger UI) from your code. This makes testing and integration dramatically easier.

---

## Endpoint Design for AI Applications

### The Chat Endpoint
The core of any AI chat application. Accepts a message (and optionally a thread ID), runs it through the agent, returns the response.

For non-streaming: a standard POST endpoint that accepts a request body and returns a response body.
For streaming: a WebSocket endpoint that maintains a persistent connection for real-time token delivery.

### Thread Management Endpoints
- Create a new thread
- List a user's threads
- Load a specific thread's messages
- Delete or archive a thread
- Rename a thread

### Health and Status Endpoints
- Health check (is the server running?)
- Model status (can we reach the LLM API?)
- Usage statistics (tokens used, requests served)

---

## Architecture: Separating Agent Logic from API Logic

The most important architectural decision: **keep your agent logic separate from your API layer.** Your agent should be a module that you can import and call. Your API endpoints call the agent module. They don't contain agent logic themselves.

This separation means:
- You can test your agent without running the web server
- You can swap your API framework without rewriting the agent
- Your API layer stays thin and focused on HTTP concerns
- Your agent module stays focused on AI concerns

---

## Middleware and Cross-Cutting Concerns

### CORS
If your frontend is hosted on a different domain than your API (common), you need CORS (Cross-Origin Resource Sharing) middleware. Without it, browsers will block requests from your frontend to your API.

### Authentication
Verify that requests come from authenticated users. Typically done via JWT tokens in the Authorization header. FastAPI's dependency injection system makes this clean.

### Rate Limiting
Prevent abuse by limiting requests per user per time window. Essential for AI applications where each request has real cost.

### Error Handling
LLM calls fail — rate limits, network errors, model errors. Your API needs global error handling that returns useful error messages rather than stack traces.

### Logging
Log every request with timing, token usage, and outcome. You can't optimize what you don't measure.

---

## Key Takeaways

- FastAPI is the standard for AI backends: async-native, type-safe, WebSocket support
- Keep agent logic separate from API logic — your agent is a module, your API calls it
- Chat applications typically need both REST endpoints (thread management) and WebSocket endpoints (streaming chat)
- Middleware handles cross-cutting concerns: CORS, auth, rate limiting, error handling
- Log everything — request timing, token usage, errors — you'll need it for optimization and debugging
