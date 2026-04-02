# Build Details: Prompt Engineering

This is a craft-focused build — writing and refining prompts, not building code infrastructure.

### Step 1: Write a Basic System Prompt
Start with their project. What should the AI do? What persona should it have?
Write a first-draft system prompt together. Keep it simple.

Test it: send a few user messages and observe the behavior.

Checkpoint: Does the model behave roughly the way they intended?

### Step 2: Add Constraints and Structure
Refine the system prompt:
- Add specific constraints (what the model should NOT do)
- Define the output format if applicable
- Add tone and audience guidance
- Organize the prompt with clear sections

Test again with the same user messages. Compare the results.

Checkpoint: Is the behavior more consistent and reliable than the first draft?

### Step 3: Try Few-Shot Examples
Pick a task where output format matters (classification, extraction, formatting).
Write a prompt without examples, test it. Then add 2-3 examples and test again.

Discuss the difference. When is this technique worth the extra tokens?

### Step 4: Test Chain of Thought
Pick a task that requires reasoning (analysis, comparison, multi-step problem).
Test with and without "think step by step" or structured reasoning instructions.

Discuss when chain of thought helps and when it just adds unnecessary length.

### Step 5: Build a Prompt Template
Show how to parameterize their system prompt:
- Identify the parts that change per request (user context, retrieved data, task details)
- Replace those parts with template variables
- Write a function that fills in the template

This is the pattern they will use throughout the rest of the curriculum — in RAG, tool calling, and agent design.

Save the prompts and template in `projects/experiments/` or their project directory.
