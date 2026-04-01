# Performance and Cost Wisdom

Hard-won lessons about the economics and performance of running AI systems in production.

---

### Start with the Smallest Model That Works

The instinct is to use the most powerful model for everything. Resist it. Start with the cheapest model that produces acceptable output for each task. You can always upgrade. Starting expensive and trying to optimize later is much harder — you've already built around the expensive model's capabilities, and downgrading breaks things.

### Token Costs Add Up Faster Than You Think

A single chat message costs fractions of a cent. Multiply by conversation turns, by users, by agent loops, by tool calls. A chatbot handling 1,000 conversations per day at an average of 10 turns each can easily run $500-2,000/month in API costs alone. Model this before you launch.

### Cache Aggressively

If 30% of your users ask similar questions (and they will), you're paying for the same computation repeatedly. Implement semantic caching early. The embedding call for cache lookup is orders of magnitude cheaper than a full LLM response.

### Model Routing Saves Real Money

Use a cheap, fast model (Haiku, GPT-4o-mini) as a router to classify incoming requests. Simple tasks go to cheap models. Only complex tasks go to expensive models. In practice, 60-80% of requests can be handled by cheaper models. This cuts your model costs by 40-60%.

### Context Size Affects Everything

Every token in the context costs money, adds latency, and can affect quality. A 50K token context is not "just like" a 5K token context with more data — the model processes differently, responds more slowly, and may miss information in the middle. Keep context focused.

### Streaming Doesn't Cost More, But It Changes Architecture

Streaming uses the same tokens as non-streaming. The cost is identical. But streaming requires WebSocket infrastructure, different error handling, and complicates caching. Plan for this.

### Monitor Costs From Day One

Don't wait until your first surprise bill. Track token usage per request, per user, per feature from the start. Set up alerts for daily spend thresholds. Know your cost per conversation before you set your pricing.

### The Intelligence/Cost/Speed Triangle Is Real

You can have two of three: intelligent, cheap, fast. Optimize for what matters for each specific task. User-facing responses need speed. Complex analysis needs intelligence. Background processing can be cheap.

### Output Tokens Cost 3-5x Input Tokens

This asymmetry matters. A verbose system prompt telling the model to "be thorough and detailed" is actively expensive. Sometimes "be concise" is the most cost-effective prompt instruction you can write.

### Agent Loops Are Cost Multipliers

A ReAct agent that takes 8 iterations to solve a task is making 8 LLM calls, each with a growing context (the scratchpad). A single complex agent run can cost more than hundreds of simple chat turns. Set iteration limits and token budgets on every agent.
