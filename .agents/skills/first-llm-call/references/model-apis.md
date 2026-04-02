# Model APIs

## What Problem This Solves

A foundation model is useless to your application unless you can talk to it. Model APIs are how you do that — they're HTTP endpoints that accept a prompt and return a response. At the most fundamental level, building with LLMs is just making API calls.

Understanding this removes the mystique. When someone says "AI-powered application," what they mean is "an application that makes HTTP requests to a model API." The model is a service, like a database or a payment processor. You send it data, it processes it, it sends back results.

---

## The Request-Response Pattern

Every LLM API call follows the same basic pattern:

1. You construct a **request** with your messages (system prompt, user input, conversation history)
2. You send it as an HTTP POST to the provider's endpoint
3. The provider runs your input through the model
4. You receive a **response** with the model's output

That's it. Everything else — streaming, tool calling, function definitions, structured output — is built on top of this basic pattern.

---

## The Messages Format

The universal way to communicate with chat models is through a **messages array**. Each message has a role and content.

### Roles

**system** — Instructions that define the model's behavior. "You are a helpful assistant that specializes in Python debugging." The system message sets the stage for the entire conversation. It's always the first message and is typically written by the developer, not the end user.

**user** — What the human said. Questions, instructions, input data. Each user message represents one turn from the human in the conversation.

**assistant** — What the model said. Previous responses from the model, included so the model has conversation context. When you send a new request, you include the full conversation history so the model knows what's been said before.

### The Statelesness Principle

This is crucial: **the model has no memory.** Every API call is independent. The model doesn't know what you said five minutes ago unless you include it in the messages array. Conversation "memory" is an illusion created by sending the full history with each request.

This means your application is responsible for storing and managing conversation history. The model just processes whatever messages you send it right now.

---

## Authentication

Every provider requires an API key — a secret string that identifies your account and tracks your usage.

### API Key Security

API keys should never be:
- Hardcoded in source code
- Committed to git
- Shared publicly
- Stored in frontend code (where users can see them)

API keys should be:
- Stored as environment variables (for local development)
- Stored in a secrets manager (for production)
- Rotated periodically
- Scoped to minimum necessary permissions

If your API key leaks, someone else can run up charges on your account. Treat API keys like passwords.

---

## Response Format

When the model responds, you receive a structured response containing:

### The Generated Text
The model's actual output — the response to your prompt. This is in the `content` field of the assistant message.

### Token Usage
How many tokens were used — input tokens (what you sent), output tokens (what the model generated), and the total. This is how you track costs.

### Finish Reason
Why the model stopped generating:
- **stop** — The model naturally finished its response
- **length** — The response hit the maximum token limit you set
- **tool_calls** — The model wants to call a tool (more on this in the tool calling concept)

### Model Information
Which specific model version processed the request. Useful for debugging and reproducibility.

---

## Key Parameters

When making an API call, you can control the model's behavior with several parameters:

### Temperature
Controls randomness. Range: 0.0 to 2.0 (typically).
- **0.0** — Deterministic. The model always picks the most likely next token. Best for factual tasks, code generation, structured output.
- **0.7-1.0** — Moderate creativity. Good default for conversational AI.
- **1.5+** — Very creative/random. Rarely useful in production.

For most AI engineering work, keep temperature low (0.0-0.3) when you need consistency and reliability.

### Max Tokens
The maximum number of tokens the model can generate in its response. This is a safety limit — it prevents the model from generating endlessly. Set it based on what you expect: a short answer might need 200 tokens, a detailed explanation might need 2,000.

If the model hits this limit, it stops mid-sentence. The finish reason will be "length" instead of "stop."

### Top-p (Nucleus Sampling)
An alternative to temperature for controlling randomness. Instead of scaling probabilities, it considers only the top tokens whose cumulative probability exceeds p. In practice, most people use temperature and leave top-p at its default.

### Stop Sequences
Strings that cause the model to stop generating when encountered. Useful for constraining output format. For example, if you want the model to generate a single JSON object, you might set a stop sequence for the newline after the closing brace.

---

## Rate Limits

Every provider limits how many requests you can make per minute and how many tokens you can process per minute. These limits vary by model and account tier.

### Why Rate Limits Exist
LLM inference is computationally expensive. Providers need to balance load across all their users. Higher-tier accounts get higher limits.

### What Happens When You Hit Them
You receive a 429 (Too Many Requests) response. Your application needs to handle this gracefully — typically by waiting and retrying with exponential backoff.

### Planning Around Rate Limits
For production applications, rate limits affect your architecture. If you expect 100 concurrent users, you need enough rate limit headroom to serve them all. This might mean using a cheaper, faster model for simple tasks to conserve your rate limit budget for complex ones.

---

## Provider API Patterns

### Direct HTTP vs. SDK

You can call any LLM API using raw HTTP requests (with httpx or requests), but every major provider offers an official SDK that handles authentication, retry logic, streaming, and response parsing for you.

Use the SDK. It's almost always the right choice unless you have a specific reason to go lower-level.

### Provider SDKs

**OpenAI SDK** — `openai` package. The most widely used. Its API format has become a de facto standard — many other providers offer OpenAI-compatible endpoints.

**Anthropic SDK** — `anthropic` package. Clean, well-designed API with strong support for streaming and tool use.

**Google SDK** — `google-generativeai` package. Access to Gemini models.

### SDKs vs. Frameworks

SDKs give you direct access to a single provider's API. Frameworks (like LangChain) add a layer of abstraction that lets you switch between providers, chain operations, and build more complex workflows.

The tradeoff: SDKs are simpler and give you full control. Frameworks add complexity but provide powerful abstractions for building agents, chains, and RAG systems.

For this curriculum, we start with direct SDK calls to understand the fundamentals, then move to LangChain for building agents and more complex systems.

---

## Choosing Between Providers

### Multi-Provider Strategy

Most production AI applications use multiple providers. Why:
- **Redundancy** — If one provider has an outage, you can fall back to another
- **Optimization** — Different models excel at different tasks
- **Cost** — Route simple tasks to cheaper models, complex tasks to expensive ones
- **Rate limits** — Spread load across providers to avoid hitting limits

### Provider-Agnostic Design

When possible, design your application so the model is interchangeable. Use a framework like LangChain that abstracts the provider, or build your own thin abstraction layer. This lets you swap models without rewriting your application.

The concept files, wisdom, and skills in this kit teach concepts that work across all providers. The specific API calls will differ, but the patterns and architecture are universal.

---

## Key Takeaways

- LLM APIs are HTTP endpoints — understanding this removes the magic and lets you debug effectively
- The messages format (system, user, assistant roles) is universal across providers
- The model is stateless — conversation memory is your application's responsibility
- API keys are secrets — treat them like passwords, never hardcode them
- Temperature controls randomness — keep it low for consistency, higher for creativity
- Rate limits are real constraints — plan your architecture around them
- Use the official SDKs unless you have a specific reason to go lower-level
- Design for provider flexibility — being locked to one provider is a risk
- Start with direct API calls to understand the fundamentals, then use frameworks for complex systems
