---
name: aws-deployment
description: Teaches full-stack deployment to AWS -- Amplify for frontend, ECS for backend, RDS for database, CI/CD from GitHub. Use when the learner asks about deployment, hosting, AWS infrastructure, or putting their application on the internet.
---

# Topic: AWS Deployment

## When to Use
- Phase 4, after database-persistence
- Learner asks about deployment, hosting, going live, or AWS infrastructure
- Learner asks about Docker, ECS, Amplify, RDS, or CI/CD
- Learner is ready to put their application on the internet

## Prerequisites
- `database-persistence` topic complete (full local stack working: frontend, backend, database, auth)
- AWS account set up (if not, start with `references/setup-aws.md`)
- Application working end-to-end locally

## Concept References
- `references/aws-infrastructure.md` -- read this before teaching
- `wisdom/production-lessons.md` -- weave in production deployment lessons

---

## Teaching Flow

### Open with the Problem
Start with the goal: "Your application works on your laptop. That is great for development but useless for users. Nobody can access localhost. Deployment is the process of running your application on servers that anyone can reach over the internet. Today we are deploying everything -- frontend, backend, database -- to AWS. By the end, your application will have a real URL that anyone can use."

### Core Points to Cover

**The deployment landscape:**
- You have three things to deploy: a Next.js frontend, a FastAPI backend, and a MySQL database
- Each has different deployment needs: static files vs. a running server vs. a managed database
- AWS provides services for each: Amplify (frontend), ECS (backend), RDS (database)
- Plus supporting services: ECR (container images), Secrets Manager (credentials), IAM (permissions)

**Containerization with Docker:**
- Your backend needs to run on a server that is not your laptop
- Docker packages your application and all its dependencies into a container
- A container runs the same way everywhere -- your laptop, a test server, production
- Write a Dockerfile: specify the base image, copy code, install dependencies, define the startup command
- This is how your backend goes from "works on my machine" to "works anywhere"

**AWS services overview:**
- **ECR** (Elastic Container Registry) -- stores your Docker images. Like GitHub but for containers.
- **ECS** (Elastic Container Service) -- runs your containers. It pulls the image from ECR and runs it.
- **RDS** (Relational Database Service) -- managed MySQL. AWS handles backups, patching, availability.
- **Amplify** -- deploys frontend applications. Connects to GitHub and auto-deploys on push.
- **Secrets Manager** -- stores API keys and credentials securely. Your app reads them at runtime.
- **IAM** -- controls what each service is allowed to do. Least privilege.

**CI/CD (Continuous Integration / Continuous Deployment):**
- Push code to GitHub, it automatically deploys. No manual steps.
- Frontend: Amplify watches the GitHub repo and deploys on every push
- Backend: GitHub Actions builds the Docker image, pushes to ECR, updates ECS
- This is how real teams deploy: automated, repeatable, no "deploy from my laptop" workflows

**Connecting everything:**
- Frontend talks to the backend API (environment variable with the API URL)
- Backend talks to RDS (connection string from Secrets Manager)
- Backend uses Cognito for auth (Pool ID and Client ID from environment variables)
- All credentials come from Secrets Manager or environment variables -- nothing hardcoded

### Close
Transition to the build: "Let's deploy. This is the most complex build in the curriculum, but by the end you will have a real, deployed application with a URL you can share. Let's go step by step."

---

## Adaptive Notes

**Experienced developers:** They may know Docker and CI/CD. Focus on the AWS-specific services and how they connect. The build should be methodical but efficient -- 90-120 minutes.

**Beginners:** Deployment is a lot of new concepts at once. Go slowly. Explain each service before using it. Celebrate each milestone (container built, image pushed, service running). Build will take 2-3 hours, possibly across multiple sessions.

**Returning learners (review mode):** Focus on optimization: cost reduction, auto-scaling, monitoring. Review their infrastructure for security and reliability improvements.

---

## Build

Deploy the full application to AWS.

If the learner has not set up their AWS environment yet, start with `references/setup-aws.md` for AWS CLI, IAM, and Secrets Manager configuration.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Prepare the backend for deployment (Dockerfile, env vars, production config)
2. Set up AWS infrastructure (ECR, ECS, RDS, Secrets Manager, IAM)
3. Deploy the backend
4. Deploy the frontend with Amplify
5. Connect everything (frontend to API, API to RDS, Secrets Manager, Cognito)
6. Set up CI/CD (GitHub Actions for backend, Amplify auto-deploy for frontend)
7. Monitoring and alerts

**Milestone:** Working deployed application.

---

## Understanding Checks
- Can the learner explain their deployment architecture -- what runs where and how the pieces connect?
- Can they describe the CI/CD pipeline -- what happens when they push code to GitHub?
- Can they explain why credentials are stored in Secrets Manager instead of environment variables or code?
- Is their application accessible via a public URL?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Application deployed to AWS: frontend on Amplify, backend on ECS, database on RDS
- CI/CD configured: push to GitHub triggers deployment
- Secrets managed through Secrets Manager
- Monitoring and cost alerts configured
- Application accessible via public URL
- Code saved in `projects/`
- Mark "AWS Deployment" complete in `learner/progress.md`
- Add observations about their understanding of deployment and infrastructure to `learner/notes.md`
- **Milestone:** Working deployed application
- Proceed to `usage-tracking-payments`
