---
name: authentication
description: Teaches user authentication with AWS Cognito -- sign up, login, session management, JWT validation, and protecting API endpoints. Use when the learner asks about authentication, user management, login flows, or securing their application.
---

# Topic: Authentication

## When to Use
- Phase 4, after frontend-chat-ui
- Learner asks about authentication, login, user management, or protecting their API
- Learner asks about AWS Cognito, JWTs, or session management
- Learner needs to add user accounts to their application

## Prerequisites
- `frontend-chat-ui` topic complete (working frontend and backend)
- FastAPI backend running with endpoints
- Frontend connected to backend

## Concept References
- `references/auth-and-payments.md` (auth section) -- read this before teaching
- `wisdom/production-lessons.md` -- weave in production security lessons

---

## Teaching Flow

### Open with the Problem
Start with the reality: "Right now, anyone who knows your API URL can use your agent. There are no users, no accounts, no way to tell who is making requests. In production, you need to know who your users are -- for security, for billing, for personalization, for legal compliance. Authentication is how you solve this. And we are going to use AWS Cognito so you do not have to build it yourself."

### Core Points to Cover

**Why authentication matters:**
- Without auth, your API is open to the world -- anyone can use it, and you have no idea who
- You need user identity for: billing (who to charge), personalization (user-specific threads), security (access control), and compliance
- Authentication is "who are you?" -- authorization is "what are you allowed to do?"
- Never build your own auth system from scratch. Use a managed service.

**Why AWS Cognito:**
- Managed authentication service -- handles user pools, sign up, login, password reset, MFA
- Issues JWTs (JSON Web Tokens) that your API can verify
- Integrates with the rest of the AWS ecosystem (which they will use for deployment)
- Free tier covers most learning and small production use cases
- Alternatives exist (Auth0, Firebase Auth, Clerk) but Cognito fits the AWS deployment story

**How JWT authentication works:**
- User signs up and logs in through Cognito
- Cognito issues a JWT -- a signed token that contains the user's identity and claims
- The frontend stores the JWT and sends it with every API request
- The backend verifies the JWT signature (without calling Cognito -- the token is self-contained)
- If the token is valid, the request proceeds. If not, it is rejected.
- Tokens expire -- the frontend uses a refresh token to get new access tokens without re-login

**Protecting API endpoints:**
- Add a dependency/middleware to FastAPI that validates the JWT on every request
- Extract the user ID from the token and use it to scope data (this user's threads, not all threads)
- Some endpoints may be public (health check), others require authentication (chat, threads)
- Return 401 Unauthorized for missing/invalid tokens, 403 Forbidden for insufficient permissions

**Frontend auth integration:**
- Sign up and login forms (or use Cognito's hosted UI)
- Store tokens securely (httpOnly cookies or secure storage)
- Add tokens to API requests (Authorization header)
- Handle token expiration and refresh
- Redirect unauthenticated users to login

### Close
Transition to the build: "Let's add authentication to your application. By the end, users will sign up, log in, and your API will know exactly who is making each request."

---

## Adaptive Notes

**Experienced developers:** They likely understand auth concepts. Focus on Cognito-specific setup and JWT validation patterns in FastAPI. The build should move quickly -- 45-60 minutes.

**Beginners:** Auth is conceptually dense. Spend time on the mental model: what a token is, why it is signed, how verification works without calling the auth server. Use diagrams. Build will take 90-120 minutes.

**Returning learners (review mode):** Focus on security hardening: token storage best practices, refresh token rotation, MFA setup. Review their implementation for common auth vulnerabilities.

---

## Build

Add authentication to the learner's application using AWS Cognito.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Set up Cognito User Pool
2. Implement sign up and login flows
3. Add JWT validation to the FastAPI backend
4. Protect API endpoints
5. Add auth to the frontend
6. Scope data by user (user-specific threads)
7. Test end-to-end

---

## Understanding Checks
- Can the learner explain the JWT authentication flow from login to API request?
- Can they describe what happens when the backend receives a request with a token?
- Can they explain why tokens expire and how refresh tokens work?
- Is their application authenticating users end-to-end?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Cognito User Pool configured
- Sign up and login working
- API endpoints protected with JWT validation
- Frontend handles auth (login, token storage, token refresh)
- Threads scoped to individual users
- Tested end-to-end
- Code saved in `projects/`
- Mark "Authentication" complete in `learner/progress.md`
- Add observations about their understanding of auth concepts to `learner/notes.md`
- Proceed to `database-persistence`
