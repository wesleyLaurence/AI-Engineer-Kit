# Working with Coding Agents

## Why This Is the First Thing You Learn

You're about to learn AI engineering by working with an AI agent. That makes this skill recursive — and essential. If you can't communicate effectively with a coding agent, every other topic in this curriculum will take longer and feel harder than it needs to.

Coding agents (Claude Code, Cursor, Codex) are the most significant shift in software development since version control. They don't just autocomplete lines — they read codebases, write files, run commands, debug errors, and build entire features. But they're tools, not magic. How you use them determines what you get out of them.

The developers who get the most from coding agents aren't the ones who type the fanciest prompts. They're the ones who think clearly about what they want, communicate it well, and know when to trust the agent versus when to intervene.

---

## What Coding Agents Actually Are

A coding agent is an LLM (large language model) with the ability to take actions in your development environment. It can:

- Read and understand your codebase
- Write and edit files
- Run terminal commands
- Search the web for documentation
- Execute multi-step plans autonomously
- Respond to errors and adjust its approach

The key distinction from a chatbot: a coding agent doesn't just suggest code — it writes it directly into your project, runs it, and iterates on it.

### The Major Agents

**Claude Code** — Anthropic's CLI-based coding agent. Runs in your terminal. Reads your project files, writes code, runs commands. Excellent at understanding large codebases and making complex changes. Has a skill system for packaging reusable capabilities.

**Cursor** — An IDE (modified VS Code) with deep AI integration. The agent can see your entire project, make edits across files, and run terminal commands. Supports multiple models (Claude, GPT, etc.). Good balance of AI assistance and traditional IDE features.

**Codex** — OpenAI's coding agent. Similar capabilities to Claude Code — reads your project, writes code, runs commands. Runs in its own sandboxed environment.

All three can serve as your instructor for this curriculum. The concepts are the same regardless of which agent you use.

---

## How to Give Good Instructions

The single most important skill when working with a coding agent is giving clear instructions. Vague instructions produce vague results. Specific instructions produce specific results.

### Be Specific About What You Want

Instead of "make this better," say "add error handling to the API call — catch network errors and rate limit responses separately, and log both." Instead of "fix the bug," say "the chat history isn't being sent with each request — look at how messages are being accumulated in the send function."

The agent is extremely capable, but it can't read your mind. The more context you provide about what you want and why, the better the result.

### Describe the Outcome, Not Just the Steps

Good: "I need a function that takes a list of documents, chunks them into ~500 token pieces with 50 token overlap, and returns the chunks with metadata about which document each came from."

This tells the agent what you need without prescribing exactly how to build it. The agent often knows better implementation patterns than you'd specify step-by-step.

### Provide Context About Why

"Add rate limiting to the API" is fine. "Add rate limiting to the API — we're seeing costs spike when users send rapid-fire requests, and we need to cap it at 10 requests per minute per user" is better. The "why" helps the agent make better decisions about implementation details.

### One Thing at a Time for Complex Work

For large features, break them into steps rather than asking for everything at once. "First, set up the database schema for storing conversations" → review → "Now add the API endpoints for creating and loading threads" → review → "Now wire the frontend to use these endpoints."

This gives you checkpoints to review and correct course.

---

## How to Review Agent Output

The agent writes code fast. Your job is to make sure that code is correct, secure, and does what you actually need. This is a critical skill — possibly more important than writing code yourself.

### Read Before You Accept

Don't blindly accept generated code. Read through it. Does it make sense? Does it handle edge cases? Does it follow the patterns already established in your codebase? Would you be comfortable explaining this code to someone else?

### Check the Architecture, Not Just the Syntax

The agent rarely makes syntax errors. What it sometimes gets wrong is the bigger picture — using the wrong pattern, over-engineering a simple problem, or missing a simpler approach. Focus your review on architectural decisions.

### Test It

Run the code. Try edge cases. Break it intentionally. The agent is good at writing code that works for the happy path but sometimes misses error cases or unusual inputs.

### Watch for Hallucinations

LLMs sometimes reference APIs that don't exist, use deprecated function signatures, or invent library features. If something looks unfamiliar, verify it. This is especially common with newer or less popular libraries.

---

## When to Let the Agent Drive vs. Take Control

### Let the Agent Drive When

- **Boilerplate and scaffolding** — project setup, config files, standard patterns
- **Well-defined tasks** — "add a GET endpoint that returns user data from the database"
- **Refactoring** — renaming variables, restructuring files, applying a pattern across a codebase
- **Debugging** — the agent can often diagnose and fix errors faster than you by reading the full error context
- **Learning** — when you're exploring a new technology, let the agent build the first version while explaining what it's doing

### Take Manual Control When

- **Architectural decisions** — the agent can suggest, but you should decide how your system is structured
- **Security-sensitive code** — always review authentication, authorization, and data handling carefully
- **Subtle business logic** — the agent doesn't know your business requirements as well as you do
- **When the agent is going in circles** — if it's tried the same approach twice and failed, step in with a different direction

---

## Debugging Agent Mistakes

When the agent does something wrong, don't just say "that's wrong, fix it." Tell it specifically what's wrong and, if you can, why.

### Common Failure Patterns

- **Wrong version of a library** — the agent's training data might reference an older API. Tell it the specific version you're using or ask it to check the current docs.
- **Over-engineering** — the agent loves abstractions. If it builds three layers of indirection for a simple feature, tell it to simplify.
- **Missing context** — the agent might not have read a relevant file. Point it to the file that contains the context it needs.
- **Going in circles** — the agent tries something, it fails, it tries the same thing slightly differently, it fails again. Step in and suggest a different approach entirely.

### The Most Effective Debugging Prompt

"Stop. Read [specific file]. The issue is [specific problem]. Here's what I think is happening: [your theory]. Fix it with [your suggested approach or constraint]."

This gives the agent everything it needs: where to look, what's wrong, and a direction to go.

---

## The Agent as a Learning Tool

This is the most powerful aspect of working with a coding agent while learning. You have an expert that you can interrogate at any time.

### Ask "Why" Constantly

When the agent writes something, ask why it made that choice. "Why did you use async here?" "Why a class instead of a function?" "Why this library instead of that one?" The agent will explain its reasoning, and you'll learn the principles behind the implementation.

### Ask for Alternatives

"What's another way to do this?" or "What are the tradeoffs of this approach?" forces the agent to show you the landscape of options, not just one path.

### Ask It to Teach, Not Just Build

"Explain what this code does before we move on" or "walk me through how this function works step by step." The agent is patient and will explain at whatever level of detail you need.

---

## Key Takeaways

- Coding agents are tools that amplify your effectiveness — but you need to direct them well
- Clear, specific instructions with context about "why" produce the best results
- Always review agent output — focus on architecture and correctness, not just syntax
- Let the agent drive for boilerplate and well-defined tasks; take control for architecture and security
- When the agent makes mistakes, be specific about what's wrong and provide direction
- Use the agent as a learning tool — ask why, ask for alternatives, ask it to explain
- The skill of working with coding agents is itself one of the most valuable skills in modern software development
