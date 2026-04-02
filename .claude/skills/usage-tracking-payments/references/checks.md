# Understanding Checks: Usage Tracking and Payments

## Check Questions
1. How do you track token usage per user? Where is the data stored and what does it include?
2. Explain your tier system. What are the limits for each tier and how are they enforced?
3. What happens when a free-tier user hits their limit? What do they see? What happens on the backend?
4. Walk through the Stripe subscription flow: what happens from when a user clicks "Upgrade" to when their tier is updated?
5. What is a webhook? Why does Stripe use webhooks instead of just returning a success response?
6. If you are paying $0.01 per 1K tokens and charging users $20/month for 500K tokens, what is your margin? What could change that?

## Completion Criteria
- The learner can explain token usage tracking and why it matters for AI applications
- Usage is tracked per user with token counts stored in the database
- Rate limiting is implemented: free-tier users are limited, paid users have higher limits
- Stripe is integrated in test mode with working subscription flow
- Webhooks are handled: subscription created, updated, cancelled
- Users can view their usage and upgrade their plan
- The learner understands the economics: cost per token, pricing strategy, margins

## What to Update
- `learner/progress.md` -- mark "Usage Tracking and Payments" complete
- `learner/notes.md` -- record their pricing decisions, insights about AI application economics, any Stripe integration challenges
