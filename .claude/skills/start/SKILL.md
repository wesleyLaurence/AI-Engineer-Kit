---
name: start
description: First-run onboarding for new learners. Creates the learner/ directory with personalized profile, progress, project, and notes files. Use when learner/profile.md does not exist.
---

# Skill: Start (Onboarding)

## When to Use
When `learner/profile.md` does not exist. This is the first-run experience.

**Important:** The `learner/` directory is gitignored. Always check for it using a direct file read, never search or glob tools.

## Prerequisites
None — this is where everything begins.

## Context to Load
- `AGENTS.md` (teaching philosophy and curriculum index)
- `../coding-agents/references/coding-agents.md` (for Phase 0 topic)

---

## Process

### Step 1: Introduce the Paradigm
Welcome the learner. Explain what this is:
- "I'm your AI engineering instructor."
- This is interactive — learn by discussing and building
- The repo has the full curriculum, I'll guide you through it
- Ask me anything, anytime
- By the end, you'll build and deploy a complete AI application

Keep it warm but concise. Don't overwhelm with details about the repo structure yet.

### Step 2: Learn About the Learner
Ask about (in natural conversation, not as a checklist):
- Name
- Programming background (languages, years, role)
- AI/ML experience (used ChatGPT? Built with APIs? Understand ML concepts?)
- Development environment (editor, OS, terminal comfort)
- Learning style preferences (deep explanations vs. fast progress? Hands-on vs. conceptual?)

**Checkpoint:** Do you have enough to create a useful profile?

### Step 3: Understand Their Goals
- What do they want to build? (Specific idea or guided project?)
- What's motivating them? (Career, product, curiosity?)
- Timeline? (Casual or goal-oriented?)
- Any specific areas of interest? (Agents? RAG? Production deployment?)

### Step 4: Create the Learner Directory
Create `learner/` with four files. Use YAML frontmatter (title, type, created, updated) on each.

**profile.md** — Who the learner is. Include:
- Background (name, experience level, languages, role)
- AI/ML experience (what they've used and built)
- Learning style (pace, depth preference, what works for them)
- Goals (short-term, long-term, career motivation)
- Notes (initial observations about what will help them learn)

**progress.md** — The living curriculum tracker. Include:
- Current phase and topic
- Last session date
- The full curriculum with checkboxes (`- [x]` completed, `- [ ]` remaining):

  Phase 0: Orientation
  - How This Learning Experience Works
  - Working with Coding Agents Effectively

  Phase 1: Foundations
  - Python for AI Engineering
  - Environment Setup
  - Foundation Models
  - Your First LLM Call

  Phase 2: Core Skills
  - Prompt Engineering
  - Threads and Conversation Memory
  - Streaming
  - Tool Calling
  - RAG

  Phase 3: Agent Architecture
  - Agentic Workflows
  - ReAct Agents
  - MCP Servers
  - Agent Skills and AGENTS.md
  - Context Engineering
  - Human in the Loop
  - Subagents and Multi-Agent Systems
  - Deep Agents

  Phase 4: Production
  - FastAPI Backend
  - WebSocket Streaming
  - Next.js Frontend
  - Authentication
  - Database and Persistence
  - AWS Deployment
  - Usage Tracking and Payments
  - Evaluation, Tracing, and Monitoring
  - Security and Guardrails
  - Cost Optimization

- Customize: if they're experienced, mark known topics as checked with a note (e.g., `*experienced, skip*`). If they have a specific project, mark irrelevant topics as brief overviews.
- Milestones table with status and dates
- Focus areas based on their goals

**project.md** — What they're building. Include:
- Project overview (name, type, description)
- Architecture decisions (starts mostly empty, grows over time)
- Current state (what's working, in progress, not started)
- Goals for the project

**notes.md** — Everything else. Include:
- Session-specific observations
- Things to revisit in future sessions
- Preferences discovered during onboarding
- Ideas for their project

### Step 5: Orient Them
Briefly explain:
- The repo has reference files they can browse (in each skill's `references/` folder)
- Skills guide them through builds
- Their code will live in `projects/`
- They can check their progress in `learner/progress.md` anytime
- Show them their personalized learning path

### Step 6: Begin Phase 0
Route into the `learning-experience` skill, then the `coding-agents` skill.
These cover the first two topics: how this learning experience works, and how to work effectively with a coding agent.

---

## When Done
- `learner/` directory exists with all four files
- Learner understands the paradigm
- Phase 0 topics are in progress or complete
- Update `learner/progress.md` with any completed topics
