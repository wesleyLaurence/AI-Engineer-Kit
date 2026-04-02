# Build Details: Environment Setup

Step-by-step guide for setting up the AI engineering development environment.

---

## Step 1: Verify Python
Check that Python 3.10+ is installed. Help install if needed.
Explain briefly why version matters for AI libraries — newer versions are required by most AI SDKs and frameworks, and older versions may lack features like improved type hints and performance improvements.

**Commands to check:** `python3 --version` or `python --version`

If not installed or too old:
- macOS: recommend `brew install python` or the official installer
- Linux: use the system package manager
- Windows: official installer from python.org, making sure to check "Add to PATH"

---

## Step 2: Create Virtual Environment
Guide them through creating a venv in the `projects/` directory.
Explain what virtual environments are and why they're essential — isolated package installations per project, avoiding version conflicts.
Make sure they understand how to activate/deactivate.

**Commands:**
- Create: `python3 -m venv projects/.venv`
- Activate (macOS/Linux): `source projects/.venv/bin/activate`
- Activate (Windows): `projects\.venv\Scripts\activate`
- Deactivate: `deactivate`

**Checkpoint:** Can they activate the environment and verify which Python is active? (`which python` or `where python` should point to the .venv directory)

---

## Step 3: Install Core Dependencies
Create a `requirements.txt` in `projects/` with essentials:
- openai (or anthropic, based on their preference)
- langchain and langchain-community
- python-dotenv
- httpx

Use web search for the latest stable versions of these packages. Install with pip.

**Commands:**
- `pip install -r requirements.txt`
- Verify: `python -c "import openai; print('OK')"` (or anthropic)

**Checkpoint:** Can they import the packages without errors?

---

## Step 4: API Key Setup
Help them get API keys from their chosen provider (OpenAI and/or Anthropic).
- OpenAI: platform.openai.com, API keys section
- Anthropic: console.anthropic.com, API keys section

Create a `.env` file in `projects/`:
```
OPENAI_API_KEY=sk-...
# or
ANTHROPIC_API_KEY=sk-ant-...
```

Add `.env` to `.gitignore` if they're using git. Show them how to load keys with python-dotenv:
```python
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")
```

**Warning:** Emphasize that API keys must NEVER be in code or git. Reference `wisdom/common-pitfalls.md` — the "API Keys in Code" and ".env File Not in .gitignore" sections describe exactly what goes wrong.

**Checkpoint:** Can they load their API key in a Python script and print a confirmation (not the key itself)?

---

## Step 5: AWS Setup (Optional, Brief)
If they plan to deploy later:
- Briefly explain AWS CLI and what it's for
- Mention Secrets Manager (we'll set this up fully during Phase 4 with the setup-aws skill)
- Don't deep-dive yet — just plant the seed that production secrets management is different from .env files

Skip entirely if they're not interested in deployment yet.

---

## Step 6: Verify Everything Works
Write a quick test script together that:
1. Loads the API key from .env
2. Makes a simple LLM call (a basic completion request)
3. Prints the response

This serves as both verification and a natural bridge to the "first LLM call" topic. If something fails here, debug it now — it's much easier to fix environment issues before building on top of them.

Example structure (adapt to their chosen provider):
```python
from dotenv import load_dotenv
import os
from openai import OpenAI  # or anthropic

load_dotenv()
client = OpenAI()  # uses OPENAI_API_KEY from environment

response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": "Say hello!"}]
)
print(response.choices[0].message.content)
```

Use web search to confirm the current SDK API if needed — these APIs change.
