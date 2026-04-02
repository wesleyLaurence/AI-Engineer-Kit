---
name: deep-agents
description: Teaches long-running, autonomous agent workflows -- sandboxes, code execution, async patterns, monitoring, and intervention. Use when the learner asks about deep agents, long-running agents, autonomous workflows, sandboxed execution, or agent monitoring.
---

# Topic: Deep Agents

## When to Use
- Phase 3, final topic
- Learner asks about long-running or autonomous agents
- Learner asks about sandboxed execution, background agent tasks, or monitoring agents
- Learner is designing a system where agents run for extended periods

## Prerequisites
- `react-agents` topic complete
- `subagents` topic complete
- `human-in-the-loop` topic complete (oversight is critical for deep agents)

## Concept References
- `references/deep-agents.md` -- read this before teaching

---

## Teaching Flow

### Open with the Problem
Start with what changes when agents run longer: "Everything you have built so far -- your ReAct agent, your tool calls, your subagents -- runs in seconds or minutes. But what about tasks that take hours? 'Research this market and write a 20-page report.' 'Refactor this entire codebase to use the new API.' 'Monitor this system and respond to incidents overnight.' That is deep agent territory, and it changes almost everything about how you design the system."

### Core Points to Cover

**What deep agents are:**
- Agents that run autonomously for extended periods -- minutes to hours
- They work in sandboxed environments with their own compute, file systems, and tool access
- They operate asynchronously -- you launch them and check back later
- Examples: Anthropic's Claude Code in background mode, GitHub Copilot Workspace, Devin-style coding agents

**Sandboxes and code execution:**
- Why sandboxes matter: an agent running for hours with code execution needs isolation
- What a sandbox provides: isolated file system, controlled network access, resource limits
- The security model: the agent can do anything inside the sandbox but nothing outside it
- Container-based execution (Docker, cloud sandboxes) as the standard approach

**Async patterns:**
- Launch and check back -- not blocking on agent completion
- Progress reporting -- how the agent communicates status while running
- Result delivery -- how you get the output when the agent finishes
- Cancellation -- how to stop an agent that is going off track

**Monitoring and intervention:**
- Why monitoring matters more for deep agents: longer runtime means more potential for drift
- What to monitor: token usage, cost accumulation, progress toward goal, error rates
- Intervention points: pause, redirect, provide additional context, cancel
- Audit trails: logging every action for post-hoc review

**When deep agents are appropriate:**
- Tasks that genuinely require extended autonomous work
- Tasks where the agent needs to explore, iterate, and refine
- Tasks that benefit from the agent having its own workspace
- Not appropriate for: quick tasks, tasks requiring constant human interaction, tasks where latency matters

**The current state and where it is going:**
- This is a rapidly evolving area -- the tools and platforms are changing fast
- The patterns (sandbox, async, monitor) are stable even as implementations change
- The trend is toward more capable, more autonomous, longer-running agents

### Close
"Deep agents represent the frontier of agent capability. The principles you have learned -- tool design, context engineering, human-in-the-loop oversight, subagent orchestration -- all come together here. A deep agent system is a complete, sophisticated agent architecture."

Mark this as the Phase 3 milestone: **Complete, sophisticated agent system.**

---

## Adaptive Notes

**Experienced developers:** They will recognize the parallels to distributed systems, background job processing, and container orchestration. Draw those connections. Focus on what is unique about LLM-based long-running agents vs. traditional background workers. 15-20 minutes.

**Beginners:** Focus on the concepts and patterns rather than implementation details. Use concrete examples: "Imagine you ask an agent to read 50 research papers and write a literature review. It takes 2 hours. How do you monitor it? How do you intervene if it goes off track?" 25-35 minutes.

**Returning learners (review mode):** Ask them to design a deep agent workflow for their project. What task would benefit from extended autonomous execution? What monitoring would they need?

---

## Understanding Checks
- Can the learner explain what makes a deep agent different from a standard ReAct agent?
- Can they describe why sandboxes are necessary for long-running agents?
- Can they explain async patterns: launch, monitor, intervene, retrieve results?
- Can they articulate when a deep agent architecture is appropriate vs. overkill?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Deep Agents" complete in `learner/progress.md`
- Add observations about their understanding of advanced agent architectures to `learner/notes.md`
- **Milestone:** Complete, sophisticated agent system -- mark Phase 3 complete
- Proceed to Phase 4
