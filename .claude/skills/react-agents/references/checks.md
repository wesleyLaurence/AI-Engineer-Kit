# Understanding Checks: ReAct Agents

## Check Questions
1. Explain the ReAct loop in your own words. What happens at each step?
2. How does the model decide which tool to call? What information does it use?
3. Walk through your agent's execution trace for a specific task. Explain what the model thought, what it did, what it observed, and why it made each decision.
4. What happens if a tool fails? How does your agent handle it?
5. Name three common agent failures. How would you diagnose and fix each one?
6. Why is a maximum iteration limit important? What happens without one?

## Completion Criteria
- The learner can explain the ReAct loop clearly and accurately
- They can trace through their agent's execution step by step, explaining the reasoning
- They have a working agent with 3+ tools that handles real tasks from their project
- Error handling is implemented -- tool failures do not crash the agent
- They understand common failure modes and how to debug them using execution traces
- The agent is connected to their project code

## Milestone Verification
- **First full ReAct agent** -- the agent works, handles multi-step tasks, and is connected to the learner's project

## What to Update
- `learner/progress.md` -- mark "ReAct Agents" complete, note the milestone
- `learner/notes.md` -- record their debugging intuition, the tools they built, any challenges they encountered
