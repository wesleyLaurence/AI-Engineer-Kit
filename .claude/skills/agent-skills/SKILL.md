---
name: agent-skills
description: Teaches how to package agent capabilities as reusable skills, how AGENTS.md files guide agent behavior, and context engineering at the repo level. Use when the learner asks about agent skills, AGENTS.md, or how to structure repos for AI agents.
---

# Topic: Agent Skills and Repo-Level Context Engineering

## When to Use
- Phase 3, after MCP servers
- Learner asks about AGENTS.md, agent skills, or repo-level configuration for agents
- Learner asks how this very curriculum works under the hood

## Prerequisites
- `react-agents` topic complete (they understand agents)
- `mcp-servers` topic complete (they understand tool packaging)

## Concept References
- `references/agent-skills.md` -- read this before teaching

---

## Teaching Flow

### Open with the Problem
This one is beautifully meta. Start with: "You have been learning from an AI agent that uses skills, follows AGENTS.md instructions, and loads context from files in this repo. Have you wondered how that actually works? That is today's topic -- and you are the proof that it works."

Point out what they have been experiencing: the agent reads their profile, adapts to their level, follows a curriculum, loads concept files, tracks progress. All of that is context engineering at the repo level.

### Core Points to Cover

**What agent skills are:**
- A packaged unit of capability -- instructions, context, and process that an agent can follow
- Not code libraries. Skills are prompts, references, and workflows that shape agent behavior.
- The skill files in this repo (the `.agents/skills/` directory) are the living example

**How AGENTS.md works:**
- Walk through the actual AGENTS.md in this repo
- It is the entry point -- the first thing an agent reads to understand the repo
- It routes to skills, sets behavioral guidelines, establishes context
- This is a convention that is becoming standard across agent-enabled repos

**The components of a skill:**
- Frontmatter (name, description, trigger conditions)
- Prerequisites and concept references
- Teaching flow or process steps
- Adaptive notes for different contexts
- Understanding checks

**Context engineering at the repo level:**
- The repo structure IS the context strategy
- What files exist, how they are organized, what the agent is told to read -- all of this shapes behavior
- Compare this to prompt engineering: prompt engineering is for a single call, context engineering is for an entire workflow

**Why this matters:**
- As agents become more capable, the ability to structure a repo so agents can work effectively becomes a core engineering skill
- This is not just about AI tutors -- production agents need the same patterns: clear instructions, scoped context, well-defined capabilities

### Close
"You now understand the system you have been learning inside. Every skill you have worked through, every adaptive adjustment, every progress check -- it is all repo-level context engineering. And the fact that it worked for you is the best proof of the concept."

---

## Adaptive Notes

**Experienced developers:** They will immediately see the parallels to documentation-driven development and configuration-as-code. Focus on the design principles -- why skills are structured this way, how context is scoped. 15-20 minutes.

**Beginners:** Walk through the actual files more slowly. Open the AGENTS.md, open a SKILL.md, show them the structure. The meta-awareness is valuable but can be abstract -- make it concrete by pointing at real files. 25-35 minutes.

**Returning learners (review mode):** Ask them to evaluate the skill structure. What works? What would they change? This is a great exercise in understanding context engineering tradeoffs.

---

## Understanding Checks
- Can the learner explain how AGENTS.md guides agent behavior in a repo?
- Can they describe the components of a skill file and why each exists?
- Can they explain how this very learning experience uses skills and context engineering?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Agent Skills" complete in `learner/progress.md`
- Add observations about their understanding of meta-level patterns to `learner/notes.md`
- Proceed to `context-engineering`
