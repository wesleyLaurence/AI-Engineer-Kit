---
name: build-full-stack
description: Guides deploying a complete AI application to AWS including frontend, backend, database, and CI/CD infrastructure. Use after frontend and backend are working locally with auth and database configured.
compatibility: Requires AWS CLI, Docker, and GitHub access
---

# Skill: Deploy Full Stack Application

## What This Skill Does
Guides the learner through deploying their complete application to AWS — frontend, backend, database, and infrastructure.

## When to Use
After the frontend and backend are working locally, and auth/database are configured.

## Prerequisites
- FastAPI backend complete
- Next.js frontend complete
- Database persistence working
- Authentication configured
- AWS account set up

## Context to Load
- `concepts/production/aws-infrastructure.md`
- `concepts/production/auth-and-payments.md`
- `wisdom/production-lessons.md`
- `learner/project.md`

---

## Process

### Step 1: Prepare the Backend for Deployment
Create a Dockerfile for the FastAPI application.
Configure environment variables for production (database URL, API keys via Secrets Manager).
Use web search for current Docker + FastAPI best practices.

**Checkpoint:** Does the Docker container run locally?

### Step 2: Set Up AWS Infrastructure
Use the AWS CLI or console:
- Create an ECR repository for the Docker image
- Set up an ECS cluster and service
- Configure an RDS MySQL instance
- Store API keys in Secrets Manager
- Set up IAM roles with least-privilege permissions

Walk through each piece, explaining what it does and why.

### Step 3: Deploy the Backend
Push the Docker image to ECR.
Configure the ECS task definition.
Deploy the service.
Verify the API is accessible.

**Checkpoint:** Can they hit the health endpoint from the internet?

### Step 4: Deploy the Frontend
Connect the Next.js project to AWS Amplify.
Configure environment variables (API URL).
Set up automatic deployments from GitHub.

**Checkpoint:** Does the frontend load in a browser?

### Step 5: Connect Everything
- Frontend connects to the deployed API
- API connects to RDS for persistence
- API reads secrets from Secrets Manager
- Authentication flows through Cognito

Test the full flow end-to-end in production.

### Step 6: Set Up CI/CD
GitHub Actions for the backend (build, push to ECR, deploy to ECS).
Amplify auto-deploy for the frontend.
Explain the deployment pipeline.

### Step 7: Monitoring and Alerts
Set up basic monitoring:
- CloudWatch logs for the API
- Cost alerts in AWS Billing
- Health check alarms

---

## When Done
- Application fully deployed and accessible on the internet
- CI/CD pipeline working
- Basic monitoring in place
- Update `learner/progress.md`: mark AWS deployment complete
- Update `learner/project.md` with deployment details
- **Milestone:** Deployed application
