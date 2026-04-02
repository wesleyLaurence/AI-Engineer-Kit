---
name: cost-optimization
description: Teaches cost optimization for AI applications -- token minimization, model routing, caching, and the economics of running LLM-powered services. Use when the learner asks about reducing costs, model selection, caching, token optimization, or the economics of AI applications.
---

# Topic: Cost Optimization

## When to Use
- Phase 4, final topic (capstone of the Production phase)
- Learner asks about reducing API costs, token optimization, or model routing
- Learner asks about caching, cheaper models, or the economics of running AI applications
- Learner wants to make their deployed application more cost-efficient

## Prerequisites
- `security-guardrails` topic complete (full production application with auth, payments, monitoring, and security)
- Usage tracking in place (they have data on how much their application costs)
- Understanding of how tokens work and how pricing scales

## Concept References
- `references/cost-optimization.md` -- read this before teaching
- `wisdom/performance-and-cost.md` -- essential cost and performance lessons

---

## Teaching Flow

### Open with the Problem
Start with the numbers: "Look at your usage data. How many tokens are you using per conversation? What does that cost per user per month? Now multiply by the number of users you hope to have. If your agent uses 10K tokens per conversation and you have 1,000 conversations per day, that is 10 million tokens per day. At current pricing, that is real money. Cost optimization is not about being cheap -- it is about building a sustainable business. Every token you save is margin you can reinvest."

### Core Points to Cover

**The economics of AI applications:**
- LLM APIs charge per token (input and output, often at different rates)
- Costs scale linearly with usage -- more users, more conversations, more tokens, more cost
- Your business model depends on the gap between what users pay and what it costs you to serve them
- A 2x reduction in token usage is a 2x increase in margin. This matters more than almost any other optimization.

**Token minimization:**
- **System prompts** -- the system prompt is sent with every request. A 500-token system prompt that could be 200 tokens costs you 300 extra tokens per request, multiplied by every request. Trim aggressively.
- **Conversation history management** -- do not send the entire conversation history every time. Summarize older messages, limit history window, or use a sliding window approach.
- **Tool descriptions** -- tool descriptions are included in the prompt. Concise, clear descriptions cost fewer tokens than verbose ones.
- **Response length control** -- instruct the model to be concise where appropriate. A 500-token response that could be 200 tokens costs you 300 tokens.
- **Measure before optimizing** -- use the usage tracking data to identify where tokens are being spent

**Model routing:**
- Not every request needs the most powerful (and expensive) model
- Simple questions (greetings, FAQs, clarifications) can use a smaller, cheaper model
- Complex reasoning tasks need the more capable model
- Route based on: message complexity, task type, user tier
- The implementation: a classifier (which can be rules-based or LLM-based) that decides which model to use
- This can cut costs by 50-80% for typical workloads

**Caching:**
- Many users ask similar questions. If you have seen a similar question before, you may not need a new LLM call.
- Semantic caching: store responses indexed by the meaning of the question, not the exact text
- Exact match caching: for repeated identical queries (less common in chat, more common in tools)
- Cache tool results: if a tool queries external data that does not change frequently, cache the result
- Cache invalidation: when does cached data become stale? Set appropriate TTLs.

**Infrastructure cost optimization:**
- Right-size your ECS tasks (do not overprovision CPU/memory)
- Use auto-scaling to reduce instances during low-traffic periods
- Monitor RDS costs -- the database instance size matters
- Review CloudWatch costs -- excessive logging can be expensive
- Set budgets and alerts (reinforcing from the deployment topic)

### Close
Wrap up the entire curriculum: "This is the last topic. When you finish this build, you will have a fully deployed, production-ready AI application with authentication, payments, monitoring, security, and cost optimization. That is a complete product. Let's optimize the costs and finish strong."

---

## Adaptive Notes

**Experienced developers:** They understand optimization concepts. Focus on the AI-specific patterns: model routing, semantic caching, and the economics of token pricing. Challenge them to calculate their per-user cost and optimize it by a target percentage. Build efficiently -- 45-60 minutes.

**Beginners:** Start with the concrete numbers from their usage data. Make the cost tangible: "this conversation cost $0.03." Then introduce optimizations one at a time, measuring the impact of each. Build will take 60-90 minutes.

**Returning learners (review mode):** Focus on advanced optimizations: model routing with classifiers, semantic caching implementation, and business model analysis. Challenge them to build a cost dashboard.

---

## Build

Optimize the application's costs through token minimization, model routing, and caching.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Analyze current costs (baseline measurement)
2. Optimize the system prompt and tool descriptions
3. Implement conversation history management
4. Add model routing
5. Add response caching
6. Optimize infrastructure costs
7. Measure the improvement

**Milestone:** Fully deployed, production-ready AI application with auth, payments, monitoring, security, and cost optimization.

---

## Understanding Checks
- Can the learner explain where their token costs come from and which areas are most expensive?
- Can they describe their model routing strategy and when each model is used?
- Can they explain their caching strategy and what hit rate they achieve?
- Have they measured the cost reduction from their optimizations?

See `references/checks.md` for detailed check criteria.

---

## When Done
- System prompt and tool descriptions optimized for token efficiency
- Conversation history management implemented (summarization or sliding window)
- Model routing implemented (cheaper model for simple tasks)
- Caching implemented where appropriate
- Infrastructure costs reviewed and optimized
- Cost reduction measured against baseline
- Code saved in `projects/`
- Mark "Cost Optimization" complete in `learner/progress.md`
- Add observations about their understanding of AI economics to `learner/notes.md`
- **Milestone:** Fully deployed, production-ready AI application with auth, payments, monitoring, security, and cost optimization
- Phase 4 complete. Celebrate.
