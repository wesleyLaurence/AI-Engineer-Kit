# Build Details: Evaluation and Monitoring

## Overview
Add tracing, monitoring, and evaluation to the deployed AI application so the learner can observe agent behavior, measure performance, and detect quality issues.

---

### Step 1: Add Structured Logging
Replace any print statements or basic logging with structured JSON logging:
- Use Python's logging module with a JSON formatter (or a library like structlog)
- Include context in every log: request_id, user_id, thread_id, timestamp
- Log levels: ERROR for failures, WARNING for degraded behavior, INFO for normal operations
- Ensure logs flow to CloudWatch (ECS handles this automatically if logging to stdout)

Generate a unique request_id for each incoming request and include it in all logs for that request. This is the correlation ID that ties everything together.

Checkpoint: Can they search CloudWatch logs by request_id and see the full flow of a single request?

### Step 2: Implement Request Tracing
Add middleware that traces every API request:
- Log the start of each request: method, path, user_id, request_id
- Log the end of each request: status code, total duration
- For chat requests, log additional detail: thread_id, message length

Calculate and log latency breakdowns:
- Total request time
- Time spent in LLM inference
- Time spent in tool execution
- Time spent in database operations

Checkpoint: Can they see the latency breakdown for a specific request?

### Step 3: Add Agent Execution Tracing
Capture the full trace of each agent interaction:
- The user message that triggered the interaction
- Each reasoning step the agent took
- Each tool call: tool name, arguments, result, duration
- The final response
- Total token counts (input and output)
- Total agent execution time

Store traces in the database or as structured log entries. Each trace should be queryable by user_id, thread_id, and timestamp.

Consider using a tracing library or service (use web search for current LLM tracing tools like LangSmith, Langfuse, or similar) if the learner wants a visual trace viewer.

Checkpoint: Can they pull up the trace for a specific conversation turn and see every step the agent took?

### Step 4: Build a Metrics Collection Layer
Track key metrics and make them queryable:
- **Latency percentiles** -- p50, p95, p99 response times
- **Error rate** -- percentage of requests that fail
- **Tool failure rate** -- percentage of tool calls that fail, broken down by tool
- **Token usage trends** -- tokens per request over time, per user over time
- **Conversation metrics** -- average turns per conversation, messages per day

For a simple implementation, store metrics in the database and build query endpoints. For a more robust setup, use CloudWatch metrics or a metrics service.

Checkpoint: Can they answer "what was the p95 latency yesterday?" and "which tool fails the most?"

### Step 5: Set Up Dashboards and Alerts
Create visibility into the system:
- Build a simple admin dashboard (even a few API endpoints that return metrics) or use CloudWatch dashboards
- Key views: request volume over time, latency over time, error rate over time, top tool failures
- Set up alerts for critical conditions:
  - Error rate exceeds a threshold (e.g., > 5% over 5 minutes)
  - Latency spike (e.g., p95 > 10 seconds)
  - Agent failures (repeated tool call failures)
  - Alert via email or SNS

Checkpoint: Would they be notified if the agent started failing at 3am?

### Step 6: Add Basic Evaluation
Implement at least one evaluation mechanism:

**User feedback (simpler):**
- Add thumbs up/down buttons to assistant messages in the frontend
- Store feedback in the database linked to the message and trace
- Query: what percentage of responses get positive feedback? Are there patterns in negative feedback?

**Automated evaluation (more advanced):**
- Create a set of test cases: input messages with expected behaviors or expected answers
- Run these periodically (daily or on every deployment)
- Use LLM-as-judge: send the agent's response and the expected behavior to an LLM, ask if the response is correct
- Track pass rates over time -- a drop indicates a regression

Either approach is valid. User feedback is easier to implement; automated evaluation is more proactive.

Checkpoint: Can they identify a low-quality response using their evaluation mechanism?

### Step 7: Test with Real Scenarios
Validate the monitoring system with realistic scenarios:
- Send normal messages and verify traces are captured correctly
- Trigger an agent error (e.g., make a tool fail) and verify it shows up in logs and alerts
- Measure latency under load -- send several concurrent requests and check the metrics
- If using user feedback, submit some feedback and verify it is recorded
- If using automated evaluation, run the test suite and review results
