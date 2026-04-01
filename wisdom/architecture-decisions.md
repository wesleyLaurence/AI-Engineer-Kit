# Architecture Decisions

When to use what. Decision frameworks for the choices that matter most.

---

## RAG vs. Large Context Windows

### Use RAG When
- Your knowledge base exceeds ~50 pages
- Your data changes frequently
- You need to cite sources
- Cost matters (RAG retrieves only relevant chunks)
- You need high retrieval precision (RAG sidesteps the "lost in the middle" problem)

### Use Large Context When
- Your entire knowledge base is small
- You need the model to reason across the full document set
- The overhead of RAG infrastructure isn't justified
- You're doing one-off analysis, not building a persistent system

### The Practical Answer
For most production applications with substantial knowledge bases, RAG wins. Large context windows are great for ad-hoc analysis.

---

## Agents vs. Chains vs. Simple Calls

### Use a Simple LLM Call When
- The task is self-contained (classification, summarization, translation)
- No external data or tools needed
- One prompt, one response

### Use a Chain When
- The task has multiple steps in a fixed sequence
- Each step's output feeds the next step
- No dynamic decision-making needed

### Use an Agent When
- The steps aren't predictable in advance
- The model needs to decide which tools to use and in what order
- The task requires reacting to intermediate results
- Multi-step reasoning across external data sources

### The Rule
Start with the simplest approach. Only add agency when the simpler approach genuinely fails.

---

## Which Vector Database

### Qdrant
Best overall choice. Open-source, high-performance, excellent filtering, runs locally or in the cloud. Use this unless you have a specific reason not to.

### Pinecone
Fully managed, no infrastructure to maintain. Good if you want zero operational overhead and don't mind vendor lock-in.

### Chroma
Lightweight, great for prototyping. May not be robust enough for production at scale.

### pgvector
PostgreSQL extension. Good if you already use PostgreSQL and want to avoid adding another database. Performance is acceptable but not as fast as purpose-built vector databases.

---

## Which Model for What

### Complex Reasoning and Analysis
Top-tier models (Claude Opus, o3). When quality matters more than cost or speed.

### User-Facing Chat
Mid-tier models (Claude Sonnet, GPT-4o). Best balance of quality, speed, and cost for interactive use.

### High-Volume Simple Tasks
Small models (Claude Haiku, GPT-4o-mini). Classification, routing, extraction, summarization at scale.

### Code Generation
Mid to top-tier. Code quality is highly correlated with model capability. Don't cheap out on code generation.

---

## Streaming vs. Batch

### Use Streaming When
- Users are waiting for the response (any interactive UI)
- Response takes more than ~1 second
- You want to show progress during long operations

### Use Batch When
- Processing happens in the background
- No human is watching the output in real time
- You need to validate/filter the complete response before using it
- Cost optimization (some providers offer batch discounts)

---

## Multi-Agent vs. Single Agent

### Use a Single Agent When
- The task is coherent enough to handle in one context
- Tool count is manageable (under 15)
- You don't need adversarial validation

### Use Multi-Agent When
- Different parts of the task need fundamentally different expertise and tools
- You need one agent to check another's work (generator/critic)
- Context would overflow in a single agent
- Parallel execution of independent subtasks provides meaningful speedup

### The Honest Truth
Most applications that use multi-agent systems would work fine with a single well-designed agent. Multi-agent adds complexity that's rarely justified. Try single-agent first.

---

## Build vs. Buy for Each Component

### Build (it's your core competency)
- Agent logic and prompts
- Domain-specific tools
- Application-specific workflows

### Buy/Use Managed Services
- Authentication (Cognito, Auth0)
- Payments (Stripe)
- Vector database (managed Qdrant, Pinecone)
- Hosting (AWS, managed services)
- LLM inference (use API providers, don't host models unless you must)

The principle: spend your engineering time on what makes your application unique. Use managed services for everything else.
