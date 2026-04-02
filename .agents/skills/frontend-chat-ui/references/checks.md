# Understanding Checks: Frontend Chat UI

## Check Questions
1. How does your frontend connect to your backend? What protocol is used for chat vs. thread management?
2. Walk through what happens when a user types a message and presses Enter -- from the input to the streaming response appearing on screen.
3. How do you handle streaming tokens? How does the UI update as each token arrives?
4. What happens if the WebSocket connection drops? What does the user see?
5. How does conversation management work? How does the user create, switch between, and view different threads?
6. What UX considerations did you implement (auto-scroll, loading states, error messages)?

## Completion Criteria
- The learner has a working Next.js chat frontend
- Messages display correctly with user and assistant roles
- Streaming works: tokens appear in real time as they arrive over WebSocket
- Input area works: Enter sends, Shift+Enter adds a newline, input is disabled during responses
- Conversation management works: sidebar with thread list, create new conversation, switch threads
- Error states are handled: connection failures show a clear message, not a blank screen
- The frontend talks to their FastAPI backend and produces correct results end-to-end

## What to Update
- `learner/progress.md` -- mark "Frontend Chat UI" complete
- `learner/notes.md` -- record their experience with frontend development, any insights about the full-stack connection, UX decisions they made
