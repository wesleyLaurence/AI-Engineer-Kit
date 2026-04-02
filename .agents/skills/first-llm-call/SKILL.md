---
name: first-llm-call
description: Walks the learner through making their first LLM API call. Demystifies the magic — it's an HTTP request that sends text and gets text back. Includes a hands-on build.
---

# Skill: First LLM Call

## What This Skill Does
Walks the learner through making their first API call to an LLM. Demystifies the interaction — it's an HTTP POST that takes text in and returns text out. By the end, they have a working script and understand what happened at every layer.

## When to Use
During Phase 1, after environment setup is complete and they have a basic understanding of foundation models. This is the first hands-on milestone.

## Prerequisites
- Environment is set up (venv, packages installed, API key configured)
- Basic understanding of foundation models (what they are, what tokens are)
- `learner/profile.md` exists

## Concept References
- `references/model-apis.md` — the core reference for this topic (request-response pattern, messages format, authentication, parameters)
- `learner/profile.md` — to know which provider they chose

---

## Teaching Flow

### Open with the Problem
"You've heard about what these models can do. Now let's actually talk to one. What we're about to do is send an HTTP request to a server, and get text back. That's all an 'AI-powered application' is at the most basic level. Let's make it happen."

### Step 1: Explain What's About to Happen
Before writing any code, set up the mental model using `references/model-apis.md`:
- You're sending an HTTP POST request to a provider's server
- The request body contains your messages (a system prompt and a user message)
- The server runs it through the model
- You get back a response with the generated text, token usage, and metadata
- This is the same pattern as calling any REST API

This removes the magic. It's just an HTTP call.

### Step 2: The Messages Format
Teach the universal messages structure:
- **system** role: instructions that define behavior ("You are a helpful assistant")
- **user** role: what the human said
- **assistant** role: what the model said (used for conversation history)
- The model is stateless — it has no memory between calls. Everything it knows is in the messages you send.

This statelessness concept is crucial. Make sure it clicks.

### Step 3: Build the Script
Follow `references/build-details.md` for the step-by-step build. Use web search for current API documentation from their chosen provider.

Walk them through writing a script that:
1. Loads the API key from .env
2. Creates an API client
3. Constructs a messages array (system + user message)
4. Makes the API call
5. Prints the response

Do this together, explaining each line. Don't just paste code — build understanding.

### Step 4: Examine the Response
After the call succeeds, explore what came back:
- The generated text (the actual response)
- Token usage (input tokens, output tokens, total)
- Finish reason (why the model stopped)
- Model information

Calculate the cost of this call using the provider's pricing. Make tokens real.

### Step 5: Experiment with Parameters
Try changing things and observing the effect:
- **Temperature:** Set to 0 and run the same prompt multiple times (same output). Set to 1.0 (different each time). This makes temperature intuitive.
- **Max tokens:** Set it low and watch the response get cut off. Check the finish reason.
- **System prompt:** Change the persona. See how it changes the response style.

This experimentation builds intuition they'll use constantly.

### Step 6: Understand the Full Picture
Tie it together:
- What was sent over the network (the HTTP request)
- What came back (the HTTP response)
- What you paid for it (tokens x price)
- Why this matters: every AI feature in every application is built on this pattern

---

## Build
This skill includes a hands-on build. See `references/build-details.md` for the complete step-by-step guide.

High-level: write a Python script that makes an LLM API call, get a response, examine the response structure, experiment with parameters.

**Milestone:** First working LLM call.

---

## Adaptive Notes

**Experienced developer:** Move through the HTTP explanation quickly — they know APIs. Focus on the LLM-specific parts: messages format, statelessness, token economics, parameter effects. Let them write the code themselves with guidance. Total time: 15-20 minutes.

**Some programming experience:** Walk through the code line by line. Make sure the messages format and statelessness click. The parameter experimentation is where understanding deepens. Total time: 25-35 minutes.

**Newer to programming:** Build the script together step by step. Explain imports, client creation, the function call. Spend extra time on the response exploration — this is their first time seeing an API response. Total time: 35-45 minutes.

---

## Understanding Checks
See `references/checks.md` for detailed check questions.

Key checks:
- Can they explain what happened in the API call? What was sent, what came back?
- Do they understand the messages format and the role of each message type?
- Can they explain why the model is stateless?
- Can they describe what temperature does?

---

## When Done
- Working script that makes an LLM API call and prints the response
- Learner understands the request-response pattern at every layer
- They understand messages format, statelessness, and key parameters
- Script is saved in `projects/experiments/` or similar
- Update `learner/progress.md` — mark "First LLM call" complete
- Update `learner/notes.md` — record which provider/model they used, any observations about the experience
- **Milestone:** First working LLM call
