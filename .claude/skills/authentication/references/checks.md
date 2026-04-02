# Understanding Checks: Authentication

## Check Questions
1. Walk through the authentication flow: what happens from when a user clicks "Sign Up" to when they make their first authenticated API request?
2. What is a JWT? What information does it contain? How does the backend verify it without calling Cognito?
3. Why do tokens expire? What happens when a token expires, and how does the frontend handle it?
4. What is the difference between authentication and authorization? Give an example of each in your application.
5. How are threads scoped to users? What prevents User A from seeing User B's conversations?
6. What would happen if someone intercepted a JWT? How do you mitigate that risk?

## Completion Criteria
- The learner can explain the JWT authentication flow clearly
- They understand token signing, verification, expiration, and refresh
- Cognito User Pool is configured and working
- Sign up and login flows are functional
- The FastAPI backend validates JWTs and rejects unauthorized requests
- The frontend handles login, stores tokens securely, and sends them with requests
- Threads are scoped to the authenticated user
- The application works end-to-end with authentication

## What to Update
- `learner/progress.md` -- mark "Authentication" complete
- `learner/notes.md` -- record their understanding of auth flows, any challenges with Cognito setup, insights about security
