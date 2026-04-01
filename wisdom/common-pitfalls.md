# Common Pitfalls

Things that bite everyone. Organized by area so the agent can surface relevant warnings at the right time.

---

## Environment Setup

### Not Using Virtual Environments
You install packages globally, everything works until two projects need different versions of the same package. Always use venv or conda. Always.

### Forgetting to Activate the Environment
You install a package, it goes to the system Python. Your project can't find it. Check which Python you're using before installing anything.

### API Keys in Code
You hardcode your API key "just for testing." It ends up in git. Someone finds it. You get a surprise bill. Use environment variables and .env files from the start.

### .env File Not in .gitignore
You create a .env file and forget to gitignore it. One commit later, your keys are in your repository history forever (even if you delete the file later).

---

## Prompting

### Vague System Prompts
"Be helpful" gives the model no useful guidance. Be specific about what the model should do, how it should respond, and what it should avoid.

### Testing Only with Friendly Inputs
Your prompt works great when users cooperate. It falls apart when they send weird inputs, try to break it, or ask unexpected questions. Test adversarially.

### Not Using System Prompts at All
Putting all instructions in user messages instead of the system message. System messages are designed for persistent instructions — use them.

### Prompt Too Long
A 5,000 token system prompt that tries to cover every possible scenario. The model's adherence to instructions degrades as the prompt grows. Focus on the 10 most important rules.

---

## Memory and Conversations

### Not Managing Conversation Length
Conversations grow unbounded until they hit the context window limit and either error out or silently truncate. Implement conversation management (summarization or sliding window) from the start.

### Trusting the Model to Track State
Asking the model "what did we decide earlier?" instead of tracking state in your application. The model might hallucinate a different decision. Your app should track state and include it in the prompt.

### Losing Conversation on Page Refresh
Building a chat UI that stores messages only in frontend state. User refreshes, everything is gone. Persist conversations server-side from the beginning.

---

## RAG

### Bad Chunking Strategy
The single most common RAG failure. Chunks that are too small lose context. Chunks that are too large dilute relevance. Investing time in chunking strategy pays off more than any other RAG optimization.

### Not Attaching Metadata to Chunks
You retrieve a relevant chunk but don't know which document it came from, what section, or when it was written. Always attach metadata during ingestion.

### Retrieving Too Many Chunks
Retrieving 20 chunks "to be safe" floods the context with irrelevant information. Start with 3-5 chunks and increase only if needed.

### Not Testing with Real Queries
Building a RAG pipeline and testing it with the exact questions the documents answer. Real users ask questions differently. Test with natural language variations.

### Ignoring Hybrid Search
Pure semantic search misses exact keyword matches. Pure keyword search misses semantic relationships. Use both together.

---

## Tool Calling

### Poor Tool Descriptions
The model uses tool descriptions to decide when to call them. Vague descriptions ("does stuff with the database") lead to wrong tool selection. Be specific about when to use each tool.

### Too Many Tools
More than ~15 tools and the model starts making worse choices. The schema bloats the context, and the model struggles to select the right tool. Be selective.

### Not Handling Tool Errors
A tool fails and your application crashes instead of returning an error message to the model. Always return error information as a tool result so the model can adjust its approach.

### Tools That Return Too Much Data
A search tool returns 50 results with full details. The model can't process that much information effectively. Return summaries and let the model request details if needed.

---

## Agents

### No Iteration Limit
An agent gets stuck in a loop, calling the same tool with the same arguments. Without a maximum iteration limit, it burns tokens forever. Always set a max iterations cap.

### Over-Trusting Agent Output
The agent says it completed the task successfully. You trust it without verification. Agent self-reporting is unreliable — always verify critical outputs.

### Agent for Everything
Using a full ReAct agent loop when a simple chain or single LLM call would work. Agents add cost, latency, and unpredictability. Use them only when dynamic decision-making is actually required.

---

## Deployment

### No Streaming in Production
Users stare at a blank screen for 5-10 seconds. They think the app is broken. They refresh. They leave. Implement streaming from day one in any user-facing application.

### Not Handling Rate Limits
The LLM API returns a 429 (rate limited) and your application crashes. Implement retry with exponential backoff for all external API calls.

### No Error Handling for Model Failures
Model APIs go down. They return errors. They time out. Your application needs to handle all of these gracefully rather than showing users a stack trace.

### Hardcoding Model Names
You hardcode "gpt-4" throughout your codebase. The model is deprecated. Now you need to find and update every reference. Use configuration for model names.
