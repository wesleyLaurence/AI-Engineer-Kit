# Build Details: Cost Optimization

## Overview
Optimize the application's costs through token minimization, model routing, caching, and infrastructure right-sizing. Measure the improvement against a baseline.

---

### Step 1: Analyze Current Costs (Baseline)
Before optimizing, measure the current state:
- Pull usage data from the tracking system built in usage-tracking-payments
- Calculate the average tokens per conversation (input and output separately)
- Break down where tokens are spent: system prompt, conversation history, tool descriptions, user messages, agent responses
- Calculate cost per conversation at current API pricing
- Calculate projected monthly cost at target user volume

This is the baseline. Every optimization will be measured against it.

Checkpoint: Can they state their current cost per conversation and identify the largest cost components?

### Step 2: Optimize System Prompt and Tool Descriptions
The system prompt and tool descriptions are included in every request. Savings here multiply across every interaction.

**System prompt:**
- Review the current system prompt for verbosity
- Eliminate redundant instructions, examples that are not pulling their weight, and unnecessary preamble
- Keep the essential instructions: agent behavior, tool usage guidance, security boundaries
- Measure the token count before and after

**Tool descriptions:**
- Review each tool's description and parameter descriptions
- Make them concise but still clear enough for the model to use the tool correctly
- Remove examples from descriptions if the model uses the tool correctly without them
- Measure the token count before and after

Test after optimization: does the agent still behave correctly with the shorter prompt? Do tool calls still work?

Checkpoint: How many tokens were saved? Does the agent still perform correctly?

### Step 3: Implement Conversation History Management
Long conversations accumulate history that is sent with every request. Manage this:

**Option A: Sliding window**
- Only include the last N messages in the context
- Simple and predictable
- Downside: the agent loses context from earlier in the conversation

**Option B: Summarization**
- Periodically summarize older messages into a concise summary
- Include the summary plus recent messages in the context
- More complex but preserves important context while reducing tokens
- The summarization itself costs tokens, so it only pays off for longer conversations

**Option C: Hybrid**
- Sliding window for most conversations (which are short)
- Summarization kicks in only when conversations exceed a threshold length
- Best of both approaches

Implement the chosen strategy. Test with long conversations to verify the agent still maintains context.

Checkpoint: How many tokens does a 20-message conversation cost before and after history management?

### Step 4: Add Model Routing
Not every request needs the most expensive model. Implement routing:

**Define the routing criteria:**
- Simple requests (greetings, short factual questions, acknowledgments) go to a smaller/cheaper model
- Complex requests (multi-step reasoning, nuanced analysis, creative tasks) go to the more capable model
- Requests involving tool use go to the model that is best at tool calling

**Implement the router:**
- Option A: Rules-based -- keyword matching, message length, conversation stage
- Option B: Classifier -- a lightweight model or even the cheap model itself classifies the request complexity
- Option C: Start with rules, graduate to a classifier as you learn the patterns

Configure the models:
- Fast/cheap model: a smaller model for simple tasks
- Capable/expensive model: the current model for complex tasks

Test routing accuracy: are simple requests correctly routed to the cheap model? Are complex requests still using the capable model?

Checkpoint: What percentage of requests are routed to the cheaper model? Is quality maintained?

### Step 5: Add Response Caching
Cache responses or intermediate results where appropriate:

**Tool result caching:**
- If tools call external APIs or databases with results that do not change frequently, cache them
- Set appropriate TTLs based on how often the data changes
- This saves both token costs (the tool result is in the prompt) and latency

**Response caching (if applicable):**
- If many users ask similar questions, cache the responses
- Semantic caching: use embeddings to find similar previous questions, return the cached response
- This is most effective for FAQ-like patterns and less effective for highly personalized conversations
- Always allow users to get a fresh response if the cached one does not help

**Implementation:**
- Start simple: in-memory cache or Redis
- Track cache hit rates to measure effectiveness
- Monitor quality: are cached responses still accurate?

Checkpoint: What is the cache hit rate? How much cost does caching save?

### Step 6: Optimize Infrastructure Costs
Review and right-size AWS infrastructure:
- **ECS task size** -- are CPU and memory over-provisioned? Reduce to the minimum that handles the load.
- **RDS instance** -- is the database instance larger than needed? For low traffic, the smallest instance may suffice.
- **Auto-scaling** -- if not already configured, add auto-scaling to reduce capacity during low-traffic periods.
- **CloudWatch costs** -- are you logging excessively? Adjust log retention and detail levels.
- **Reserved capacity** -- for predictable workloads, reserved instances are cheaper than on-demand.

Review the AWS bill and identify the top cost items.

Checkpoint: What are the top infrastructure costs? Were any resources over-provisioned?

### Step 7: Measure the Improvement
Compare optimized costs against the baseline from Step 1:
- Recalculate average tokens per conversation (input and output)
- Recalculate cost per conversation
- Calculate the percentage reduction
- Project the savings at target user volume
- Document the tradeoffs: did any optimizations reduce quality? Was the tradeoff worth it?

Celebrate the results. This is the final build of the curriculum.

Checkpoint: What is the final cost per conversation? What is the total percentage reduction? Is quality maintained?
