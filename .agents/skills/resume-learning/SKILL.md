---
name: resume-learning
description: Use when running or resuming an AI Engineer Kit learning session, deciding the learner's next topic from learner/ files, reviewing a prior topic, or routing to the correct teaching or build skill.
---

# Resume Learning Session

## When to Use
- Any returning session (learner/profile.md exists)
- User says "continue", "what's next", "pick up where we left off", or similar
- User opens the repo and wants to learn

Do NOT use for first-run onboarding — use the `start` skill when learner/profile.md does not exist.

## Process

### Step 1: Load Learner State
Read all four files directly (do not use search or glob — `learner/` is gitignored):
1. `learner/profile.md`
2. `learner/progress.md`
3. `learner/project.md`
4. `learner/notes.md`

### Step 2: Determine Session Mode
Based on the learner state, decide the session mode:

**Continue curriculum** — The default. The learner is mid-curriculum and ready for the next topic.
- Identify the current topic from `progress.md`
- Activate that topic's skill

**Review a prior topic** — The learner explicitly asks to revisit something they've completed.
- Activate the requested topic's skill in review mode
- Do NOT load skills for other completed topics

**Build or debug** — The learner is working on their project and needs help with a specific area.
- Activate the relevant topic skill in build or debug mode
- Focus on the project need, not on re-teaching

**Catch up after a break** — The learner is returning after a long gap.
- Offer a recap of where they are and what they've built
- Check if anything has changed (goals, project direction)
- Then route to the current topic

### Step 3: Welcome Back
Reference where they left off and what they were working on. Keep it brief and warm.

"Last time we finished [topic]. Ready to move on to [next topic], or do you want to revisit anything?"

### Step 4: Activate the Right Topic Skill
Route to the appropriate topic skill based on the session mode. The topic skill contains the full lesson plan.

**Non-loading rules — do not load topic skills for:**
- Topics already marked complete (unless the user explicitly asks to review them)
- Topics from earlier phases (unless the current request is about that exact topic)
- Beginner-phase concept-teaching guidance when the learner is advanced
- Build/debug references from earlier topics unless the user is debugging or revisiting

The curriculum remains available but is not ambient context. Only the active topic's skill should be loaded.

### Step 5: End-of-Session Updates
At the end of the session or when a topic is completed:
1. Update `learner/progress.md` — mark completed topics, update current position
2. Update `learner/notes.md` — observations, things to revisit, preferences discovered
3. Update `learner/project.md` — if architecture decisions were made or project state changed
4. Update `learner/profile.md` — if you learned something new about the learner

## Curriculum Map (for routing)

### Phase 0: Orientation
- `learning-experience` — How this learning experience works
- `coding-agents` — Working with coding agents effectively

### Phase 1: Foundations
- `python-for-ai` — Python for AI Engineering
- `environment-setup` — Environment Setup
- `foundation-models` — Foundation Models
- `first-llm-call` — Your First LLM Call

### Phase 2: Core Skills
- `prompt-engineering` — Prompt Engineering
- `memory-and-threads` — Threads and Conversation Memory
- `streaming` — Streaming
- `tool-calling` — Tool Calling
- `rag` — RAG (Retrieval Augmented Generation)

### Phase 3: Agent Architecture
- `agentic-workflows` — Agentic Workflows
- `react-agents` — ReAct Agents
- `mcp-servers` — MCP Servers
- `agent-skills` — Agent Skills and AGENTS.md
- `context-engineering` — Context Engineering
- `human-in-the-loop` — Human in the Loop
- `subagents` — Subagents and Multi-Agent Systems
- `deep-agents` — Deep Agents

### Phase 4: Production
- `fastapi-backend` — FastAPI Backend
- `websocket-streaming` — WebSocket Streaming
- `frontend-chat-ui` — Next.js Frontend
- `authentication` — Authentication
- `database-persistence` — Database and Persistence
- `aws-deployment` — AWS Deployment
- `usage-tracking-payments` — Usage Tracking and Payments
- `evaluation-monitoring` — Evaluation, Tracing, and Monitoring
- `security-guardrails` — Security and Guardrails
- `cost-optimization` — Cost Optimization

## Utility Skills (available anytime)
- `review-agent` — Review agent code quality
- `review-security` — Security review before deployment
