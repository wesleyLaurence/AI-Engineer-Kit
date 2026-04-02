---
name: python-for-ai
description: Teaches the Python concepts specific to AI engineering — virtual environments, dependency management, async patterns, type hints, and working with APIs. Not Python 101. Adapts heavily to the learner's background.
---

# Skill: Python for AI Engineering

## What This Skill Does
Teaches the specific Python concepts and patterns needed for AI engineering work. This is not a general Python tutorial — it covers the subset that matters: virtual environments, dependency management, async/await, type hints, HTTP APIs, and Pydantic.

## When to Use
During Phase 1, after environment setup is complete (or alongside it if the learner needs the conceptual grounding first).

## Prerequisites
- `learner/profile.md` exists (need to know their Python background)
- Basic programming experience in any language

## Concept References
- `references/python-for-ai.md` — the core reference for this topic
- `wisdom/common-pitfalls.md` — environment setup section (venv mistakes, API keys in code)

---

## Teaching Flow

### Open with the Problem
Don't start with "let's learn Python." Start with: "Every AI application you'll build involves making API calls, managing dependencies, handling async operations, and working with typed data structures. Let me make sure you're set up with the Python patterns that matter for this work."

### Step 1: Gauge Their Level
Read `learner/profile.md` carefully. Ask a few calibration questions:
- Have they used virtual environments before?
- Are they comfortable with async/await in any language?
- Have they made HTTP API calls from code before?
- Do they know what type hints are?

**If they're already proficient in Python:** Spend 5 minutes confirming they know venvs, async, and HTTP requests. Point them to `references/python-for-ai.md` for reference on Pydantic and AI-specific patterns. Mark complete and move on.

**If they know another language well:** Focus on Python-specific idioms. They'll pick up syntax quickly — teach the patterns.

**If they're newer to programming:** Go slower, use more examples, but still focus on AI-relevant patterns rather than general Python.

### Step 2: Virtual Environments and Dependencies
Cover using `references/python-for-ai.md`:
- What virtual environments are and why they're non-negotiable
- venv vs. conda (recommend venv for most cases)
- The workflow: create, activate, install, track with requirements.txt
- Reference the pitfalls from `wisdom/common-pitfalls.md` (forgetting to activate, packages going to system Python)

This is the most important foundational concept. Don't rush it.

### Step 3: Async/Await Patterns
Explain using the concept file:
- Why AI work is I/O-bound (waiting for API responses)
- Sync vs. async — the practical difference
- async def, await, asyncio basics
- When it matters: multiple LLM calls, web servers (FastAPI), streaming

Use a concrete example: making three LLM calls sequentially vs. concurrently. The time difference makes the concept click.

### Step 4: Working with HTTP APIs
Cover:
- The request-response pattern (POST with JSON, get JSON back)
- requests vs. httpx (recommend httpx for async support)
- Why understanding HTTP matters even when using SDKs
- This connects directly to the model-apis concept they'll learn soon

### Step 5: Type Hints and Pydantic
Cover:
- Type hints — what they are, why they matter for AI frameworks
- Pydantic models — validation, serialization, used everywhere in AI tooling
- FastAPI, LangChain, and OpenAI SDK all use Pydantic extensively
- This is a "learn now, use constantly later" concept

### Step 6: Environment Variables and .env Files
Cover:
- Why secrets must never be in code
- The .env file pattern with python-dotenv
- .gitignore for .env files
- Production will use secrets managers, but .env is the local development standard

---

## Adaptive Notes

**Experienced Python developer:** Confirm venvs, async, and HTTP. Point to Pydantic if they haven't used it. Total time: 5-10 minutes.

**Experienced in another language:** Focus on Python-specific patterns (venvs, pip, async syntax). They'll transfer their existing knowledge. Total time: 20-30 minutes.

**Newer programmer:** Go through each section with more examples. Have them actually create a venv, install a package, write a small async function. Total time: 45-60 minutes.

---

## Understanding Checks
See `references/checks.md` for detailed check questions.

Key checks:
- Can they create and activate a virtual environment?
- Do they understand async/await and when to use it?
- Are they comfortable making HTTP requests from Python?
- Do they know what Pydantic is and why it matters?

---

## When Done
- Learner is comfortable with the Python patterns needed for AI engineering
- They know where to find the concept file for reference
- Update `learner/progress.md` — mark "Python for AI" complete
- Update `learner/notes.md` — record their Python comfort level and any areas to reinforce later
