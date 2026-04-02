---
name: streaming
description: Teaches streaming responses — why streaming matters for UX, how server-sent events work, and when to use streaming vs. regular responses. Use when the learner asks about streaming, latency, or real-time LLM output.
---

# Topic: Streaming

## When to Use
- Phase 2, third topic (after memory-and-threads)
- Learner asks about streaming, real-time output, or why responses feel slow
- Learner wants to improve the UX of their chatbot
- Revisiting to add streaming to a new feature or debug streaming issues

## Prerequisites
- `memory-and-threads` topic complete (working chatbot with conversation history)
- Understands the basic LLM API call/response pattern

## Concept References
- `references/streaming.md` — read this before teaching
- `wisdom/production-lessons.md` (UX section) — weave in production UX lessons

---

## Teaching Flow

### Open
Start with the problem: "Run your chatbot and ask it a long question. What happens? You wait. And wait. Then the entire response appears at once. Now think about ChatGPT — the response appears word by word. Which feels faster? They actually take the same total time. But streaming feels dramatically faster because you start reading immediately instead of staring at a blank screen."

This is a UX lesson as much as a technical one. Perceived latency matters more than actual latency.

### Core Points to Cover

**Why streaming matters:**
- LLMs generate tokens one at a time internally. Without streaming, the API waits until ALL tokens are generated, then sends the complete response.
- With streaming, each token is sent as it is generated. The user starts reading immediately.
- Total time is the same. Perceived time is dramatically different.
- This is not optional for production AI applications — users expect streaming. An application that makes them wait 5-10 seconds for a response with no feedback feels broken.

**How streaming works technically:**
- Server-Sent Events (SSE): the server keeps the connection open and pushes data as it becomes available.
- Each "event" is a small chunk — typically one or a few tokens.
- The client reads these chunks as they arrive and displays them incrementally.
- When the stream is done, the server signals completion.

**The streaming API pattern:**
- Instead of getting a single response object, you get a stream/iterator.
- You loop over the stream, processing each chunk as it arrives.
- You still need to accumulate the full response for the conversation history.
- Use web search for the current SDK streaming API — the exact syntax matters and changes between versions.

**When NOT to stream:**
- Backend processing where no human is watching (batch jobs, automated pipelines).
- When you need to process the complete response before doing anything with it (some tool-calling patterns).
- Very short responses where the overhead is not worth it.

### Close
Connect directly to their chatbot: "Let's add streaming to your chatbot right now and see the difference."

If the chatbot build (memory-and-threads) already included streaming, this is a review and deepening of the concept. Focus on the technical details and production considerations they may have glossed over during the build.

---

## Adaptive Notes

**Experienced developers:** They likely understand the concept of streaming (SSE, WebSockets) from other contexts. Focus on the LLM-specific patterns: how to accumulate chunks for history, how streaming interacts with tool calling, and production considerations. Keep it brief.

**Beginners:** The UX demonstration is the most important part. Let them experience the difference between streaming and non-streaming. Then walk through the technical implementation carefully. Do not rush the code — each line of the streaming loop matters.

**Returning learners (review mode):** If streaming is already working in their chatbot, focus on the areas they did not fully internalize — how it works under the hood, production patterns (error handling during streams, timeouts), or how streaming will work differently when they add a frontend later.

---

## Build

Add streaming to their chatbot. If the chatbot build already included streaming (Step 4 of the memory-and-threads build), this is a review and refinement pass rather than building from scratch.

See `references/build-details.md` for guidance.

---

## Understanding Checks
- Can they explain why users prefer streaming even though the total response time is the same?
- Can they describe how streaming works technically (server-sent events, chunked delivery)?
- Do they understand when streaming is appropriate and when it is not?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Streaming" complete in `learner/progress.md`
- Chatbot has working streaming responses
- Add observations about their understanding of UX and streaming to `learner/notes.md`
- Proceed to the next topic: `tool-calling`
