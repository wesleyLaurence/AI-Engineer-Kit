---
name: evaluation-monitoring
description: Teaches evaluation and monitoring for AI applications -- tracing agent execution, logging decisions, measuring performance, and evaluation frameworks. Use when the learner asks about monitoring, tracing, evaluation, observability, or how to know if their agent is working well.
---

# Topic: Evaluation and Monitoring

## When to Use
- Phase 4, after usage-tracking-payments
- Learner asks about monitoring, tracing, evaluation, or observability
- Learner asks how to know if their agent is performing well
- Learner wants to debug production agent behavior
- Learner asks about LLM evaluation frameworks or metrics

## Prerequisites
- `usage-tracking-payments` topic complete (deployed application with users)
- Working deployed agent with real usage
- Understanding of agent execution flow (from the ReAct agent topic)

## Concept References
- `references/evaluation-and-tracing.md` -- read this before teaching
- `wisdom/debugging-agents.md` -- essential for tracing and debugging strategies

---

## Teaching Flow

### Open with the Problem
Start with a real scenario: "Your agent is deployed. Users are talking to it. But how do you know if it is working well? How do you know if it gave a wrong answer yesterday? How do you know if tool calls are failing silently? How do you know if the average response takes 3 seconds or 30? You are flying blind. Monitoring and evaluation give you eyes on your production system."

### Core Points to Cover

**Why monitoring matters for AI:**
- Traditional software: you monitor uptime, error rates, response times. Clear metrics.
- AI applications: the agent can be "up" and "responding quickly" and still be giving terrible answers. Correctness is not captured by standard metrics.
- You need two kinds of monitoring: operational (is it running?) and quality (is it good?)
- Without monitoring, you find out about problems when users complain -- or leave

**Tracing agent execution:**
- Every agent interaction should produce a trace: the full sequence of decisions, tool calls, and responses
- A trace includes: the user message, the system prompt, each reasoning step, each tool call (name, arguments, result), the final response, token counts, latency
- Traces are how you debug production issues: "Why did the agent give a wrong answer to User X at 3pm yesterday?"
- Store traces in a structured format so you can search, filter, and analyze them
- This connects directly to the agent debugging skills from `wisdom/debugging-agents.md`

**Key metrics to track:**
- **Latency** -- time to first token, total response time. Broken down by: LLM inference time, tool execution time, total.
- **Error rates** -- agent errors, tool failures, timeout rates
- **Token usage** -- already tracking this from usage-tracking-payments, but now correlate with quality
- **Tool usage patterns** -- which tools are called most? Which fail most?
- **Conversation depth** -- how many turns per conversation? Are users getting answers quickly or going in circles?

**Evaluation frameworks:**
- Automated evaluation: use an LLM to judge the quality of responses (LLM-as-judge)
- Reference-based evaluation: compare responses against known-good answers
- User feedback: thumbs up/down on responses, explicit ratings
- Regression testing: a set of test cases that should always produce correct answers
- Evaluation is not a one-time thing -- run it continuously as you change prompts, tools, or models

**Logging best practices:**
- Structured logging (JSON) -- makes logs searchable and parseable
- Log levels: errors for failures, warnings for degraded performance, info for normal operations
- Correlation IDs: tie all logs for a single request together so you can trace the full flow
- Do not log sensitive data: no user messages in plain text, no API keys, no PII
- CloudWatch (or your logging service) should have dashboards and alerts

### Close
Transition to the build: "Let's add tracing and monitoring to your application. By the end, you will be able to see exactly what your agent is doing in production, how well it is performing, and where the problems are."

---

## Adaptive Notes

**Experienced developers:** They likely know monitoring from traditional software. Focus on the AI-specific challenges: evaluating response quality, tracing multi-step agent reasoning, and the LLM-as-judge pattern. Build efficiently -- 45-60 minutes.

**Beginners:** Start with the simplest monitoring: structured logging and basic metrics. The concept of "the agent can be running but giving bad answers" is the key insight. Build will take 60-90 minutes.

**Returning learners (review mode):** Focus on evaluation frameworks and automated quality monitoring. Help them build a regression test suite for their agent.

---

## Build

Add tracing, monitoring, and evaluation to the deployed application.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Add structured logging
2. Implement request tracing
3. Add agent execution tracing
4. Build a metrics collection layer
5. Set up dashboards and alerts
6. Add basic evaluation (user feedback and automated checks)
7. Test with real scenarios

---

## Understanding Checks
- Can the learner explain the difference between operational monitoring and quality monitoring?
- Can they trace through a production request and explain each step the agent took?
- Can they describe their key metrics and what each one tells them?
- Can they explain how they would detect a regression in agent quality?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Structured logging implemented throughout the application
- Agent execution traces captured and stored
- Key metrics tracked: latency, error rates, token usage, tool usage
- Basic evaluation mechanism in place (user feedback or automated checks)
- Dashboards or log queries for monitoring
- Alerts for critical failures
- Code saved in `projects/`
- Mark "Evaluation and Monitoring" complete in `learner/progress.md`
- Add observations about their understanding of AI observability to `learner/notes.md`
- Proceed to `security-guardrails`
