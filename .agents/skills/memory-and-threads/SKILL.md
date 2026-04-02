---
name: memory-and-threads
description: Teaches conversation memory and thread management — why LLMs are stateless, how to manage message history, and patterns for multi-turn conversations. Use when the learner is ready to build a chatbot or asks about conversation memory.
---

# Topic: Threads and Conversation Memory

## When to Use
- Phase 2, second topic (after prompt engineering)
- Learner asks about how chat memory works, why the model forgets, or how to build a chatbot
- Learner is building something that needs multi-turn conversation
- Revisiting to improve memory management in their project

## Prerequisites
- `prompt-engineering` topic complete (they understand system prompts and the messages format)
- First LLM call working

## Concept References
- `references/memory-and-threads.md` — read this before teaching

---

## Teaching Flow

### Open
Start with the problem: "Try something. Send your model a message. Then send a follow-up that references the first message. What happens? It has no idea what you are talking about. That is because LLMs are stateless — every API call is completely independent. The model does not remember anything unless you explicitly tell it what happened before."

This is often a surprise. People who have used ChatGPT assume conversation memory is built in. It is not — ChatGPT manages it for you. When you are building your own application, you manage it yourself.

### Core Points to Cover

**LLMs are stateless:**
- Every API call is a fresh start. The model has zero memory of previous calls.
- What feels like "memory" in ChatGPT is actually the application sending the full conversation history with every request.
- This is fundamental. If they do not internalize this, everything else about memory management will seem like unnecessary complexity.

**The messages array is the memory:**
- The messages array you send to the API IS the conversation. There is no hidden state.
- System message defines behavior. User messages are the human's turns. Assistant messages are the model's previous responses.
- Each API call sends the entire conversation so far. The model reads the full array and generates the next response.

**Why this matters:**
- Context window limits — you cannot send infinite history. Eventually you have to make decisions about what to keep and what to drop.
- Cost — every token in the messages array costs money. Longer conversations cost more per turn.
- Relevance — not all history is equally useful. Strategies for summarizing, truncating, or selectively including history become important in production.

**Thread management patterns:**
- Simple accumulation: add every message to an array, send the full array each time. Works for short conversations.
- Sliding window: keep the last N messages. Simple but loses early context.
- Summarization: periodically summarize older messages into a shorter form. Preserves key information while managing length.
- The right strategy depends on the use case. For now, start simple (full accumulation) and address limits later.

### Close
Connect to the build: "Now let's make this real. We are going to take your LLM call and turn it into an actual chatbot that remembers the conversation."

---

## Adaptive Notes

**Experienced developers:** The concept is straightforward — stateless API, array accumulation. Move through the conceptual piece quickly and get to the build. Focus on the nuances: token limits, cost implications, and the different memory strategies.

**Beginners:** Spend real time on the statelessness concept. It is counterintuitive if their mental model comes from using ChatGPT. Use the analogy: "Imagine you are texting someone who has amnesia. Every message you send, you have to include the entire conversation so far. That is how LLM APIs work."

**Returning learners (review mode):** If their chatbot's memory management is causing issues (running into context limits, high costs), focus on the advanced patterns — sliding window, summarization. Review their implementation and optimize.

---

## Build

Build a multi-turn chatbot with conversation memory and streaming. This is a full build that results in a working chatbot.

See `references/build-details.md` for the complete step-by-step build guide.

**Milestone:** First chatbot with memory.

---

## Understanding Checks
- Can they explain why an LLM "forgets" without explicit history management?
- Can they describe what the messages array contains and how it functions as memory?
- Do they understand the tradeoffs of different memory strategies?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Threads and Conversation Memory" complete in `learner/progress.md`
- Working multi-turn chatbot saved in `projects/`
- Add observations about their understanding of statelessness to `learner/notes.md`
- Update `learner/project.md` if the chatbot connects to their project
- **Milestone:** First chatbot with memory
- Proceed to the next topic: `streaming`
