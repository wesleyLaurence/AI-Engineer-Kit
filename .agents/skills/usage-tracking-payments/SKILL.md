---
name: usage-tracking-payments
description: Teaches token usage monitoring, user tiers, rate limiting, and Stripe payment integration for AI applications. Use when the learner asks about billing, payments, usage tracking, rate limiting, or monetizing their application.
---

# Topic: Usage Tracking and Payments

## When to Use
- Phase 4, after aws-deployment
- Learner asks about billing, charging users, usage limits, or monetization
- Learner asks about Stripe, payment integration, or subscription tiers
- Learner asks about rate limiting or controlling API costs

## Prerequisites
- `aws-deployment` topic complete (application deployed with authentication)
- Authentication working (user identity required for per-user tracking)
- Database persistence working (usage data needs to be stored)

## Concept References
- `references/auth-and-payments.md` (payments section) -- read this before teaching
- `wisdom/performance-and-cost.md` -- weave in cost awareness

---

## Teaching Flow

### Open with the Problem
Start with the economics: "Every message your users send costs you money. The LLM API charges per token. If you have 100 users each sending 50 messages a day, that adds up fast. Right now, you have no idea how much each user is costing you, no way to limit usage, and no way to charge for it. You need three things: usage tracking (know how much each user costs), rate limiting (prevent abuse), and payments (let users pay for what they use)."

### Core Points to Cover

**Token usage tracking:**
- Every LLM API call returns token counts (input tokens, output tokens)
- Track these per user, per conversation, per day/month
- Store usage data in the database: user_id, token counts, timestamp
- This is the foundation for everything else -- you cannot bill or limit what you do not measure
- Dashboard or API endpoint to show users their usage

**User tiers and rate limiting:**
- Define tiers: free tier (limited messages/tokens per day), paid tiers (higher limits)
- Rate limiting implementation: check usage before processing a request
- If the user has exceeded their limit, return a clear error with upgrade instructions
- Rate limiting also protects against abuse -- a single user cannot bankrupt you
- Token bucket or sliding window algorithms for rate limiting

**Stripe integration:**
- Stripe is the standard for payment processing -- handles credit cards, subscriptions, invoicing
- Subscription model: users subscribe to a tier, get a monthly allocation
- Key concepts: Products (the tier), Prices (monthly cost), Subscriptions (user's active plan), Webhooks (Stripe notifies your app of events)
- The flow: user selects a plan, Stripe handles payment, webhook confirms subscription, your app updates the user's tier
- Never process credit card details yourself -- Stripe's hosted checkout handles PCI compliance

**The billing flow:**
- User signs up (free tier by default)
- User hits their free tier limit
- User clicks "Upgrade" -- redirected to Stripe Checkout
- Stripe processes payment, sends a webhook to your backend
- Your backend updates the user's tier in the database
- User now has higher limits
- At the end of each billing period, Stripe charges again and sends a webhook

**Cost awareness as a developer:**
- Track your own costs (AWS bills, API bills) not just user costs
- Set alerts for unexpected spikes
- The margin between what users pay and what it costs you is your business model
- Model routing can reduce costs: use cheaper models for simple tasks

### Close
Transition to the build: "Let's add usage tracking first -- you need to know the numbers before you can set limits or charge for them. Then we will add rate limiting and Stripe integration."

---

## Adaptive Notes

**Experienced developers:** They may know Stripe or payment systems. Focus on the AI-specific patterns: token tracking, usage-based billing, and the economics of LLM applications. Build efficiently -- 60-90 minutes.

**Beginners:** The payment flow has many moving parts. Start with usage tracking (simpler) and rate limiting before introducing Stripe. Use Stripe's test mode so no real money is involved. Build will take 90-120 minutes.

**Returning learners (review mode):** Focus on the business model: pricing strategy, cost analysis, margin calculations. Review their Stripe integration for edge cases (failed payments, subscription changes, cancellations).

---

## Build

Add usage tracking, rate limiting, and Stripe payment integration.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Add token usage tracking to the database
2. Build usage tracking into the chat flow
3. Implement user tiers and rate limiting
4. Set up Stripe
5. Build the subscription flow
6. Handle webhooks
7. Test end-to-end

---

## Understanding Checks
- Can the learner explain how token usage is tracked per user?
- Can they describe the rate limiting strategy and what happens when a user hits their limit?
- Can they walk through the Stripe subscription flow from upgrade to payment to webhook?
- Is usage tracking, rate limiting, and payment working in their application?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Token usage tracked per user in the database
- Rate limiting implemented with user tiers
- Stripe integration working (test mode) with subscription flow
- Webhook handling for subscription events
- Users can view their usage and upgrade their plan
- Tested end-to-end
- Code saved in `projects/`
- Mark "Usage Tracking and Payments" complete in `learner/progress.md`
- Add observations about their understanding of AI economics and billing to `learner/notes.md`
- Proceed to `evaluation-monitoring`
