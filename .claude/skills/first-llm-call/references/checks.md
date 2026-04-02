# Understanding Checks: First LLM Call

## Check Questions
1. Can the learner explain what happened in their API call — what was sent and what came back?
2. Can they describe the messages format (system, user, assistant roles) and what each role is for?
3. Do they understand that the model is stateless — it has no memory between calls?
4. Can they explain what temperature does and when you'd want it low vs. high?
5. Can they find the token usage in the response and explain what input vs. output tokens mean?
6. Do they know what the finish reason indicates (stop vs. length)?
7. Can they estimate what the API call cost based on token count and pricing?
8. Could they modify the script to change the system prompt, user message, or model parameters?

## Completion Criteria
- A working script exists that makes an LLM API call and prints the response
- The learner can explain the full request-response cycle in their own words
- They understand the messages format and statelessness
- They've experimented with temperature and/or max_tokens and observed the effects
- They can read and interpret the response object (text, tokens, finish reason)
- The concept "it's just an HTTP request" has landed — no remaining mystique

## Milestone
First working LLM call. This is the learner's first hands-on interaction with an LLM via API and marks the transition from conceptual to practical.

## What to Update
- `learner/progress.md` — mark "First LLM call" complete, note the milestone
- `learner/notes.md` — record which provider and model they used, their reaction, any areas of confusion or particular interest
- `learner/project.md` — if their project is taking shape, note the provider choice
