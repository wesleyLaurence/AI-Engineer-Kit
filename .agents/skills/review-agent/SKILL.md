---
name: review-agent
description: Reviews agent code against best practices covering prompt quality, tool design, error handling, context management, cost efficiency, and security. Use after building an agent or as a checkpoint before production.
compatibility: Designed for Claude Code (or similar products)
---

# Skill: Review Agent Implementation

## What This Skill Does
Reviews the learner's agent code against best practices. Provides specific, actionable feedback.

## When to Use
After the learner has built an agent and wants feedback, or as a checkpoint before moving to production.

## Context to Load
- `wisdom/tool-design.md`
- `wisdom/debugging-agents.md`
- `wisdom/performance-and-cost.md`
- `wisdom/common-pitfalls.md`
- `learner/project.md`

---

## Review Checklist

### Prompt Quality
- Is the system prompt clear and specific?
- Does it define the agent's role and boundaries?
- Are there instructions for edge cases?
- Is it concise (not bloated with unnecessary instructions)?

### Tool Design
- Are tool names clear and action-oriented?
- Do descriptions explain WHEN to use each tool?
- Are parameters well-defined with useful descriptions?
- Is the tool count manageable (under 15)?
- Do tools return useful, structured responses?

### Error Handling
- What happens when a tool call fails?
- Is there a maximum iteration limit?
- Are LLM API errors handled gracefully?
- Is there loop detection?

### Context Management
- Is conversation history managed (not growing unbounded)?
- Is the context focused (not including irrelevant information)?
- Are tool schemas optimized (concise descriptions)?

### Cost Efficiency
- Is the right model being used for the task?
- Are there unnecessary tokens in the prompt?
- Are agent iterations capped?
- Is caching used where appropriate?

### Security
- Are API keys stored securely?
- Is user input validated?
- Are destructive tool actions gated behind approval?
- Is the system prompt resistant to injection?

---

## How to Deliver Feedback
- Be specific: "Your search tool description should explain when to use it, not just what it does"
- Be constructive: suggest the improvement, don't just point out the problem
- Prioritize: focus on the issues that matter most for their current stage
- Connect to concepts: "This relates to what we learned about tool design..."
