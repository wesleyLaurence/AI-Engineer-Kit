# Agent Skills and AGENTS.md

## The Problem: Agents Without Direction Are Useless

A powerful LLM with tool access but no context about your project is like hiring a brilliant contractor and not telling them what you're building. They have the skills, but they don't know what to do with them.

Agent skills and AGENTS.md files solve this by giving agents structured context about how to behave, what to do, and how to do it. They're the operating instructions that turn a general-purpose agent into a specialist for your specific use case.

---

## What AGENTS.md Is

AGENTS.md is a file at the root of a repository (or project) that tells coding agents how to work with the codebase. It's the agent's orientation document — the first thing it reads to understand the project.

### What Belongs in AGENTS.md

**Project context** — What this project is, what it does, who it's for. The high-level understanding that shapes every decision the agent makes.

**Conventions and rules** — Coding standards, architectural patterns, naming conventions, file organization. How things are done in this project.

**Workflow guidance** — How to test, how to deploy, how to handle common tasks. The operational procedures the agent should follow.

**Boundaries** — What the agent should not do. Files it shouldn't modify, actions it shouldn't take, areas where it should defer to a human.

### Why It Works

Coding agents read AGENTS.md automatically. When a user opens their project in Claude Code, Cursor, or Codex, the agent reads this file and gains immediate context about the project. No warmup conversation needed — the agent knows the rules from the start.

---

## What Agent Skills Are

A skill is a packaged capability — a set of instructions that guides an agent through a specific task. Skills combine knowledge (what to do) with process (how to do it) into a reusable unit.

### The Anatomy of a Skill

A good skill contains:

**Purpose** — What this skill does and when to use it.

**Prerequisites** — What must be true before this skill is useful. Other skills that should be completed first, files that should exist, tools that should be configured.

**Context to load** — Which files, documents, or resources the agent should read before starting. This is how skills leverage the knowledge in concept files, wisdom files, and other resources.

**Step-by-step process** — The sequence of actions to perform. Not rigid code — more like a guide that the agent adapts to the specific situation.

**Checkpoints** — Points where the agent should verify that things are working, check with the user, or confirm understanding before proceeding.

**Completion criteria** — How to know when the skill is done. What should be true, what should exist, what state should be updated.

### Skills vs. Scripts

Scripts execute mechanically — the same inputs always produce the same outputs. Skills guide intelligently — the agent adapts the process to the current situation, the user's needs, and what already exists.

A setup script installs dependencies. A setup skill explains what's being installed and why, adapts to the user's operating system and preferences, handles errors intelligently, and leaves the user understanding what happened.

---

## How Skills and AGENTS.md Work Together

AGENTS.md is the master document — it defines the overall behavior, conventions, and workflow for the project. Skills are specialized capabilities that the agent can invoke for specific tasks.

Think of AGENTS.md as the job description and skills as the specific procedures for handling different tasks.

### In This Repo

You're experiencing this system right now. The AI Engineer Kit uses:

- **AGENTS.md** — The teaching manual that defines how the agent teaches, the curriculum structure, how to adapt to learners, and the learner directory protocol
- **Concept files** — The knowledge the agent uses when teaching topics
- **Wisdom files** — The experiential knowledge the agent weaves into teaching
- **Skill files** — The guided processes for onboarding, builds, reviews, and exercises

The agent reads AGENTS.md to understand its role as a teacher. When it's time to teach a concept, it reads the relevant concept and wisdom files. When it's time to build something, it reads the relevant skill file. Everything works together.

---

## Context Engineering at the Repo Level

Skills and AGENTS.md are a form of context engineering — deliberately designing what information the agent receives to shape its behavior.

### The Principle

The model can only reason about what's in its context. By carefully curating what files the agent reads and in what order, you control the quality of its output. This is why:

- Concept files are separate from skills (load only what's needed)
- Wisdom files are organized by topic (load relevant wisdom, not all wisdom)
- AGENTS.md is comprehensive but structured (the agent finds what it needs quickly)
- Skills specify which files to load (focused context for each task)

### Designing for Agent Consumption

Files intended for agents should be:

- **Clear and unambiguous** — Agents follow instructions literally
- **Well-structured** — Headers and sections help agents find relevant parts
- **Explicit about priorities** — Put the most important information first
- **Specific about boundaries** — State what the agent should and shouldn't do

---

## Key Takeaways

- AGENTS.md gives coding agents project-specific context and rules — it's the first file they read
- Skills package knowledge and process into reusable, guided capabilities
- Skills guide intelligently (adapting to context) rather than executing mechanically (like scripts)
- AGENTS.md defines overall behavior; skills handle specific tasks
- Context engineering — deliberately curating what the agent sees — is what makes the system work
- This repo is itself an example of skills and AGENTS.md working together to create a teaching experience
