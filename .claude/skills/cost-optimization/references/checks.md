# Understanding Checks: Cost Optimization

## Check Questions
1. Where are your token costs coming from? Break down the cost per conversation: system prompt, conversation history, tool descriptions, response tokens.
2. How did you optimize your system prompt? How many tokens did you save?
3. Explain your conversation history management strategy. What happens to old messages? How does this affect quality vs. cost?
4. Describe your model routing strategy. What criteria determine which model handles a request? What is the cost difference?
5. What are you caching? What is your cache hit rate? What is the quality tradeoff?
6. What was your cost per conversation before and after optimization? What is the percentage reduction?

## Completion Criteria
- The learner can break down their token costs and identify the most expensive components
- System prompt and tool descriptions are optimized for conciseness without sacrificing clarity
- Conversation history management is implemented (summarization, sliding window, or similar)
- Model routing is implemented: simple requests use a cheaper model, complex requests use a more capable model
- Caching is implemented where appropriate (tool results, common queries, or semantic caching)
- Infrastructure costs have been reviewed and right-sized
- The learner has measured the cost reduction and can quantify the improvement
- They understand the tradeoffs: cost vs. quality, cost vs. latency

## Milestone Verification
- **Fully deployed, production-ready AI application** -- auth, payments, monitoring, security, and cost optimization all working in a deployed application

## What to Update
- `learner/progress.md` -- mark "Cost Optimization" complete, note the Phase 4 milestone, mark Phase 4 complete
- `learner/notes.md` -- record their cost analysis, optimization decisions, final per-conversation cost, reflections on the full curriculum journey
