---
name: setup-env
description: Configures the learner's development environment for AI engineering. Sets up Python, virtual environment, core dependencies, and API keys. Use during Phase 1 after learner profile is established.
compatibility: Requires Python 3.10+ and pip
---

# Skill: Environment Setup

## What This Skill Does
Gets the learner's development environment fully configured for AI engineering work.

## When to Use
During Phase 1, after the learner profile is established.

## Prerequisites
- `learner/profile.md` exists
- Learner has Python installed (or help them install it)

## Context to Load
- `concepts/foundations/python-for-ai.md`
- `wisdom/common-pitfalls.md` (environment setup section)
- `learner/profile.md` (to adapt to their OS and experience)

---

## Process

### Step 1: Verify Python
Check that Python 3.10+ is installed. Help install if needed.
Explain briefly why version matters for AI libraries.

### Step 2: Create Virtual Environment
Guide them through creating a venv in the `projects/` directory.
Explain what virtual environments are and why they're essential.
Make sure they understand how to activate/deactivate.

**Checkpoint:** Can they activate the environment and verify which Python is active?

### Step 3: Install Core Dependencies
Create a `requirements.txt` with essentials:
- openai (or anthropic, based on their preference)
- langchain and langchain-community
- python-dotenv
- httpx

Use web search for the latest versions. Install with pip.

**Checkpoint:** Can they import the packages without errors?

### Step 4: API Key Setup
Help them get API keys from their chosen provider (OpenAI and/or Anthropic).
Create a `.env` file in `projects/`.
Add `.env` to `.gitignore` if they're using git.
Show them how to load keys with python-dotenv.

**Warning:** Emphasize that API keys must NEVER be in code or git. Reference wisdom about this common pitfall.

**Checkpoint:** Can they load their API key in a Python script?

### Step 5: AWS Setup (Optional, Brief)
If they plan to deploy later:
- Briefly explain AWS CLI
- Mention Secrets Manager (we'll set this up fully during Phase 4)
- Don't deep-dive yet — just plant the seed

### Step 6: Verify Everything Works
Write a quick test script together that:
- Loads the API key
- Makes a simple LLM call
- Prints the response

This naturally leads into the "first LLM call" topic.

---

## When Done
- Virtual environment created and activated
- Core packages installed
- API keys configured in .env
- Test script runs successfully
- Update `learner/progress.md`: mark "Environment setup" complete
