# Build Details: Authentication

## Overview
Add user authentication to the application using AWS Cognito, with JWT validation on the backend and auth flows on the frontend.

---

### Step 1: Set Up Cognito User Pool
Create a Cognito User Pool in the AWS Console (or via CLI):
- Configure sign-up settings: email as username, required attributes
- Set password policies (minimum length, character requirements)
- Configure an app client (for the frontend to authenticate against)
- Note the User Pool ID, App Client ID, and region -- these are needed by both backend and frontend

Use web search for the current AWS Cognito setup documentation.

Checkpoint: Is the User Pool created with the correct configuration? Can they find the Pool ID and Client ID?

### Step 2: Implement Sign Up and Login Flows
Test the auth flows directly (via AWS CLI or a simple script):
- Sign up a test user
- Confirm the user (email verification)
- Log in and receive tokens (ID token, access token, refresh token)
- Examine the JWT contents (decode it to see the claims)

This step is about understanding the flow before integrating it into the application.

Checkpoint: Can they sign up, log in, and decode a JWT to see its contents?

### Step 3: Add JWT Validation to the FastAPI Backend
Add JWT validation middleware/dependency to FastAPI:
- Fetch Cognito's public keys (JWKS endpoint) to verify token signatures
- Validate the token: check signature, expiration, audience, issuer
- Extract the user ID (sub claim) from the validated token
- Create a FastAPI dependency that extracts and validates the token from the Authorization header

Use web search for current libraries and patterns for Cognito JWT validation in FastAPI.

Checkpoint: Does the backend correctly validate a real Cognito JWT? Does it reject expired or invalid tokens?

### Step 4: Protect API Endpoints
Apply the auth dependency to endpoints that require authentication:
- Chat endpoints (REST and WebSocket) -- require a valid token
- Thread endpoints -- require a valid token
- Health endpoint -- leave public (no auth required)

For WebSocket connections, validate the token during the connection handshake (pass token as query parameter or during the initial message).

Return appropriate HTTP status codes: 401 for missing/invalid tokens, 403 for insufficient permissions.

Checkpoint: Do protected endpoints reject requests without valid tokens? Do public endpoints still work without auth?

### Step 5: Add Auth to the Frontend
Integrate authentication into the Next.js frontend:
- Build sign up and login pages (or use Cognito's hosted UI for simplicity)
- On successful login, store tokens securely
- Add the access token to all API requests (Authorization: Bearer header)
- For WebSocket connections, pass the token during connection setup
- Handle token expiration: use the refresh token to get new access tokens automatically
- Redirect unauthenticated users to the login page

Use web search for current Cognito frontend integration patterns with Next.js.

Checkpoint: Can a user sign up, log in, and make authenticated API requests from the frontend?

### Step 6: Scope Data by User
Now that you know who the user is, scope data to them:
- When creating a thread, associate it with the authenticated user's ID
- When listing threads, only return threads belonging to the authenticated user
- When accessing a thread, verify it belongs to the requesting user
- This is the "authorization" piece -- not just "are you logged in?" but "are you allowed to access this?"

Checkpoint: Does User A see only their own threads? Is User B's data inaccessible?

### Step 7: Test End-to-End
Full flow test:
1. Sign up a new user
2. Log in and verify tokens are stored
3. Create a conversation and send messages
4. Verify the conversation is associated with the user
5. Log out
6. Try to access the API without a token -- verify it is rejected
7. Log in as a different user -- verify they cannot see the first user's threads
