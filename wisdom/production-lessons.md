# Production Lessons

What changes when you go from local development to production. The gap is bigger than most people expect.

---

### Always Implement Streaming

This is not optional for user-facing applications. Users equate blank screens with broken software. Even though streaming doesn't change total response time, the perceived experience is night and day. If your users are waiting more than a second without visual feedback, you've already lost them.

### Handle Rate Limits Gracefully

LLM providers rate-limit based on requests per minute and tokens per minute. When you hit them, you get 429 responses. Your production application needs: retry with exponential backoff, queue management for burst traffic, and graceful degradation (tell the user to wait, don't just fail).

### Plan for Model API Outages

Every model provider has outages. Your application needs a fallback strategy. Options: queue and retry, fall back to a different model/provider, show a "temporarily unavailable" message. The worst option: crash silently.

### Logging Is Non-Negotiable

In production, you can't reproduce bugs by running the code again — every LLM response is different. Log: the full prompt sent, the full response received, token counts, latency, any errors. Without logs, debugging production issues is impossible.

### Error Handling for Non-Deterministic Systems

Traditional error handling assumes deterministic behavior — the same input always fails the same way. LLMs are different. The same prompt might work 99% of the time and fail 1%. Your error handling needs to account for intermittent, non-reproducible failures. Retry logic is more important than it is in traditional applications.

### The Cold Start Problem

The first message in a conversation is the most expensive. The system prompt, tool definitions, and any pre-loaded context all need to be sent. Subsequent messages add incrementally. If your system prompt is 3,000 tokens, that's your minimum cost for every new conversation. Optimize it.

### Security Is Not Optional

Prompt injection is a real attack vector. If your agent can take actions (send emails, modify data, make API calls), a successful injection attack means an attacker can do all of those things. Build security from the start, not as an afterthought.

### Testing AI Systems Is Fundamentally Different

You can't write traditional unit tests for LLM output — the same input produces different output each time. Instead: test behavior (does it refuse when it should?), test format (is the output valid JSON?), test with evaluation suites (is the quality above threshold?), and test infrastructure (do retries work, do timeouts fire?).

### Users Will Do Things You Don't Expect

They'll paste entire documents into the chat. They'll ask your customer support bot about the meaning of life. They'll try to jailbreak your system prompt. They'll send messages in languages you didn't plan for. Build for the unexpected, not just the happy path.

### The "Works on My Laptop" Gap

Local development hides problems that appear in production: network latency to the LLM API, concurrent users competing for rate limits, database connection pooling, WebSocket connection management at scale, and secrets management. Test in a staging environment that mirrors production before launching.

### Cost Monitoring Matters More Than You Think

One buggy agent loop can burn through your daily budget in minutes. One user sending rapid-fire requests can rack up hundreds of dollars. Implement cost monitoring, per-user spending limits, and alerts from day one. The API bill is not something you want to discover at the end of the month.

### Versioning Prompts Is Like Versioning Code

When you change a system prompt, you're changing the behavior of your application. Track prompt versions. Test changes against your evaluation suite before deploying. Roll back if quality degrades. Treat prompt changes with the same rigor as code changes.
