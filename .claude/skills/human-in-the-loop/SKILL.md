---
name: human-in-the-loop
description: Teaches when agents need human approval, how to design escalation flows, and the spectrum from fully autonomous to fully supervised. Use when the learner asks about agent safety, approval workflows, human oversight, or when agents should ask for permission.
---

# Topic: Human-in-the-Loop Patterns

## When to Use
- Phase 3, after context-engineering
- Learner asks about agent safety, approval flows, or human oversight
- Learner asks when agents should act autonomously vs. ask for permission
- Learner is designing an agent that takes consequential actions

## Prerequisites
- `react-agents` topic complete (they have a working agent)
- `agentic-workflows` topic complete (they understand the autonomy spectrum)

## Concept References
- `references/human-in-the-loop.md` -- read this before teaching

---

## Teaching Flow

### Open with the Problem
Start with a scenario that makes the stakes real: "Your agent has access to a database and can send emails. A user asks it to delete all records from last month and notify the team. Should the agent just do it? What if the user misspoke and meant last week? What if the agent misunderstood and deletes from the wrong table? This is why human-in-the-loop patterns exist -- and getting them right is the difference between a useful agent and a dangerous one."

### Core Points to Cover

**The spectrum of autonomy:**
- Fully supervised -- human approves every action
- Semi-autonomous -- agent acts freely on low-risk tasks, escalates high-risk ones
- Fully autonomous -- agent handles everything without human intervention
- Most production systems should be semi-autonomous. The question is where to draw the line.

**When to require human approval:**
- Irreversible actions (deleting data, sending communications, financial transactions)
- Actions with unclear intent (ambiguous user requests)
- High-stakes decisions (anything where being wrong has significant consequences)
- Novel situations the agent has not encountered before
- When the agent is uncertain (low confidence in its interpretation)

**Designing escalation flows:**
- The approval request pattern: agent proposes action, explains reasoning, waits for confirmation
- Information the human needs to make a good decision: what the agent wants to do, why, what alternatives exist, what the risks are
- Timeout handling -- what happens if the human does not respond?
- Rejection handling -- what does the agent do when told "no"?

**Trust and safety considerations:**
- Trust is earned incrementally. Start supervised, loosen over time based on track record.
- Audit trails -- log every action, every decision, every approval
- The principle of least authority -- give agents only the permissions they need
- Fail-safe defaults -- when in doubt, ask

**Designing for their project:**
- What actions in their agent are reversible vs. irreversible?
- What is the cost of an error for each action?
- Where should the autonomy boundary be?

### Close
"The best agent systems are not the most autonomous ones -- they are the ones that know when to ask. Designing good escalation flows is as important as designing good tools."

---

## Adaptive Notes

**Experienced developers:** They will recognize this as the same problem as permissions and authorization in traditional systems. Draw the parallel explicitly. Focus on the design patterns and the specific challenges of LLM-based systems (uncertainty, hallucination, misinterpretation). 15-20 minutes.

**Beginners:** Use more concrete scenarios. Walk through 3-4 examples of agent actions and ask them to classify each as "auto-approve" or "needs human." Build their intuition for where the boundary should be. 25-35 minutes.

**Returning learners (review mode):** Have them review their own agent's action set and design an approval matrix. Which actions are auto-approved? Which need confirmation? Which should never be automated?

---

## Understanding Checks
- Can the learner explain the autonomy spectrum and where most production systems should sit?
- Can they identify which actions in their project need human approval and why?
- Can they design an escalation flow -- what information the human needs, how to handle rejection?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Human-in-the-Loop" complete in `learner/progress.md`
- Add observations about their safety awareness to `learner/notes.md`
- Proceed to `subagents`
