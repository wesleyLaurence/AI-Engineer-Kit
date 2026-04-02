# Understanding Checks: Python for AI Engineering

## Check Questions
1. Can the learner explain what a virtual environment is and why it matters?
2. Can they create and activate a venv, and verify which Python is active?
3. Do they understand how requirements.txt tracks dependencies?
4. Can they explain the difference between synchronous and asynchronous code?
5. Do they know when async/await matters in AI applications (I/O-bound operations, multiple API calls)?
6. Are they comfortable making an HTTP request from Python (using requests or httpx)?
7. Can they explain what type hints are and why AI frameworks rely on them?
8. Do they know what Pydantic does and where they'll encounter it?
9. Do they understand why API keys go in .env files, not in code?

## Completion Criteria
- The learner is comfortable with virtual environments and dependency management
- They understand async/await conceptually and know when to use it
- They can make HTTP requests from Python
- They know what Pydantic is and that they'll use it extensively
- They understand the .env pattern for secrets
- No signs of confusion about Python environment management

## Adaptive Completion
- **Experienced Python developer:** Confirming they know venvs, async, HTTP, and Pydantic is sufficient. Mark complete after a brief conversation.
- **Experienced in another language:** They should be able to explain the Python-specific patterns in their own words.
- **Newer programmer:** They should have actually created a venv, installed a package, and written at least one small example.

## What to Update
- `learner/progress.md` — mark "Python for AI" complete
- `learner/notes.md` — record Python comfort level, any gaps to revisit, specific areas of strength
