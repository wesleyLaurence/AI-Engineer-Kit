---
name: frontend-chat-ui
description: Teaches building a chat frontend with Next.js -- message display, streaming output, input handling, and conversation management. Use when the learner asks about building a UI for their agent, chat interfaces, or connecting a frontend to their API.
---

# Topic: Frontend Chat UI

## When to Use
- Phase 4, after websocket-streaming
- Learner asks about building a frontend, chat UI, or user interface for their agent
- Learner asks about Next.js, React, or frontend development for AI applications
- Learner wants to give their agent a real user interface

## Prerequisites
- `websocket-streaming` topic complete (robust WebSocket endpoint ready)
- FastAPI backend running with chat and thread management endpoints
- No frontend experience required -- this is taught from scratch

## Concept References
- `references/frontend-chat-ui.md` -- read this before teaching

---

## Teaching Flow

### Open with the Problem
Start with the gap: "Your agent has an API. You can talk to it with curl. But curl is not a product. Users expect a chat interface -- a text box, a message history, streaming responses appearing word by word, a sidebar to manage conversations. That is what ChatGPT looks like, and that is what we are building today. Even if you have never written frontend code before, you will have a working chat UI by the end of this session."

### Core Points to Cover

**Why a frontend matters:**
- The API is the engine, the frontend is the car. Users interact with the car, not the engine.
- A chat UI is the most natural interface for an AI agent
- Building it yourself teaches you how the entire stack fits together -- frontend, API, agent
- This is what turns a project into a product

**Why Next.js:**
- React-based framework -- the dominant approach for modern web applications
- Built-in routing, server-side rendering, and deployment support
- Large ecosystem of components and libraries
- Works well with Amplify for deployment later
- Even if the learner is primarily a backend developer, Next.js is approachable

**Core UI components:**
- **Message list** -- displays the conversation. Each message has a role (user or assistant), content, and timestamp. Assistant messages render markdown.
- **Input area** -- text input with Enter to send and Shift+Enter for new lines. Disabled while the agent is responding.
- **Streaming display** -- as tokens arrive over WebSocket, they are appended to the current assistant message in real time.
- **Conversation sidebar** -- list of threads, ability to create new conversations, switch between threads.

**Connecting to the backend:**
- WebSocket connection for chat (streaming tokens)
- REST calls for thread management (create, list, delete)
- Handle the message protocol defined in the WebSocket streaming topic
- Accumulate tokens into a complete message for display

**UX considerations:**
- Auto-scroll to the bottom as new tokens arrive, but stop auto-scrolling if the user scrolls up
- Loading indicators while waiting for the first token
- Error states -- show a clear message if the connection drops or the agent errors
- Responsive design -- works on desktop and mobile

### Close
Transition to the build: "Let's build it. We will start with a basic message display, add the input, connect the WebSocket, and then add conversation management. By the end, you will have a real chat UI talking to your agent."

---

## Adaptive Notes

**Experienced developers:** If they know React/Next.js, focus on the AI-specific patterns: WebSocket integration, streaming token display, message protocol handling. The build should be efficient -- 45-60 minutes.

**Beginners:** This may be their first frontend code. Spend time on the basics: components, state, rendering. Use the framework to generate scaffolding. Lean on the AI tutor to explain React concepts as they come up. Build will take 90-120 minutes.

**Returning learners (review mode):** Focus on UX polish: markdown rendering, code block highlighting, responsive design, accessibility. Review their existing UI against production chat applications.

---

## Build

Build a Next.js chat frontend connected to their FastAPI backend.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Set up Next.js project
2. Build the message display component
3. Build the input area
4. Connect WebSocket for streaming
5. Add conversation management (sidebar, thread switching)
6. Polish the UI (loading states, error handling, responsive design)
7. Test end-to-end

---

## Understanding Checks
- Can the learner explain how the frontend connects to the backend (WebSocket for chat, REST for threads)?
- Can they describe the message protocol and how streaming tokens are rendered?
- Can they explain the component structure of their chat UI?
- Is the frontend working end-to-end with their API?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Working chat UI with message display, input area, and streaming responses
- Conversation management (sidebar with thread list, new conversation, thread switching)
- Connected to their FastAPI backend via WebSocket and REST
- Error states and loading indicators implemented
- Code saved in `projects/`
- Mark "Frontend Chat UI" complete in `learner/progress.md`
- Add observations about their frontend development experience to `learner/notes.md`
- Proceed to `authentication`
