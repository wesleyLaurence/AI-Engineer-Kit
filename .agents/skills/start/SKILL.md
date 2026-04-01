---
name: start
description: First-run onboarding for new learners. Creates the learner/ directory with personalized profile, progress, project, and notes files. Use when learner/profile.md does not exist.
compatibility: Designed for Claude Code (or similar products)
---

# Skill: Start (Onboarding)

## What This Skill Does
Guides a new learner through their first session. Creates the `learner/` directory with personalized files. Sets the foundation for the entire learning experience.

## When to Use
When `learner/profile.md` does not exist. This is the first-run experience.

## Prerequisites
None — this is where everything begins.

## Context to Load
- `AGENTS.md` (teaching philosophy and curriculum overview)
- `concepts/foundations/coding-agents.md` (for Phase 0 topic)

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
Create `learner/` with four files:

**profile.md** — Based on everything gathered. Include background, learning style, goals, and any initial notes.

**progress.md** — The full curriculum with checkboxes. Customize based on their goals:
- If they have a specific project, mark irrelevant topics as "brief overview"
- If they're experienced, mark topics they already know as skippable (but verify later)
- If they want the guided project, use the full default curriculum

**project.md** — Their chosen project (or "guided portfolio project" with a brief description). Architecture decisions and state sections start mostly empty.

**notes.md** — Initial observations about the learner.

### Step 5: Orient Them
Briefly explain:
- The repo has concept files they can browse (in `concepts/`)
- Skills guide them through builds
- Their code will live in `projects/`
- They can check their progress in `learner/progress.md` anytime
- Show them their personalized learning path

### Step 6: Begin Phase 0
Start the first topic: how to work effectively with a coding agent.
Read `concepts/foundations/coding-agents.md` for context.
Teach interactively — this is meta because they're learning it by doing it.

---

## When Done
- `learner/` directory exists with all four files
- Learner understands the paradigm
- Phase 0 first topic is in progress or complete
- Update `learner/progress.md` with any completed topics
