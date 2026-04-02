# Foundation Models

## What Problem This Solves

Before foundation models, building an AI system meant training a model from scratch for your specific task. Want a chatbot? Collect thousands of conversations and train a model. Want text classification? Label thousands of examples and train another model. Every application required its own dataset, its own training pipeline, its own model.

Foundation models changed this entirely. A single model, trained on massive amounts of text, can be adapted to almost any language task — conversation, analysis, coding, reasoning, writing — without additional training. You don't build the intelligence; you use it.

This is the shift that created AI engineering as a discipline. You're not a data scientist training models. You're an engineer building applications on top of models that already understand language.

---

## How Foundation Models Work (The Mental Model)

### Pre-training: Learning Language

A foundation model starts by reading an enormous amount of text — books, websites, code, conversations, scientific papers. During this process (pre-training), it learns the statistical patterns of language: which words follow which, how sentences are structured, what concepts relate to what.

But it learns far more than just pattern matching. At sufficient scale, these models develop emergent capabilities — reasoning, following instructions, writing code, solving math problems — that weren't explicitly programmed. The exact mechanism is still debated, but the practical result is clear: large models can do things that smaller models can't, in ways that surprise even their creators.

### Fine-tuning: Learning to Be Helpful

Raw pre-trained models are powerful but unwieldy. They complete text — give them a half-finished sentence and they'll continue it — but they don't naturally follow instructions or have conversations.

Fine-tuning adapts the pre-trained model for specific behaviors. The most important fine-tuning technique for conversational AI is instruction tuning, where the model learns to follow instructions and respond helpfully to questions.

### RLHF: Learning to Be Good

Reinforcement Learning from Human Feedback (RLHF) is the process that turns a capable model into a safe, aligned assistant. Human evaluators rate model outputs, and these ratings train the model to produce responses that humans prefer — more helpful, less harmful, more honest.

This is why ChatGPT felt like a breakthrough even though GPT-3 existed before it. GPT-3 could do impressive things but was hard to steer. RLHF made the model actually useful for normal people.

---

## Tokens: How Models See Text

Models don't process text character by character or word by word. They process **tokens** — chunks of text that are typically 3-4 characters long.

### Why Tokens Matter

- **Pricing** — You pay per token (both input and output). Understanding token counts helps you estimate costs.
- **Context windows** — The model can only "see" a limited number of tokens at once. This is the context window.
- **Speed** — More tokens = more time. Both the input (reading) and output (generating) are proportional to token count.

### Token Economics

A rough rule of thumb: 1 token ≈ 4 characters in English, or about 0.75 words. A 1,000-word document is roughly 1,300 tokens. A long conversation can easily hit tens of thousands of tokens.

Both input tokens (what you send to the model) and output tokens (what the model generates) cost money, but output tokens typically cost 3-5x more than input tokens. This asymmetry matters for cost optimization.

---

## Context Windows

The context window is the total number of tokens the model can process in a single request — input plus output combined.

### Why Context Windows Matter

The context window is the model's working memory. Everything it knows about your current interaction — the system prompt, the conversation history, any documents you've provided, the tool schemas — must fit within this window.

### Current State

Context windows have grown dramatically:
- Early GPT-3: 4,000 tokens (~3,000 words)
- GPT-4: 128,000 tokens (~96,000 words)
- Claude: 200,000 tokens (~150,000 words)
- Gemini: up to 2,000,000 tokens

Larger isn't always better. Performance can degrade with very long contexts (the "lost in the middle" problem, where models struggle to find information buried in the middle of very long inputs). And longer contexts cost more and take longer to process.

---

## The Key Providers

### OpenAI

The company that started the current AI wave with GPT-3 and ChatGPT. Their flagship models are the GPT-4 family and the o-series reasoning models.

**Strengths:** Broad capabilities, massive ecosystem, well-documented APIs, strong tool calling.
**Models to know:** GPT-4o (their versatile flagship), o3/o4-mini (specialized reasoning models that "think" before responding).

