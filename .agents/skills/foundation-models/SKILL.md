---
name: foundation-models
description: Teaches what LLMs are and how they work at a high level — training, tokens, context windows, parameters, key providers, and the intelligence/cost/speed tradeoff. Covers model selection thinking.
---

# Skill: Foundation Models

## What This Skill Does
Teaches the learner what foundation models are, how they work at a conceptual level, and how to think about model selection. This is the mental model they'll use for everything else in the curriculum.

## When to Use
During Phase 1, after environment setup. This provides the conceptual foundation before they start making API calls.

## Prerequisites
- `learner/profile.md` exists
- Ideally, environment is set up (so examples can be grounded in "you'll use this soon")

## Concept References
- `references/foundation-models.md` — the core reference for this topic
- `wisdom/performance-and-cost.md` — the intelligence/cost/speed tradeoff, token economics, model routing
- `wisdom/architecture-decisions.md` — model selection guidance, when to use which tier

---

## Teaching Flow

### Open with the Problem
Don't start with "let me explain neural networks." Start with something grounding: "You're about to build applications that use models like GPT-4 and Claude. Before you make your first API call, let's understand what these things actually are, what they can do, and how to choose between them. This will save you real money and frustration."

### Step 1: What Foundation Models Are
Cover using `references/foundation-models.md`:
- The shift: before foundation models, every task needed its own trained model. Now one model handles many tasks.
- Pre-training: learning language from massive text datasets
- Fine-tuning: learning to follow instructions
- RLHF: learning to be helpful and safe
- Why this matters for them: they're engineers building on top of these models, not training them

Keep the technical depth appropriate to their background. An ML-experienced learner wants different detail than a web developer.

### Step 2: Tokens — How Models See Text
This is essential and often misunderstood:
- Models process tokens, not words or characters
- ~4 characters per token, ~0.75 words per token
- Why tokens matter: pricing, context windows, speed
- Input vs. output token cost asymmetry (output costs 3-5x more)
- Reference `wisdom/performance-and-cost.md` for the cost implications

Make it concrete: "That paragraph you just read? About 50 tokens. A full conversation might be 5,000 tokens."

### Step 3: Context Windows
- The model's working memory — everything must fit
- Current sizes: 4K (old) to 2M (Gemini) tokens
- What goes in the window: system prompt, conversation history, documents, tool schemas, the response
- Bigger isn't always better: "lost in the middle" problem, cost, latency
- This is why memory management and RAG exist (plant the seed for later topics)

### Step 4: Key Providers and Their Models
Walk through the major providers from the concept file:
- **OpenAI:** GPT-4o, o3/o4-mini reasoning models
- **Anthropic:** Claude Opus, Sonnet, Haiku
- **Google:** Gemini 2.5 Pro, Flash

Don't just list features — explain when you'd pick each. Connect to their goals: "For your project, you'll probably start with..."

### Step 5: The Intelligence/Cost/Speed Tradeoff
This is the key decision framework. Cover using both the concept file and wisdom files:
- Every model sits on a triangle: intelligence, speed, cost
- You can optimize for two, not all three
- The decision table from the concept file (use cases mapped to model tiers)
- The golden rule from `wisdom/performance-and-cost.md`: start with the smallest model that works
- Token costs add up faster than you think — model this before launching

### Step 6: Open vs. Closed Models
Brief overview:
- Closed (API): best capability, no infrastructure, ongoing costs
- Open (Llama, Mistral, etc.): no per-token cost, full control, but need hardware
- For this curriculum: closed models via API (practical choice for most applications)

### Step 7: Parameters and Model Size
Light touch — they don't need the math:
- Parameters = the numbers adjusted during training
- More parameters generally = more capable, slower, more expensive
- The trend: smaller models getting dramatically better over time
- Today's small models often match last year's large models

---

## Adaptive Notes

**Has ML/AI background:** Skip the basic explanations of training and parameters. Focus on the practical: provider comparison, cost modeling, selection frameworks. They'll appreciate the wisdom file content. Total time: 15-20 minutes.

**Experienced developer, new to AI:** They'll grasp the concepts quickly but need the mental model. Spend time on tokens, context windows, and the tradeoff triangle — these are the concepts they'll use daily. Total time: 25-35 minutes.

**Newer to tech:** Use more analogies. Tokens are like words but not exactly. Context window is like short-term memory. Models are like different experts — some are fast but less thorough, others are slow but brilliant. Total time: 35-45 minutes.

---

## Understanding Checks
See `references/checks.md` for detailed check questions.

Key checks:
- Can they explain what a foundation model is in their own words?
- Do they understand what tokens are and why they matter for cost?
- Can they describe the intelligence/cost/speed tradeoff?
- Can they reason about model selection for a given use case?

---

## When Done
- Learner has a mental model for how LLMs work at a high level
- They understand tokens, context windows, and the cost implications
- They can reason about model selection
- Update `learner/progress.md` — mark "Foundation models" complete
- Update `learner/notes.md` — record their level of understanding, which provider(s) interest them, any areas that need reinforcement
