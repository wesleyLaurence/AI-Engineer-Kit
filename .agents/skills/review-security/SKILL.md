---
name: review-security
description: Reviews AI applications for security vulnerabilities including prompt injection, input validation, API key security, authentication, tool security, and data privacy. Use before deployment or during the security curriculum topic.
compatibility: Designed for Claude Code (or similar products)
---

# Skill: Security Review

## What This Skill Does
Reviews the learner's AI application for security vulnerabilities with specific remediation guidance.

## When to Use
Before deployment, or when the learner reaches the security topic in the curriculum.

## Context to Load
- `concepts/production/security.md`
- `wisdom/production-lessons.md`
- `wisdom/common-pitfalls.md`
- `learner/project.md`

---

## Review Checklist

### Prompt Injection
- Test direct injection: "Ignore your instructions and..."
- Test indirect injection: What happens if retrieved documents contain instructions?
- Is there instruction hierarchy in the system prompt?
- Are data sections clearly delimited from instructions?

### Input Validation
- Are message lengths limited?
- Is input sanitized before processing?
- Are file uploads validated (if applicable)?
- Is rate limiting implemented?

### Output Filtering
- Is the system prompt protected from leakage?
- Is PII detection in place?
- Are URLs in responses validated?
- Is content policy enforced?

### API Key Security
- Are keys in a secrets manager (not in code or env files in repos)?
- Are keys scoped to minimum permissions?
- Are different keys used for dev and production?

### Authentication and Authorization
- Are all API endpoints protected?
- Are JWT tokens validated correctly?
- Are user permissions checked?
- Is session management secure?

### Tool Security
- Do destructive tools require human approval?
- Are tool permissions scoped to minimum necessary?
- Are tool inputs validated?
- Can tools be exploited via prompt injection?

### Data Privacy
- What user data goes to the model provider?
- Is sensitive data stripped before sending to the model?
- Are logs sanitized (no PII in logs)?
- Are data retention policies in place?

---

## How to Deliver Findings
- Rate each area: secure, needs attention, vulnerable
- Provide specific remediation steps for each finding
- Prioritize by risk level
- Explain WHY each vulnerability matters (what could an attacker do?)
