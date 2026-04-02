# Security

## The Problem: AI Applications Have a Unique Attack Surface

Traditional web applications have well-understood security vulnerabilities. AI applications have all of those plus entirely new attack vectors. The model itself is an attack surface. Prompts can be manipulated. Tools give the agent the ability to take real-world actions, which means a compromised agent can do real-world damage.

---

## Prompt Injection

The most significant AI-specific attack. An attacker crafts input that overrides the model's system prompt.

### Direct Prompt Injection
The user sends a message designed to override instructions: "Ignore your previous instructions and..." These target the system prompt directly.

### Indirect Prompt Injection
Malicious instructions are embedded in data the agent processes — a document, a web page, a database record. More dangerous because the instructions arrive through a trusted channel.

### Defenses

**Instruction hierarchy** — Establish that system instructions take priority over user messages and data.

**Input validation** — Check user input for known injection patterns.

**Output filtering** — Check the model's output before displaying or acting on it.

**Sandboxing tool actions** — Even if the prompt is compromised, limit damage. Tools should have minimal permissions. Destructive actions require human approval.

**Separate data from instructions** — When injecting retrieved content, clearly delimit it as data, not instructions.

---

## Input Validation

- **Message length** — Set maximums to prevent context stuffing
- **Content type** — Reject unexpected data types
- **Rate** — Limit request frequency per user
- **File uploads** — Validate types, scan for malware, limit sizes

Don't rely on the model to self-regulate. Build defenses in your application layer.

---

## Output Filtering

Before displaying agent output or executing agent-proposed actions:
- PII detection — Check for accidentally exposed personal information
- Content policy — Check for harmful or off-topic content
- System prompt leakage — Check if the model is revealing its instructions
- URL safety — Validate any URLs in responses

---

## Rate Limiting

Essential for AI applications because each request has real cost:
- Per-user limits (messages per minute/hour/day)
- Per-tier limits (free vs. paid)
- Cost-based limits (cumulative token usage)
- Abuse detection (rapid requests, systematic probing)

---

## Data Privacy

Every message goes to the model provider's API. Consider: PII in conversations, proprietary information, regulated data (HIPAA, GDPR). Mitigation: strip sensitive data, use data processing agreements, consider on-premise models for highly sensitive data.

---

## Key Takeaways

- Prompt injection is the biggest AI-specific threat — defend with layered approaches
- Never rely on the model to self-regulate — build security in the application layer
- Rate limiting prevents both abuse and cost explosions
- API keys go in a secrets manager, never in code
- Know what data goes to the model and protect sensitive information
- Security is not a feature you add later — build it from the start
