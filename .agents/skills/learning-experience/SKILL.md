---
name: learning-experience
description: Explains the learning paradigm — how this interactive AI engineering curriculum works, the repo structure, and what to expect. Use when the learner asks how the learning experience works, what the format is, or how to use the repo.
---

# Topic: How This Learning Experience Works

## When to Use
- Phase 0, first topic
- Learner asks how the curriculum works or what the format is
- Learner seems confused about the learning paradigm
- Revisiting to re-orient after a break

## Prerequisites
None — this is the very first topic.

## Concept References
This is conversational — no concept file needed.

---

## Teaching Flow

### Open
Welcome the learner to the experience. Set the tone: this is a conversation, not a lecture.

"This is an interactive learning experience powered by a coding agent. You and I are going to learn AI engineering together by discussing concepts and then immediately building real things."

### Core Points to Cover

**The paradigm:**
- This is not a course with videos or slides. It is a live, adaptive conversation with an AI instructor.
- The learner discusses concepts with you, asks questions, and then builds working code — all in the same environment.
- The pace and depth adapt to them. If they already know something, you move fast. If something is confusing, you slow down and explain differently.

**The repo:**
- The repo contains the full curriculum, organized into concept files, wisdom from production experience, and skills that guide builds.
- Reference files (in each skill's `references/` folder) explain what things are and why they matter — the learner can browse these anytime.
- Wisdom files (in `wisdom/`) contain real-world lessons that only come from experience — gotchas, tradeoffs, things documentation does not tell you.
- Skills guide them through builds step by step.
- Their code will live in `projects/`.
- Their learning state lives in `learner/` — profile, progress, project, and notes.

**The expectations:**
- They should ask questions whenever something is not clear. Curiosity is encouraged, never punished.
- They do not need to memorize anything. The repo is always here as a reference.
- By the end, they will have built and deployed a complete AI application.

### Close
Confirm they understand the format before moving on. This does not need to be a long conversation — just make sure the paradigm is clear and they are comfortable.

---

## Adaptive Notes

**Experienced developers:** Keep this brief. They will understand the format quickly. Spend 2 minutes, confirm they get it, move on.

**Beginners:** Spend a bit more time here. Reassure them that the pace adapts to them and there are no wrong questions. Make sure they are comfortable with the terminal/editor environment before proceeding.

**Returning learners (review mode):** Quick re-orientation. Remind them where their files are and how to check progress.

---

## Understanding Checks
- Does the learner understand this is interactive and adaptive, not a fixed course?
- Are they comfortable with the format — discussing concepts and then building?
- Do they know they can ask questions at any time?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "How This Learning Experience Works" complete in `learner/progress.md`
- Add any observations about the learner's comfort level to `learner/notes.md`
- Proceed to the next topic: `coding-agents`
