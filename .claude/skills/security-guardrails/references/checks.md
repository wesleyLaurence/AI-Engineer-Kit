# Understanding Checks: Security Guardrails

## Check Questions
1. What is prompt injection? Give an example of a direct injection and an indirect injection.
2. Describe your defense-in-depth strategy. What are the layers, and what does each one catch?
3. Try to bypass your own guardrails. What attack worked? What did you do about it?
4. What happens if a user asks the agent to reveal its system prompt? Show the response.
5. How do you handle sensitive data? Where does user data flow, and who has access?
6. What is the tradeoff between strict input validation and user experience? How did you balance it?

## Completion Criteria
- The learner can explain prompt injection and why it is an unsolved problem
- They understand defense-in-depth: no single layer is sufficient, multiple layers together are effective
- Input validation is implemented: length limits, suspicious pattern detection
- System prompt is hardened with explicit boundaries and override resistance
- Output filtering catches sensitive data leaks (system prompt content, API keys, etc.)
- Tool permissions are reviewed and appropriately restricted
- Security events are logged and alerting is configured
- The learner has tested their guardrails with real attack attempts and iterated

## What to Update
- `learner/progress.md` -- mark "Security Guardrails" complete
- `learner/notes.md` -- record their security findings, successful attacks they discovered, guardrail design decisions
