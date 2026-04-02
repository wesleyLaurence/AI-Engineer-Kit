# Context Engineering

## The Problem: The Model Only Knows What You Tell It

An LLM reasons about what's in its context window and nothing else. If a critical piece of information isn't in the context, the model either ignores it, guesses, or hallucinates. If too much irrelevant information is in the context, the model gets confused, loses focus, or misses the important parts.

Context engineering is the discipline of deliberately designing what information goes into the model's context — and what stays out. It's arguably more important than prompt engineering, because even a perfect prompt fails if the context is wrong.

---

## Why Context Engineering Matters More Than You Think

### The Context Window Is Not Just a Size Limit

Most people think of the context window as a container — you just need to fit your data inside it. But context is much more nuanced than that.

**The model's attention isn't uniform.** Research has shown that models pay more attention to the beginning and end of the context, and less to the middle (the "lost in the middle" phenomenon). Information buried in the middle of a long context is more likely to be missed.

**More context isn't always better.** Adding irrelevant information to the context can actually degrade performance. The model has to sift through noise to find the signal, and it doesn't always succeed. A focused 5K token context often outperforms a sprawling 50K token context.

**Context determines behavior.** The model's behavior isn't just a function of its prompt — it's a function of everything in its context. The system prompt, conversation history, tool definitions, retrieved documents, and any other context all shape the response.

---

## The Token Budget

Think of context as a budget. You have a fixed number of tokens (the context window), and you need to allocate them wisely.

### What Competes for Context Space

- **System prompt** — Your instructions, rules, and behavioral guidance
- **Conversation history** — Previous messages in the conversation
- **Tool definitions** — Schemas for available tools
- **Retrieved documents** — RAG results, injected context
- **Intermediate results** — Agent scratchpad, previous tool call results
- **The model's response** — Output tokens come from the same budget

### Allocation Strategy

Prioritize by impact. The system prompt is always present and always important — invest tokens there. Tool definitions are necessary but can be optimized (concise descriptions, only include relevant tools). Conversation history should be managed (summarize old turns, keep recent ones). Retrieved documents should be relevant and concise (good chunking, good retrieval).

---

## Context Engineering vs. Prompt Engineering

**Prompt engineering** is about how you phrase instructions to the model. It's about the words you use, the structure of your instructions, the examples you provide.

**Context engineering** is about what information the model sees at all. It's about which files to load, which conversation turns to keep, which documents to retrieve, which tools to include.

They're complementary. A well-engineered prompt in a poorly-engineered context will underperform. The best prompt in the world can't compensate for missing or irrelevant context.

### The Hierarchy

1. **Context selection** — Choose the right information (context engineering)
2. **Context arrangement** — Put the most important information where the model attends most (beginning and end)
3. **Instruction quality** — Phrase instructions clearly (prompt engineering)
4. **Output format** — Specify how the response should be structured

---

## Strategies for Effective Context Engineering

### Only Include What's Relevant

This sounds obvious but is violated constantly. Loading your entire codebase into context "just in case" is worse than loading the three files that actually matter. RAG that retrieves 20 chunks when 5 would suffice is wasting tokens and adding noise.

Before including something in context, ask: "Does the model need this information to produce a good response to this specific request?" If not, leave it out.

### Front-Load Important Information

Put the most critical context at the beginning of the system prompt and at the beginning of the context window. This is where the model pays the most attention.

### Use Structure to Aid Navigation

When context is long, structure it with clear headers, sections, and delimiters. This helps the model "navigate" the context and find relevant sections. Markdown formatting works well for this.

### Compress History

For long conversations, summarize earlier turns rather than including the full transcript. The model needs to know what was discussed, not every word of every turn.

### Dynamic Context Loading

Don't load everything upfront. Load context on-demand based on the current task. If the user is asking about deployment, load the deployment docs — don't load the testing docs too.

This is what well-designed skill systems do: each skill specifies which files to load, ensuring focused context for each task.

### Manage Tool Schemas

Each tool definition consumes tokens. If you have 30 tools defined, that's potentially thousands of tokens of schemas — before any actual content. Only include tools that are relevant to the current task.

---

## The Lost-in-the-Middle Problem

Research has demonstrated that LLMs struggle to find and use information placed in the middle of very long contexts. They attend well to the beginning (primacy) and end (recency), but the middle gets less attention.

### Practical Implications

- Put critical instructions at the beginning of the system prompt, not buried in the middle
- When injecting retrieved documents, put the most relevant ones first and last
- For very long contexts, consider restructuring rather than hoping the model will find what it needs
- RAG sidesteps this problem entirely by injecting only relevant chunks near the beginning or end of the context

---

## Context Engineering in Practice

### For Chat Applications
- System prompt with core behavior (beginning of context)
- Compressed conversation history (middle)
- Recent messages in full (end of context, near the model's response)
- Retrieved context from RAG if needed (between system prompt and conversation)

### For Agent Systems
- System prompt with agent instructions
- Tool definitions (only relevant tools)
- Current task description
- Agent scratchpad (grows with each iteration — monitor the size)
- Retrieved context as needed

### For This Repo
The AI Engineer Kit practices context engineering at every level:
- AGENTS.md is structured so the agent can find what it needs quickly
- Skills specify exactly which concept and wisdom files to load
- Concept files are separated by topic so only relevant ones are loaded
- The learner directory provides focused context about the current learner

---

## Key Takeaways

- Context engineering is about what information the model sees — it's as important as how you phrase your prompts
- The model's attention isn't uniform — front-load important information, avoid the "lost in the middle" trap
- More context isn't always better — irrelevant context degrades performance
- Treat context as a budget — allocate tokens deliberately based on what matters for each request
- Load context dynamically based on the current task rather than loading everything upfront
- Well-structured context (headers, sections, clear organization) helps the model navigate long inputs
- RAG, skills, and dynamic tool loading are all context engineering techniques
