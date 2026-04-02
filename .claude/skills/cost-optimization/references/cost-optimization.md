# Cost Optimization

## The Problem: AI Is Expensive If You're Not Careful

LLM API calls cost money. Every token in, every token out, has a price. Multiply by thousands of users, multiple calls per conversation, tool usage, and agent loops — costs add up fast. Getting this right is the difference between a sustainable business and one that bleeds money.

---

## Understanding Token Costs

You pay per token for both input and output. Output tokens typically cost 3-5x more than input tokens.

### Where Tokens Go

| Component | Token Cost | Frequency |
|---|---|---|
| System prompt | Fixed per request | Every request |
| Conversation history | Growing per request | Every request |
| Tool definitions | Fixed per request | Every request |
| RAG context | Variable per request | Most requests |
| Model response | Variable (output) | Every request |

---

## Token Minimization Strategies

### Optimize the System Prompt
Sent with every request. A 2,000 token prompt costs 2,000 input tokens per call. Trim ruthlessly: remove redundancy, use concise language, load context dynamically.

### Manage Conversation History
The biggest source of bloat. Summarize old turns, use a sliding window, or set a token budget for history.

### Optimize Tool Schemas
15 tools at 200 tokens each = 3,000 tokens per request. Write concise descriptions, only include relevant tools.

### Optimize RAG Chunks
Retrieve fewer, more relevant chunks (3-5 is usually enough). Use smaller chunks (200-500 tokens).

---

## Model Routing

Not every task needs the most expensive model:

| Task | Model Tier | Why |
|---|---|---|
| Classification/routing | Small (Haiku, GPT-4o-mini) | Simple decision |
| Casual conversation | Mid-tier (Sonnet, GPT-4o) | Good enough quality |
| Complex reasoning | Top-tier (Opus, o3) | Needs maximum capability |
| Summarization | Small to mid-tier | Well-defined task |

A cheap routing model examines the message and decides which model to use. The routing cost is tiny compared to the savings.

---

## Caching

### Semantic Caching
Cache responses for semantically similar inputs. "What's your pricing?" and "How much does it cost?" get the same cached response.

### When to Cache
FAQ-like questions, classification tasks, any request where freshness isn't critical.

### When NOT to Cache
Personalized responses, creative generation, conversations depending on previous turns.

---

## Monitoring and Alerting

Track daily: total token spend, cost per user, cost per conversation, cost by model, cost by feature.

Set alerts: daily spend exceeds threshold, per-user cost unusually high, agent loops exceeding limits.

---

## The Economics of AI SaaS

Your pricing must cover costs with margin. Calculate average cost per user per month. Set pricing at 3-5x your cost. AI costs trend downward over time — models get cheaper, optimization improves.

---

## Key Takeaways

- Token costs are your biggest operational expense — optimize from day one
- Output tokens cost 3-5x input tokens — minimize verbose responses
- System prompts and tool schemas are a fixed tax per request — keep them concise
- Model routing (cheap models for simple tasks) is one of the most effective strategies
- Cache aggressively for FAQ-like patterns
- Monitor costs daily, alert on anomalies, review monthly
- Price at 3-5x per-user cost for sustainability