### Anthropic

Created by former OpenAI researchers with a focus on AI safety. Their flagship models are the Claude family.

**Strengths:** Excellent at following complex instructions, strong at long-context tasks, very capable at coding, thoughtful safety design.
**Models to know:** Claude Opus (most capable), Claude Sonnet (best balance of capability and speed), Claude Haiku (fastest and cheapest).

### Google

Their Gemini models are competitive with GPT-4 and Claude, with the advantage of deep integration with Google's ecosystem.

**Strengths:** Massive context windows (up to 2M tokens), multimodal capabilities, integration with Google services.
**Models to know:** Gemini 2.5 Pro, Gemini 2.5 Flash.

---

## Model Selection: The Tradeoff Triangle

Every model sits somewhere on a triangle of three properties:

### Intelligence
How capable the model is at complex tasks — reasoning, following nuanced instructions, handling edge cases, producing high-quality output. More intelligent models are better at hard tasks but cost more and are slower.

### Speed
How quickly the model generates output. Faster models provide better user experience and can handle more requests. Speed usually trades off against intelligence.

### Cost
How much you pay per token. Cheaper models are better for high-volume, simpler tasks. Cost usually trades off against intelligence.

### The Decision Framework

| Use Case | Priority | Model Tier |
|---|---|---|
| User-facing chat | Speed + Intelligence | Mid-tier (Sonnet, GPT-4o) |
| Complex reasoning/analysis | Intelligence | Top-tier (Opus, o3) |
| High-volume classification | Cost + Speed | Small (Haiku, GPT-4o-mini) |
| Document summarization | Cost | Small to mid-tier |
| Code generation | Intelligence | Mid to top-tier |

The practical advice: **start with the smallest model that works for your task.** You can always upgrade. Starting with the most expensive model and then trying to optimize costs later is much harder than starting cheap and upgrading where needed.

---

## Parameters and Model Size

Model size is measured in parameters — the numbers that the model adjusts during training. More parameters generally means more capability, but with diminishing returns and increasing costs.

You don't need to understand the math behind parameters. What you need to know:
- Bigger models are generally smarter but slower and more expensive
- The relationship isn't linear — a model twice the size isn't twice as smart
- Smaller models have gotten dramatically better over time — today's small models often match last year's large models
- The trend is toward smaller, more efficient models that punch above their weight

---

## Open vs. Closed Models

### Closed Models (API-only)
GPT-4, Claude, Gemini. You access them via API. You can't see the weights, run them locally, or modify them. You pay per use.

**Advantages:** State-of-the-art performance, no infrastructure to manage, always up to date.
**Disadvantages:** Ongoing costs, data goes to a third party, you're dependent on the provider.

### Open Models
Llama (Meta), Mistral, DeepSeek, Qwen. The model weights are publicly available. You can download them and run them on your own hardware.

**Advantages:** No per-token costs (after hardware), data stays local, full control, can fine-tune.
**Disadvantages:** Requires GPU hardware, generally less capable than top closed models, you manage the infrastructure.

### For This Curriculum

We focus on closed models via API because they're the practical choice for most AI applications. They require no hardware investment, no infrastructure management, and provide the best capabilities. When cost or privacy requirements demand it, open models are a viable alternative — but they add significant operational complexity.

---

## Key Takeaways

- Foundation models are pre-trained on massive text datasets and can be adapted to almost any language task without additional training
- Tokens are the unit of both pricing and context — understanding them is essential for cost management
- Context windows are the model's working memory — everything must fit within them
- Model selection is a tradeoff between intelligence, speed, and cost — start with the smallest model that works
- The major providers (OpenAI, Anthropic, Google) each have strengths — most production applications use multiple providers
- Open models give you control and eliminate per-token costs but require infrastructure — closed models are simpler for most use cases
- The field moves fast — models get better and cheaper constantly, so today's "best" model will be surpassed within months
