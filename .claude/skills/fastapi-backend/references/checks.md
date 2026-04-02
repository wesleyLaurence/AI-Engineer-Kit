# Understanding Checks: FastAPI Backend

## Check Questions
1. Why does your agent need an API? What problem does it solve compared to running the agent as a script?
2. Explain the difference between your REST chat endpoint and your WebSocket chat endpoint. When would you use each?
3. Walk through what happens when a client sends a message to your chat endpoint -- from the HTTP request to the agent response.
4. Why is async important for an AI backend? What would happen if your endpoints were synchronous?
5. What does your CORS middleware do? Why is it necessary?
6. How does your thread management work? What would need to change for production use?

## Completion Criteria
- The learner can explain why an API layer is needed between the agent and users
- They understand REST vs. WebSocket tradeoffs for chat applications
- They have a running FastAPI backend with health, chat (REST), chat (WebSocket), and thread management endpoints
- Middleware is configured: CORS, error handling, request logging
- They can test their API using curl or Swagger and get correct responses
- They understand that in-memory thread storage is temporary and will be replaced with a database later

## Milestone Verification
- **Agent accessible via API** -- the agent responds correctly to API requests, both REST and WebSocket

## What to Update
- `learner/progress.md` -- mark "FastAPI Backend" complete, note the milestone
- `learner/notes.md` -- record their API design decisions, any challenges with async patterns or WebSocket setup
