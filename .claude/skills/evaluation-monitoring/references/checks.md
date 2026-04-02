# Understanding Checks: Evaluation and Monitoring

## Check Questions
1. What is the difference between operational monitoring and quality monitoring? Why do AI applications need both?
2. Show a trace from a recent agent interaction. Walk through each step: what did the agent decide, what tools did it call, what was the result?
3. What metrics are you tracking? For each one, explain what it tells you and what a concerning value would look like.
4. How would you detect that your agent started giving worse answers after a prompt change? What would you look for?
5. Describe your logging strategy. What information is logged at each level? How would you find all logs for a specific request?
6. How do you handle user feedback? How does it feed back into improving the agent?

## Completion Criteria
- The learner understands that AI applications need quality monitoring beyond traditional uptime/latency metrics
- Structured logging is implemented with correlation IDs for request tracing
- Agent execution traces are captured: every reasoning step, tool call, and response is logged
- Key metrics are tracked and accessible: latency breakdown, error rates, token usage, tool usage patterns
- Basic evaluation is in place: either user feedback (thumbs up/down), automated checks, or both
- The learner can use their monitoring to diagnose a specific production issue
- Alerts are configured for critical failures (agent errors, high latency, tool failures)

## What to Update
- `learner/progress.md` -- mark "Evaluation and Monitoring" complete
- `learner/notes.md` -- record their monitoring strategy, key metrics they chose, insights about AI observability challenges
