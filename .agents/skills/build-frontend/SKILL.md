---
name: build-frontend
description: Guides building a Next.js chat frontend connected to a FastAPI backend via WebSocket streaming. Use after the FastAPI backend with WebSocket streaming is complete.
compatibility: Requires Node.js and npm
---

# Skill: Build a Frontend Chat UI

## What This Skill Does
Guides the learner through building a Next.js chat frontend that connects to their FastAPI backend.

## When to Use
After the FastAPI backend with WebSocket streaming is complete.

## Prerequisites
- FastAPI backend running with WebSocket endpoint
- Basic familiarity with React/Next.js (or willingness to learn with agent help)

## Context to Load
- `concepts/production/frontend-chat-ui.md`
- `concepts/production/websocket-streaming.md`
- `learner/profile.md` (frontend experience level)
- `learner/project.md`

---

## Process

### Step 1: Set Up Next.js Project
Use web search for current Next.js setup (latest stable version).
Initialize the project in `projects/[project-name]/frontend/`.
Install dependencies.

Adapt to learner's frontend experience — if they're new to React, explain components and state briefly.

### Step 2: Build the Message Display
Create a message list component:
- Renders user and assistant messages differently
- Scrolls to bottom on new messages
- Handles markdown rendering (install a markdown library)

Start with hardcoded messages to verify the display works.

**Checkpoint:** Does the message list render correctly with different message types?

### Step 3: Build the Input Area
Text input with send button.
Handle Enter to send, Shift+Enter for new line.
Disable input while the agent is responding.

### Step 4: Connect WebSocket
Implement WebSocket connection to the backend.
Handle different message types (token, tool_call, response_complete, error).
Accumulate streaming tokens into the current assistant message.

**Checkpoint:** Can they send a message and see the response stream in?

### Step 5: Add Conversation Management
Sidebar with thread list.
New conversation button.
Thread selection loads messages from the API.
Auto-generate thread titles.

### Step 6: Polish the UI
- Loading indicators during streaming
- Error state handling (connection lost, API error)
- Responsive design (works on mobile)
- Clean, modern styling

### Step 7: Test End-to-End
Full flow: open app, start conversation, send messages, see streaming responses, switch between threads, create new conversations.

---

## When Done
- Working Next.js chat frontend connected to the API
- Streaming display, conversation management, clean UI
- Code saved in `projects/`
- Update `learner/progress.md`: mark frontend complete
