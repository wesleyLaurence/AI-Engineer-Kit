# Authentication and Payments

## The Problem: Turning Your Agent into a Business

Your AI application works. Users can chat with your agent. But anyone can access it, there's no way to know who's using it, and you're paying for all the LLM calls yourself. To turn this into a product, you need authentication (who is this user?) and payments (how do they pay?).

---

## Authentication with AWS Cognito

Cognito is AWS's managed authentication service. It handles user registration, password hashing, email verification, session management, and JWT token generation.

### How It Works

**User Pool** — The user directory. Stores usernames, passwords (hashed), emails, and custom attributes.

**Sign Up** — User provides email and password. Cognito creates the account, sends a verification email, stores credentials securely.

**Sign In** — User provides credentials. Cognito validates and returns JWT tokens: an access token (API authorization), an ID token (user details), and a refresh token.

**Token Validation** — Your API validates the JWT token on every request. The token contains the user's identity and permissions.

### The Frontend Flow

1. User clicks "Sign In"
2. Frontend sends credentials to Cognito
3. Cognito returns JWT tokens
4. Frontend includes the access token in every API request
5. API validates the token and identifies the user

---

## Protecting API Endpoints

Every API request includes a JWT token in the Authorization header. Middleware extracts, validates, and checks expiration. Requests without a valid token get a 401 response.

### User Tiers and Access Control

- **Free tier** — Limited messages per day, basic model only
- **Pro tier** — More messages, better models, additional features
- **Enterprise** — Unlimited, custom models, priority support

---

## Payments with Stripe

Stripe handles collecting payment information, processing charges, managing subscriptions, and handling refunds.

### Payment Models for AI Applications

| Model | How It Works | Best For |
|---|---|---|
| Subscription | Fixed monthly price per tier | Predictable revenue, simple |
| Usage-based | Charge per token or message | Fair pricing, aligns cost with value |
| Hybrid | Base subscription + overage | Balance of predictability and fairness |
| Credits | Pre-purchased, consumed by usage | User controls spending |

### The Integration Flow

1. User selects a plan
2. Frontend creates a Stripe Checkout session
3. User enters payment info on Stripe's hosted page
4. Stripe processes payment and calls your webhook
5. Webhook updates user's tier in your database

### Webhooks

Stripe notifies your server about payment events: payment succeeded (upgrade tier), payment failed (notify user), subscription cancelled (downgrade). Always verify webhook signatures.

---

## Usage Tracking

Track tokens used per request, requests per user per time period, model used, and tool calls. Log every API request with token counts. Check against user limits before processing.

---

## Key Takeaways

- Cognito handles auth so you don't roll your own — sign up, sign in, JWT tokens
- JWT tokens in every API request let your backend identify and authorize users
- Stripe handles payments — subscriptions, usage-based billing, PCI compliance
- Usage tracking is essential for billing, limits, and cost management
- Start simple (subscription tiers) and add complexity as you understand your cost structure
