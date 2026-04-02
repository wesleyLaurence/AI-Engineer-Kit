# Human in the Loop

## The Problem: Agents Make Mistakes

Agents are powerful but fallible. They hallucinate. They misinterpret instructions. They take actions with unintended consequences. The more autonomous an agent is, the more damage it can do before anyone notices.

Human-in-the-loop (HITL) design addresses this by building checkpoints where a human reviews, approves, or corrects the agent's actions before they're executed. It's the bridge between "fully manual" and "fully autonomous" — giving you the productivity benefits of automation with the safety net of human oversight.

---

## The Autonomy Spectrum

Not every agent action needs the same level of oversight. The right level depends on the reversibility and impact of the action.

### Fully Autonomous
The agent acts without asking. Good for: read-only operations, low-risk actions, well-tested workflows. Example: searching for information, summarizing a document, reading files.

### Notify After Action
The agent acts and then tells the human what it did. Good for: low-risk actions where awareness matters but blocking isn't worth it. Example: creating a draft document, adding a log entry.

### Confirm Before Action
The agent proposes an action and waits for human approval. Good for: medium-risk actions that are hard to reverse. Example: sending an email, modifying a database record, making an API call with side effects.

### Human Decides
The agent presents information and options, but the human makes the decision. Good for: high-risk or judgment-heavy decisions. Example: approving a deployment, deciding a customer escalation path, choosing between architectural tradeoffs.

---

## Designing Approval Flows

### What Needs Approval

Ask two questions:
1. **Is this action reversible?** If you can undo it easily, less oversight is needed.
2. **What's the blast radius?** If it affects only the user, less oversight. If it affects customers, public systems, or financial transactions, more oversight.

| Action Type | Reversible? | Blast Radius | Oversight Level |
|---|---|---|---|
| Read data | N/A | None | Autonomous |
| Write to local file | Yes | Low | Autonomous or notify |
| Send message to user | No | Medium | Confirm |
| Modify production data | Difficult | High | Confirm |
| Delete records | No | High | Human decides |
| Financial transactions | No | High | Human decides |

### Clear Presentation

When asking for approval, the agent should clearly present:
- **What** it wants to do (the specific action)
- **Why** it wants to do it (the reasoning)
- **What will happen** (expected effects)
- **What could go wrong** (risks, if relevant)
- **Options** (approve, modify, reject, or alternative approaches)

Vague approval requests ("Can I proceed?") are useless. Specific ones ("I'd like to send this email to the customer explaining the billing error — here's the draft. Should I send it?") are actionable.

---

## Escalation Patterns

Sometimes the agent encounters a situation it can't handle. Good HITL design includes escalation paths.

### When to Escalate

- The agent isn't confident in its answer or approach
- The task involves a domain the agent isn't equipped for
- Multiple failed attempts suggest the agent is stuck
- The stakes are too high for the agent to act autonomously
- The user explicitly needs to make a judgment call

### How to Escalate Well

**Provide context.** Don't just say "I need help." Say "I've been trying to resolve this customer's billing issue. I found two possible causes but I'm not sure which applies. Here's what I've found so far..."

**Present options.** Don't just dump the problem on the human. Present what you've learned, what you've tried, and what the options are.

**Make it easy to resume.** After human input, the agent should be able to continue without requiring the human to re-explain everything. This means maintaining state and context across the handoff.

---

## Trust and Safety

### Progressive Trust

A new agent should start with heavy oversight and gradually earn more autonomy as it demonstrates reliability. First, humans review every action. Then, humans review only flagged actions. Eventually, humans only review periodic samples.

This mirrors how you'd manage a new employee — start with close supervision, give more independence as trust builds.

### Audit Trails

Every agent action — especially those affecting external systems — should be logged. Who requested it, what the agent did, what the result was. This isn't just for debugging; it's for accountability.

### Fail-Safe Defaults

When in doubt, the agent should err on the side of asking rather than acting. A false positive (asking for approval when it wasn't necessary) is far less costly than a false negative (taking a harmful action without approval).

---

## Key Takeaways

- Not every action needs the same level of oversight — match oversight to reversibility and blast radius
- Approval requests should be specific: what, why, expected effects, and options
- Escalation should include context and options, not just "I need help"
- Progressive trust: start with heavy oversight, reduce as the agent proves reliable
- Log everything — audit trails are essential for accountability and debugging
- When in doubt, ask — the cost of unnecessary approval requests is far lower than the cost of unintended actions
