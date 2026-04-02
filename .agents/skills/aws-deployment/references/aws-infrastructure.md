# AWS Infrastructure

## The Problem: Going from Localhost to the Internet

Your full-stack AI application works on your laptop. Now it needs to work on the internet — reliably, securely, and at scale. AWS provides the building blocks, but assembling them correctly requires understanding what each piece does and how they connect.

---

## The Architecture

### Frontend: AWS Amplify
Amplify hosts your Next.js frontend. It handles static and server-side rendered content, CDN distribution, automatic deployments from GitHub, custom domains, and SSL certificates. Push to GitHub, Amplify builds and deploys automatically.

### Backend: ECS or Lambda

**ECS (Elastic Container Service)** — Runs your FastAPI backend in Docker containers. Better for AI workloads because: persistent WebSocket connections, long-running requests (LLM calls take 30+ seconds), consistent performance (no cold starts), full control over runtime.

**Lambda** — Serverless functions. Better for simple, short-lived endpoints, low-traffic applications, and background tasks.

**Recommendation:** Use ECS for your main API and Lambda for background tasks.

### Database: RDS MySQL
Manages your MySQL database for conversation storage, user data, and application state. Automated backups and maintenance included.

### Secrets: AWS Secrets Manager
Stores API keys, database credentials, and other secrets. Your application retrieves them at runtime. Never hardcode secrets.

### Permissions: IAM
Controls what each component can access. Principle of least privilege: each component gets only the permissions it needs.

---

## How the Pieces Connect

1. User loads the frontend from Amplify
2. Frontend connects to the API via WebSocket (ECS)
3. API authenticates the user (Cognito)
4. API reads API keys from Secrets Manager
5. API calls the LLM and streams the response
6. API reads/writes conversation data in RDS
7. Response streams back to the frontend

---

## CI/CD from GitHub

1. Developer pushes to GitHub
2. Amplify detects the push, builds and deploys the frontend
3. A GitHub Action builds the Docker image for the API
4. The image is pushed to ECR (Elastic Container Registry)
5. ECS pulls the new image and deploys it

---

## Cost Considerations for AI Workloads

- **LLM API costs** dominate — usually 80%+ of total costs
- **ECS costs** depend on container size and count — right-size for I/O-bound workloads
- **RDS costs** depend on instance size — start small and scale up
- **Data transfer** costs can surprise you — be aware of cross-region charges

---

## Key Takeaways

- Amplify for frontend, ECS for API, RDS for database, Secrets Manager for secrets — the standard stack
- ECS beats Lambda for AI backends (WebSocket support, long-running requests, no cold starts)
- CI/CD from GitHub makes deployments automatic and reliable
- IAM follows least privilege — each component gets only the permissions it needs
- LLM API costs usually dwarf infrastructure costs — optimize there first
