# Build Details: Frontend Chat UI

## Overview
Build a Next.js chat frontend connected to the FastAPI backend via WebSocket for streaming and REST for thread management.

---

### Step 1: Set Up Next.js Project
Use the latest stable version of Next.js. Install in `projects/[project-name]/frontend/`.
Set up the basic project structure with app router.
Verify the development server runs.

### Step 2: Build the Message Display
Build a message list component:
- Each message has a role (user or assistant), content, and timestamp
- User messages styled differently from assistant messages
- Assistant messages render markdown (install a markdown rendering library)
- Auto-scroll to the latest message
- Stop auto-scrolling if the user scrolls up to read earlier messages

Checkpoint: Can they render a hardcoded list of messages with correct styling?

### Step 3: Build the Input Area
Build the message input component:
- Text input (textarea for multi-line support)
- Enter to send the message
- Shift+Enter for a new line
- Disable the input while the agent is responding
- Send button as an alternative to Enter

Checkpoint: Does the input capture text correctly and disable during processing?

### Step 4: Connect WebSocket
Connect the frontend to the backend WebSocket endpoint:
- Establish WebSocket connection on page load
- Send user messages over the WebSocket
- Handle incoming message types from the protocol:
  - `token` -- append to the current assistant message
  - `tool_call` -- optionally show a tool indicator
  - `response_complete` -- finalize the message, re-enable input
  - `error` -- show an error message to the user
- Accumulate streaming tokens into the displayed message in real time

Handle connection failures: show a reconnecting indicator, attempt to reconnect with backoff.

Checkpoint: Can they send a message and see the streaming response appear token by token?

### Step 5: Add Conversation Management
Build a sidebar with conversation management:
- List of existing threads (fetched via REST from the backend)
- Button to create a new conversation
- Click a thread to load its history and switch to it
- Active thread is highlighted
- Thread titles (can use first message or a generated name)

Wire up thread selection: when a thread is selected, load its messages from the backend and display them.

Checkpoint: Can they create a new conversation, switch between threads, and see the correct history?

### Step 6: Polish the UI
Add production-quality UX details:
- Loading indicator (spinner or dots) while waiting for the first token
- Error states with clear messages and retry options
- Responsive design -- works on both desktop and mobile viewports
- Clean typography and spacing
- Code block rendering with syntax highlighting in assistant messages

Checkpoint: Does the UI feel polished? Are error states and loading states handled?

### Step 7: Test End-to-End
Full flow test:
1. Start the backend and frontend
2. Create a new conversation
3. Send a message and see the streaming response
4. Send follow-up messages (verify conversation context is maintained)
5. Create another conversation, switch between them
6. Test error scenarios: stop the backend, send a message, verify the error state
7. Restart the backend, verify reconnection works
