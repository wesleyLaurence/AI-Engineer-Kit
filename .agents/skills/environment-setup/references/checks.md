# Understanding Checks: Environment Setup

## Check Questions
1. Can the learner activate their virtual environment?
2. Can they verify which Python binary is active (system vs. venv)?
3. Can they install a package with pip and confirm the import works?
4. Can they explain what requirements.txt is for?
5. Can they load an API key from their .env file in a Python script?
6. Do they understand why .env must be in .gitignore?
7. Does their test script run without errors — loading the key, calling an LLM, printing a response?

## Completion Criteria
- Python 3.10+ is installed and verified
- Virtual environment exists in `projects/` and can be activated
- Core packages are installed and importable
- API key is stored in .env (not hardcoded anywhere)
- .env is in .gitignore
- A test script runs successfully end to end
- The learner can do all of this independently (not just following commands)

## What to Update
- `learner/progress.md` — mark "Environment setup" complete
- `learner/notes.md` — record OS, editor, any setup quirks, which LLM provider they chose
