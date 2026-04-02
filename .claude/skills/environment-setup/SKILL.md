---
name: environment-setup
description: Gets the learner's development environment fully configured — Python, virtual environment, core dependencies, API keys, and a verification script. Practical setup, not conceptual.
---

# Skill: Environment Setup

## What This Skill Does
Gets the learner's development environment fully working for AI engineering. This is practical, hands-on setup — not conceptual teaching. By the end, they have Python, a virtual environment, installed packages, configured API keys, and a working test script.

## When to Use
During Phase 1, after the learner profile is established. Can run alongside or after the python-for-ai topic depending on the learner's background.

## Prerequisites
- `learner/profile.md` exists
- Learner has Python installed (or we help them install it)

## Concept References
- `../python-for-ai/references/python-for-ai.md` — setup section, virtual environments, dependency management
- `wisdom/common-pitfalls.md` — environment setup section (venv mistakes, API keys in code, .gitignore)
- `learner/profile.md` — to adapt to their OS and experience level

---

## Teaching Flow

### Open with the Problem
"Before we can build anything with AI, we need a working environment. Let's get you set up so that when we write code, it just works. This should take 15-30 minutes depending on what you already have."

### Step 1: Assess Current State
Check what they already have:
- Python version (need 3.10+)
- Any existing virtual environments or package managers
- Text editor / IDE setup
- Terminal comfort level

Adapt pace accordingly. If they already have Python and know venvs, move quickly.

### Step 2-6: Follow Build Steps
The detailed build steps are in `references/build-details.md`. Follow them in order:
1. Verify Python (install if needed)
2. Create virtual environment in `projects/`
3. Install core dependencies from requirements.txt
4. Set up API keys in .env file
5. Optional AWS CLI mention (brief, for later)
6. Verify everything with a test script

Each step has checkpoints. Don't skip them — catching problems early saves time.

### Key Teaching Moments During Setup
While doing the practical work, weave in understanding:
- **Why version matters:** AI libraries drop support for older Python versions. 3.10+ ensures compatibility.
- **Why venvs matter:** Reference `wisdom/common-pitfalls.md` — real stories of environment conflicts.
- **Why .env and .gitignore:** This is a security habit, not optional. API key leaks cause real damage.

---

## Build
This skill is primarily a build. See `references/build-details.md` for the complete step-by-step guide.

High-level: verify Python, create venv, install packages, configure API keys, run a test script.

---

## Adaptive Notes

**Experienced developer:** They probably have Python and know venvs. Confirm their setup, help with AI-specific packages and API keys. Skip explanations of what a virtual environment is. Total time: 10-15 minutes.

**Some experience:** Walk through each step but don't over-explain. Let them do the work with guidance. Total time: 20-30 minutes.

**New to development:** Explain each step as you go. Make sure they understand what's happening, not just following commands. Total time: 30-45 minutes.

---

## Understanding Checks
See `references/checks.md` for detailed check questions.

Key checks:
- Can they activate a venv and verify which Python is active?
- Can they install packages with pip?
- Can they run a Python script that loads an API key from .env?

---

## When Done
- Virtual environment created and activated in `projects/`
- Core packages installed (openai or anthropic, langchain, python-dotenv, httpx)
- API keys configured in `projects/.env`
- `.env` is in `.gitignore`
- Test script runs successfully (loads key, makes an LLM call, prints response)
- Update `learner/progress.md` — mark "Environment setup" complete
- Update `learner/notes.md` — record OS, editor, any setup issues encountered
- This naturally leads into the "first LLM call" topic
