# Build Details: Adding Streaming

This is a lightweight build. If the chatbot already streams (from the memory-and-threads build), this is a review and refinement pass.

### If Streaming Is Not Yet Implemented

#### Step 1: See the Problem
Run the chatbot and ask a question that produces a long response. Observe the wait time.

#### Step 2: Switch to the Streaming API
Use web search for the current SDK streaming documentation.
Modify the LLM call to use the streaming endpoint/parameter.
Loop over the stream and print each chunk as it arrives.

Checkpoint: Does the response appear token by token in the terminal?

#### Step 3: Accumulate for History
The streaming loop gives you chunks, but the conversation history needs the full response.
Accumulate chunks into a complete string, then add the full response to the messages array.

Checkpoint: Does the chatbot still maintain conversation memory correctly after adding streaming?

#### Step 4: Compare the Experience
Run the chatbot with a long prompt. Compare the feel of streaming vs. non-streaming (they can comment out streaming temporarily to see the difference).

### If Streaming Is Already Working

#### Review and Deepen
- Walk through the streaming code line by line. Make sure they understand each part.
- Discuss error handling: what happens if the stream is interrupted?
- Discuss production considerations: timeouts, partial responses, retry strategies.
- Preview how streaming will work differently with a frontend (WebSocket streaming in Phase 4).
