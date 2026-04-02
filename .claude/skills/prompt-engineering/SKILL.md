---
name: prompt-engineering
description: Teaches prompt engineering — system prompts, few-shot examples, chain of thought, and prompt templates. Use when the learner is ready to learn prompt design or asks about writing effective prompts.
---

# Topic: Prompt Engineering

## When to Use
- Phase 2, first topic
- Learner asks about writing system prompts, few-shot examples, or prompt templates
- Learner's prompts are producing unreliable or inconsistent behavior
- Revisiting to refine prompts for their project

## Prerequisites
- First LLM call working (they can call a model and get a response)
- Understands the basics of the messages format (system, user, assistant)

## Concept References
- `references/prompt-engineering.md` — read this before teaching
- `wisdom/common-pitfalls.md` (prompt section) — weave in common mistakes as you teach

---

## Teaching Flow

### Open
Start with the problem: "You can call an LLM and get a response. But how do you get it to do what you actually want, reliably? That is prompt engineering — and it is arguably the most important practical skill in AI engineering. The difference between a mediocre AI product and a great one is almost always the prompts."

### Core Points to Cover

**System prompts vs. user messages:**
- The system prompt defines who the model is and how it behaves. The user message is the current request.
- Analogy: the system prompt is the job description; the user message is the task assignment.
- Show how the same user message produces wildly different responses with different system prompts.
- Make this concrete — write a system prompt together, send a user message, see what happens. Then change the system prompt and see how the response changes.

**Defining behavior with system prompts:**
- Be specific about tone, format, constraints, and audience.
- Tell the model what it should do AND what it should not do.
- Give it a persona or role when appropriate.
- Structure matters — well-organized system prompts produce better results than wall-of-text prompts.

**Few-shot examples:**
- Sometimes the best way to show the model what you want is to give it examples.
- Include 2-3 examples of input/output pairs in the prompt.
- Works especially well for formatting, classification, and extraction tasks.
- Demonstrate: write a prompt without examples, see inconsistent output. Add examples, see consistent output.

**Chain of thought:**
- For complex reasoning tasks, ask the model to think step by step.
- "Let's think through this step by step" is surprisingly effective.
- Explain why: it forces the model to show its work, which improves accuracy and makes errors visible.
- When to use it (complex reasoning) vs. when it is unnecessary (simple tasks).

**Prompt templates:**
- In real applications, prompts are not hardcoded strings — they are templates with variables.
- Show the pattern: a base prompt with placeholders that get filled in with context, user input, retrieved data.
- Connect to what is coming: RAG injects retrieved documents into a prompt template. Tool results get formatted into prompts. Everything is prompt engineering.

### Close
Reinforce that this is a skill they will practice throughout the entire curriculum. Every time they build something, they are doing prompt engineering. The prompts they write today will evolve as they learn more.

---

## Adaptive Notes

**Experienced developers:** They may already have intuition about prompts from using ChatGPT. Push them past surface-level understanding — focus on system prompt design, structured prompts, and the template pattern. Move quickly through basics and spend time on the craft of writing reliable, production-quality prompts.

**Beginners:** Spend more time here. Let them experiment. Write prompts, see results, iterate. The hands-on loop of write-test-refine is where the learning happens. Do not rush this topic — it underpins everything else.

**Returning learners (review mode):** Focus on whatever is weak. If their system prompts are vague, drill into specificity. If they are not using few-shot examples when they should be, show the difference. Review their project's prompts and improve them together.

---

## Build

Have the learner write system prompts for their project. This is a lightweight build focused on craft, not infrastructure.

See `references/build-details.md` for step-by-step guidance.

---

## Understanding Checks
- Can they explain the difference between a system prompt and a user message?
- Can they write a system prompt that reliably produces the behavior they want?
- Do they understand when to use few-shot examples vs. instructions?
- Can they explain what chain of thought is and when it helps?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "Prompt Engineering" complete in `learner/progress.md`
- Add observations about their prompt-writing instincts to `learner/notes.md`
- Save any system prompts they wrote in their project directory or `projects/experiments/`
- Proceed to the next topic: `memory-and-threads`
