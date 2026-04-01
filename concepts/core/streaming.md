# Streaming

## The Problem: Blank Screens Kill User Experience

An LLM takes 2-15 seconds to generate a full response. Without streaming, the user sends a message and stares at a blank screen (or a loading spinner) until the entire response is ready. Then the full response appears all at once.

This feels broken. Users think the app crashed. They click the send button again. They close the tab. Even if the response is brilliant, the experience of waiting for it destroys their trust.

Streaming fixes this by sending the response token by token as it's generated. The user sees text appearing immediately — within 200-500 milliseconds of sending their message. The total time to complete the response is the same, but the perceived experience is completely different. Seeing text flow in feels responsive and alive. Waiting for a wall of text feels sluggish and unreliable.

This isn't optional for production applications. If your AI application doesn't stream, users will think it's slow even if it's not.

---

## How Streaming Works

### The Non-Streaming Model

1. Client sends a request
2. Server sends the request to the LLM API
3. LLM generates the entire response (2-15 seconds)
4. LLM API returns the complete response
5. Server sends the complete response to the client
6. Client displays the response

The user waits from step 2 to step 6 with no feedback.

### The Streaming Model

1. Client opens a persistent connection (WebSocket or SSE)
2. Server sends the request to the LLM API with streaming enabled
3. LLM generates the first token (~200ms)
4. LLM API sends the first token immediately
5. Server forwards the token to the client
6. Client displays the token
7. Steps 3-6 repeat for every subsequent token
8. LLM signals completion
9. Connection closes (or stays open for the next message)

The user sees text appearing almost immediately and watches it flow in.

---

## The Two Transport Protocols

### Server-Sent Events (SSE)

A simple, one-directional streaming protocol. The server sends a stream of events to the client over a long-lived HTTP connection.

**How it works:** The client makes a regular HTTP request. The server responds with a special content type and sends events as they become available, one after another, over the same connection. The client processes each event as it arrives.

**Strengths:**
- Simple to implement
- Works over regular HTTP (no special infrastructure)
- Built-in browser support
- Automatic reconnection

**Limitations:**
- One-directional (server → client only)
- Client can't send messages on the same connection
- Some proxies and load balancers don't handle long-lived connections well

**Best for:** Simple streaming scenarios where you just need to stream the model's response back to a client.

### WebSockets

A full-duplex communication protocol. Both the client and server can send messages at any time over a persistent connection.

**How it works:** The client and server perform a "handshake" to upgrade from HTTP to WebSocket. After that, both sides can send messages independently. The connection stays open until either side closes it.

**Strengths:**
- Bidirectional (client and server can both send at any time)
- Lower overhead per message (no HTTP headers)
- Real-time interaction

**Limitations:**
- More complex to implement
- Requires WebSocket-aware infrastructure
- Connection management (reconnection, heartbeats) is your responsibility

**Best for:** Chat applications where the client sends messages and receives streamed responses over the same connection. This is the standard for production AI chat applications.

---

## Streaming with LLM APIs

Every major provider supports streaming. You set a flag in your API request, and instead of receiving one complete response, you receive a stream of small chunks — typically one token each.

### What Changes

**The response comes in pieces.** Each chunk contains a small delta — usually one token of text. Your application accumulates these deltas to build the complete response.

**Token-by-token processing.** You can display each token as it arrives, giving the user immediate feedback. You can also process tokens as they arrive — for example, detecting tool calls before the full response is complete.

**Finish detection.** The stream ends with a special signal indicating the model is done. At this point, you have the complete response.

### What Doesn't Change

**Token counts.** The total tokens used (and the cost) are the same whether you stream or not. Streaming changes the delivery, not the computation.

**The messages format.** You still send the same messages array. The streaming flag just changes how the response is delivered.

---

## Architectural Considerations

### You Can't Post-Process What You Haven't Finished Receiving

With non-streaming responses, you can filter, transform, or validate the complete response before showing it to the user. With streaming, the user sees tokens as they arrive. If the model starts saying something inappropriate, the user sees it before you can filter it.

**Strategies:**
- Buffer a few sentences before starting to stream to the user (adds slight delay but allows basic filtering)
- Implement real-time content filtering that checks each chunk
- Accept that streaming shows raw output and handle issues after the fact
- Use system prompts and guardrails to minimize problematic output at the source

### Connection Management

Streaming requires long-lived connections. This affects your infrastructure:
- Load balancers need to support WebSocket or long-lived HTTP connections
- Connection timeouts need to be longer than the longest expected response
- You need to handle disconnections gracefully (what happens if the user's network drops mid-stream?)
- Server resources are held for the duration of the stream

### Error Handling

Errors during streaming are different from errors in request-response. The stream might fail partway through — you've already sent partial output to the user. You need strategies for:
- Detecting mid-stream errors
- Communicating errors to the user when they've already seen partial output
- Retrying or recovering from interrupted streams
- Timeout handling for streams that stop producing tokens

---

## When NOT to Stream

Streaming isn't always the right choice:

- **Background processing** — If the user doesn't need to see the response in real time (batch processing, async tasks), don't stream
- **Structured output that needs validation** — If you need to validate the complete response before acting on it (like JSON that must be valid), accumulate the full response first
- **Short responses** — If the model consistently responds in under a second, streaming adds complexity without meaningful UX benefit
- **Tool-heavy workflows** — When the model spends most of its time calling tools rather than generating text, streaming the text portions adds little value

---

## Key Takeaways

- Streaming is essential for production chat applications — users won't tolerate blank screens
- Streaming changes the delivery of responses, not the computation or cost
- SSE is simpler (one-directional); WebSockets are more powerful (bidirectional) — chat apps typically use WebSockets
- You can't fully post-process streamed output — plan your content filtering strategy accordingly
- Connection management (timeouts, reconnection, error handling) is a real engineering challenge
- Not everything needs streaming — background tasks and structured output often work better without it
- The perceived speed improvement from streaming is enormous even though total response time is unchanged
