# Build Details: Usage Tracking and Payments

## Overview
Add token usage tracking, user tiers with rate limiting, and Stripe payment integration for subscription billing.

---

### Step 1: Add Token Usage Tracking to the Database
Create a usage tracking table:
- `usage` table: id, user_id, thread_id, input_tokens, output_tokens, model, timestamp
- Index on user_id and timestamp (for querying usage by user over time periods)
- Consider a summary table or view for quick lookups: total tokens per user per month

Alternatively, add token columns to the messages table if simpler.

Checkpoint: Does the schema support querying "how many tokens has User X used this month?"

### Step 2: Build Usage Tracking into the Chat Flow
After every LLM API call, record the token usage:
- Extract token counts from the API response (input tokens, output tokens)
- Insert a usage record with the user ID, thread ID, model, and counts
- This should not slow down the response -- insert asynchronously if needed

Build an endpoint to query usage:
- GET `/usage` -- returns the authenticated user's usage for the current period
- Include total tokens, breakdown by day, estimated cost

Checkpoint: After sending a few messages, does the usage endpoint show correct token counts?

### Step 3: Implement User Tiers and Rate Limiting
Define tiers with limits:
- Free tier: e.g., 10K tokens per day or 50 messages per day
- Pro tier: e.g., 100K tokens per day or 500 messages per day
- Unlimited tier: no hard limits (still track usage)

Add a tier field to the user record (or a separate subscriptions table).

Implement rate limiting as a FastAPI middleware or dependency:
- Before processing a chat request, check the user's usage against their tier limit
- If under the limit, proceed normally
- If at or over the limit, return a 429 (Too Many Requests) with a clear message and upgrade instructions
- For WebSocket, check before processing each message

Checkpoint: Does a free-tier user get blocked after exceeding their limit? Does the error message include upgrade information?

### Step 4: Set Up Stripe
Create a Stripe account (test mode):
- Get the test API keys (publishable key and secret key)
- Store the secret key in Secrets Manager (or environment variables for local dev)
- Install the Stripe Python SDK

Create products and prices in Stripe:
- A product for each tier (Pro, Unlimited)
- A price for each product (monthly subscription amount)

Use web search for current Stripe Python SDK documentation.

Checkpoint: Are the Stripe products and prices created? Can they list them via the API?

### Step 5: Build the Subscription Flow
Create the upgrade flow:
- Backend endpoint to create a Stripe Checkout Session
- The endpoint specifies the price, the user, and the success/cancel URLs
- Frontend "Upgrade" button that calls this endpoint and redirects to Stripe Checkout
- Stripe handles the payment form, card processing, and PCI compliance
- On success, Stripe redirects back to the application

Do NOT handle credit card details in your code. Stripe Checkout handles everything securely.

Checkpoint: Can a user click "Upgrade," complete the Stripe Checkout (with test card), and be redirected back?

### Step 6: Handle Webhooks
Set up a webhook endpoint to receive Stripe events:
- POST `/webhooks/stripe` -- receives Stripe events
- Verify the webhook signature (to prevent spoofed events)
- Handle key events:
  - `checkout.session.completed` -- user completed payment, update their tier
  - `customer.subscription.updated` -- subscription changed (upgrade, downgrade)
  - `customer.subscription.deleted` -- subscription cancelled, revert to free tier
  - `invoice.payment_failed` -- payment failed, notify user, possibly downgrade

For local testing, use the Stripe CLI to forward webhooks to localhost.

Checkpoint: After completing a Stripe Checkout, does the webhook fire and update the user's tier in the database?

### Step 7: Test End-to-End
Full flow test:
1. Sign up as a new user (starts on free tier)
2. Send messages until the free tier limit is reached
3. Verify the rate limit kicks in with a clear error message
4. Click "Upgrade" and complete Stripe Checkout with a test card (4242 4242 4242 4242)
5. Verify the webhook updates the user's tier to Pro
6. Verify the rate limit is now higher
7. Check usage tracking: verify token counts are accurate
8. Test cancellation: cancel the subscription in Stripe, verify the webhook reverts the tier
