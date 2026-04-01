# AI Engineer Kit

**Clone the repo. Open it in your coding agent. Say "teach me AI engineering."**

The AI Engineer Kit is an open-source, agent-powered learning system. It's not a course — it's a living knowledge base that transforms your coding agent into a personal AI engineering instructor.

You clone this repo, open it in Claude Code, Cursor, or Codex, and the agent guides you through a structured curriculum from fundamentals to production. It adapts to your experience level, answers your questions, and helps you build real projects along the way.

By the end, you'll have built and deployed a complete AI application — and you'll understand every piece of it.

---

## Quick Start

### 1. Clone the repo

```bash
git clone https://github.com/anthropics/ai-engineer-kit.git
cd ai-engineer-kit
```

### 2. Open it in your coding agent

**Claude Code (recommended)**
```bash
claude
```

**Cursor**
Open the folder in Cursor. The agent will read the AGENTS.md file automatically.

**Codex**
```bash
codex
```

### 3. Start learning

Say something like:
- "Teach me AI engineering"
- "I want to learn how to build AI agents"
- "Help me build a [your project idea]"

The agent handles the rest — it introduces itself, learns about your background, creates a personalized learning path, and starts teaching.

---

## How It Works

The repo contains three layers of knowledge:

| Layer | What It Is | Purpose |
|---|---|---|
| **Concepts** | Mental models, architecture, decision frameworks | Understand how and why things work |
| **Wisdom** | Hard-won lessons from production AI systems | Know the gotchas before they bite you |
| **Skills** | Guided build experiences | Turn understanding into working software |

The agent reads **AGENTS.md** — the master teaching manual — which tells it how to teach, what the curriculum covers, and how to adapt to different learners. Then it uses the concept files, wisdom, and skills to guide you through an interactive learning experience.

### The Learn-Build Rhythm

1. The agent teaches you a concept — interactively, adapted to your level
2. You discuss it, ask questions, make sure you understand
3. The agent guides you through building something that applies the concept
4. You move to the next concept, building on everything before it
5. Repeat until you've built a complete, deployed AI application

### What Makes This Different

- **Ask the agent.** Don't Google it. Your agent has the full curriculum as context and knows exactly where you are in the learning path.
- **No stale code.** Concept files teach architecture and mental models. When it's time to build, the agent pulls the latest docs via web search.
- **It meets you where you are.** A senior backend engineer and a first-time coder get completely different experiences from the same repo.
- **Learn and build in the same place.** The repo is both the classroom and the workshop.

---

## The Curriculum

### Phase 0: Orientation
How this learning experience works. How to work effectively with coding agents.

### Phase 1: Foundations
Python for AI engineering. Environment setup. Foundation models. Your first LLM API call.

### Phase 2: Core Skills
Prompt engineering. Conversation memory. Streaming. Tool calling. RAG (retrieval augmented generation).

### Phase 3: Agent Architecture
Agentic workflows. ReAct agents. MCP servers. Agent skills. Context engineering. Human-in-the-loop. Subagents. Deep agents.

### Phase 4: Production
FastAPI backend. WebSocket streaming. Next.js frontend. Authentication. Database. AWS deployment. Usage tracking and payments. Evaluation and monitoring. Security. Cost optimization.

---

## Repo Structure

```
ai-engineer-kit/
├── AGENTS.md              # Master teaching manual (for the agent)
├── README.md              # You are here
├── CONTRIBUTING.md        # How to contribute
│
├── concepts/              # Layer 1: Mental models and architecture
│   ├── foundations/       #   Setup, models, first API calls
│   ├── core/              #   Prompts, memory, streaming, tools, RAG
│   ├── agents/            #   Agent patterns and architecture
│   └── production/        #   Deployment, auth, payments, monitoring
│
├── wisdom/                # Layer 2: Hard-won experiential knowledge
│
├── skills/                # Layer 3: Guided build experiences
│
├── resources/             # Curated external learning resources
│
├── learner/               # (gitignored) Your profile, progress, notes
└── projects/              # (gitignored) Your code and experiments
```

The **core files** (concepts, wisdom, skills, AGENTS.md) are maintained and updated via git. The **learner/** and **projects/** directories are gitignored — they exist only on your machine. This means you can `git pull` to get new content without ever touching your personal state.

---

## Your Progress is Yours

When you start, the agent creates a `learner/` directory with your profile, learning progress, project details, and session notes. This is the agent's memory of you — it reads these files at the start of every session so it always knows where you left off.

These files are plain markdown on your machine. You can read them, edit them, or delete them to start fresh.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute wisdom, concept improvements, new skills, and resources.

---

## License

MIT
