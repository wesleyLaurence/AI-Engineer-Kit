# Understanding Checks: Human-in-the-Loop

## Check Questions
1. What is the spectrum from fully supervised to fully autonomous? Where should most production agents sit?
2. Name three types of actions that should always require human approval. Why those?
3. When an agent escalates to a human, what information should it provide so the human can make a good decision?
4. What happens if the human rejects the proposed action? How should the agent handle that?
5. Look at your project's agent. Design an approval matrix: which actions are auto-approved, which need confirmation, which should never be automated?

## Completion Criteria
- The learner understands that autonomy is a spectrum and can reason about where to set the boundary
- They can identify irreversible, high-stakes, or ambiguous actions that need human approval
- They can design an escalation flow with appropriate information for the human
- They think about trust, audit trails, and fail-safe defaults
- They can apply these concepts to their own project

## What to Update
- `learner/progress.md` -- mark "Human-in-the-Loop" complete
- `learner/notes.md` -- record their safety intuition, the approval matrix they designed for their project
