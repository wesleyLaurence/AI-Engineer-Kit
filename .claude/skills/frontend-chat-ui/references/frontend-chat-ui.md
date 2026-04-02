# Frontend Chat UI

## The Problem: Your Agent Needs a Face

A FastAPI backend with WebSocket streaming is useless without a frontend that humans can actually interact with. The chat UI is where your users experience your product. It's the difference between a technical demo and something people actually want to use.

---

## Why Next.js

Next.js (React-based) is the standard for modern web frontends:
- **React component model** — Build UIs from composable pieces
- **Server-side rendering** — Better performance and SEO
- **API routes** — Can proxy requests to your backend
- **Strong ecosystem** — Libraries for everything you need
- **Deployment** — Deploys easily to Amplify, Vercel, and other platforms

---

## The Anatomy of a Chat UI

### Message List
The scrollable area showing the conversation. Each message has a role indicator (user or assistant), the message content (rendered markdown, code blocks), timestamps, and status indicators.

### Input Area
Where the user types their message: text input with auto-resize, send button, loading/streaming indicator, and optionally file upload or model selection.

### Sidebar (Conversation Management)
List of past conversations, new conversation button, thread titles, and search across conversations.

### Streaming Display
Tokens arrive one at a time and need smooth display: append each token, scroll to bottom, show a typing indicator during streaming, and render markdown progressively.

---

## Handling Streaming Data

### From WebSocket to Display

1. WebSocket receives a token message
2. Append the token to a buffer (the current assistant message)
3. Re-render the message display
4. Repeat until response_complete message

### Tool Call Visualization

When the agent calls a tool, show it: "Searching the web..." with a loading indicator, then the tool result summary when complete. This makes the agent's work visible and builds user trust.

---

## Chat Widgets

Beyond plain text, a modern chat UI supports:
- **Code blocks** — Syntax-highlighted with copy button
- **Data visualization** — Charts, tables, graphs from structured data
- **Interactive elements** — Quick-reply buttons, forms, toggleable sections
- **File previews** — Images, PDFs, and other content inline

---

## The Production Gap

| Demo | Production |
|---|---|
| Messages disappear on refresh | Messages persist in database |
| No authentication | Full auth with session management |
| Single conversation | Multiple threads with navigation |
| Raw text display | Markdown rendering with code highlighting |
| No error handling | Graceful degradation, reconnection |
| Desktop only | Responsive across devices |

---

## Key Takeaways

- The chat UI is where users experience your product — invest in quality
- Streaming display is the most technically challenging part: progressive rendering, smooth scrolling
- Show tool calls and agent activity — transparency builds trust
- Support rich content: code blocks, data visualization, interactive elements
- The gap between a demo and production chat UI is large — plan for auth, persistence, error handling, and responsive design
