# Memory and Threads

## The Core Problem

LLMs have no memory. Zero. Every API call is completely independent — the model doesn't know what you said five minutes ago, five seconds ago, or in any previous request. It processes the messages you send it right now and generates a response. That's it.

This is deeply counterintuitive because chatbots feel like they remember. When you talk to ChatGPT and it references something you said earlier in the conversation, it seems like it has memory. It doesn't. What's actually happening is that the application is sending the entire conversation history with every single request. The "memory" is an illusion created by replaying context.

Understanding this is essential because it changes how you architect everything. Memory isn't something you get for free — it's something you build, manage, and pay for.

---

## How Chat Actually Works

### The Messages Array

Every API call includes a messages array — a list of all the messages in the conversation so far. When the model generates a response, it sees the full conversation:

1. System message (your instructions)
2. User message 1
3. Assistant response 1
4. User message 2
5. Assistant response 2
6. User message 3 (the current turn)

The model reads all of this, understands the conversation so far, and generates the next assistant response. Then your application appends that response to the array and waits for the next user message.

### The Cost of Context

Every token in the conversation history costs money and adds latency. A conversation that's been going for 50 turns might have thousands of tokens of history. You're paying for all of those tokens on every single request, even though most of the content hasn't changed.

This is why conversation management matters. You need strategies for keeping the context useful without letting it grow unbounded.

---

## Short-Term Memory: Conversation Context

Short-term memory is the conversation history itself — the messages array. It gives the model awareness of recent turns.

### Managing Conversation Length

As a conversation grows, you'll eventually approach the model's context window limit. You need a strategy:

**Sliding window** — Keep only the most recent N messages. Old messages fall off the beginning. Simple but lossy — the model loses access to early context.

**Summarization** — Periodically summarize the conversation so far and replace the full history with the summary plus recent messages. Preserves key information while reducing token count. More complex but better retention.

**Token budget** — Set a fixed token budget for conversation history. When the history exceeds it, apply truncation or summarization to fit within budget.

### The Tradeoff

More history = better context awareness but higher cost and latency. Less history = cheaper and faster but the model may lose track of the conversation. Finding the right balance depends on your use case.

---

## Long-Term Memory: Beyond the Conversation

Short-term memory disappears when the conversation ends. For many applications, you need memory that persists across conversations.

### Approaches to Long-Term Memory

**Database storage** — Save conversations to a database. When a user returns, load their previous conversations and include relevant context in the system prompt or messages. Simple and reliable.

**RAG on conversation history** — Store past conversations in a vector database. When the user asks something, retrieve the most relevant past exchanges and inject them into context. Scales better than loading full histories.

**User profiles** — Maintain a structured profile for each user (preferences, facts they've mentioned, decisions they've made). Update it after each conversation. Include it in the system prompt so the model always knows who it's talking to.

**Explicit memory systems** — Let the model decide what's worth remembering. After each conversation, ask the model to extract key facts and store them. This is how some advanced assistants maintain long-term knowledge about users.

---

## Thread Management

A "thread" is a single conversation — a sequence of messages with a beginning and (sometimes) an end. Most AI applications need to manage multiple threads per user.

### The Architecture

Each thread has:
- A unique identifier
- An ordered list of messages
- Metadata (creation time, title, status)
- Association with a user

Your application stores threads in a database, loads the relevant thread when a user opens a conversation, and appends new messages as the conversation progresses.

### Thread Lifecycle

1. **Create** — User starts a new conversation. A new thread is created with the system prompt as the first message.
2. **Continue** — User sends messages. Each user message and assistant response is appended to the thread.
3. **Resume** — User returns to a previous conversation. The thread is loaded from the database and the messages are sent with the next request.
4. **Archive** — Old threads that are no longer active. They're kept in storage but not actively loaded.

### Naming and Organization

Users need to find and navigate their conversations. Common patterns:
- Auto-generate titles by asking the model to summarize the conversation topic
- Let users rename threads manually
- Show recent threads sorted by last activity
- Search across thread history

---

## The Statefulness Illusion

Your application maintains state. The model does not. This distinction matters because it affects where you put logic.

**Do NOT rely on the model to track state.** Don't ask the model "what did we decide earlier?" and trust the answer. The model might hallucinate a different decision. Your application should track state explicitly and include the current state in the prompt.

**Do include state in the prompt.** If your application has state (current step in a workflow, user preferences, previous decisions), include it in the system prompt or messages. The model needs this context to behave correctly.

**Do validate model output against your state.** If the model says "as we discussed, the user prefers option A" — check your records. The model is generating plausible text, not querying a database.

---

## Memory Patterns for AI Applications

### The Conversation Buffer
The simplest pattern: store all messages and send them all with each request. Works for short conversations. Fails when conversations get long.

### The Summary Buffer
Keep a running summary of the conversation plus the last few messages. The model gets the gist of everything plus recent detail. Good balance of context and cost.

### The Entity Memory
Extract and maintain key entities (people, decisions, facts) from the conversation. Include these entities in the system prompt. The model always knows the important facts without needing the full history.

### The Retrieval-Augmented Memory
Store messages in a vector database. For each new message, retrieve the most relevant past messages and include them in context. Scales to very long conversation histories because you only retrieve what's relevant.

---

## Key Takeaways

- LLMs are stateless — "memory" is your application sending conversation history with each request
- Every token of history costs money and adds latency — manage conversation length deliberately
- Short-term memory is the messages array; long-term memory requires databases or vector stores
- Thread management (creating, continuing, resuming conversations) is core application architecture
- Never trust the model to track state — maintain state in your application and include it in the prompt
- Choose a memory strategy based on your conversation length and persistence needs
- The simplest approach that works for your use case is the right one — don't over-engineer memory
