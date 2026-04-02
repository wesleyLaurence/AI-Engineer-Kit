# Understanding Checks: Streaming

## Check Questions
1. Why do users prefer streaming responses even though the total time to generate the full response is the same?
2. How does streaming work? What is happening between the server and the client during a streamed response?
3. When you stream a response, you still need the full text for conversation history. How do you handle that?
4. Give an example of when you would NOT want to stream a response.
5. What happens if the connection drops in the middle of a streamed response? How would you handle that?

## Completion Criteria
- The learner understands that perceived latency matters more than actual latency, and streaming solves perceived latency
- The learner can describe the streaming mechanism — server-sent events, chunked token delivery, stream completion signal
- The learner understands the implementation pattern: iterate over chunks, display incrementally, accumulate for history
- The learner can identify appropriate and inappropriate uses of streaming
- The learner's chatbot displays responses token by token

## What to Update
- `learner/progress.md` — mark "Streaming" complete
- `learner/notes.md` — add observations about their understanding of UX considerations, any streaming issues encountered
