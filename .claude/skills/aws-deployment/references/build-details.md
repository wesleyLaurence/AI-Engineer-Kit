# Build Details: AWS Deployment

## Overview
Deploy the full application to AWS: frontend on Amplify, backend on ECS, database on RDS, with CI/CD from GitHub.

---

### Step 1: Prepare Backend for Deployment
Create a Dockerfile for the FastAPI backend:
- Base image with Python
- Copy application code
- Install dependencies from requirements.txt
- Expose the correct port
- Define the startup command (uvicorn)

Update the application to read configuration from environment variables:
- Database connection string
- Cognito settings
- API keys (from Secrets Manager)
- CORS origins (the frontend URL)

Create a production configuration that differs from development (e.g., debug off, proper CORS origins).

Test locally: build the Docker image and run it. Verify the application works in the container.

Checkpoint: Does the containerized backend run and respond to requests locally?

### Step 2: Set Up AWS Infrastructure
Create the required AWS resources:
- **ECR repository** -- to store Docker images for the backend
- **ECS cluster and service** -- to run the backend containers (Fargate for serverless containers)
- **RDS MySQL instance** -- managed database (start with the smallest instance to minimize cost)
- **Secrets Manager** -- store API keys, database credentials, and other secrets
- **IAM roles** -- ECS task role (what the container can access), ECS execution role (what ECS needs to pull images and read secrets)
- **Security groups** -- network rules controlling what can talk to what

Use web search for current AWS CLI commands or console steps for each service.

Checkpoint: Are all resources created? Can they list them and describe what each one does?

### Step 3: Deploy the Backend
Push the Docker image to ECR:
- Build the image
- Tag it for the ECR repository
- Push to ECR

Configure the ECS task definition:
- Specify the container image (from ECR)
- Set environment variables and secrets
- Configure memory and CPU
- Set up health check

Deploy the ECS service:
- Create or update the service
- Verify the task is running
- Check the health endpoint via the service's public URL or load balancer

Checkpoint: Is the backend running on ECS and responding to health check requests?

### Step 4: Deploy the Frontend
Deploy the Next.js frontend with AWS Amplify:
- Connect Amplify to the GitHub repository
- Configure build settings for Next.js
- Set environment variables (API URL pointing to the deployed backend)
- Trigger the first deployment
- Verify the frontend loads in a browser

Amplify handles the build, hosting, and SSL certificate automatically.

Checkpoint: Does the frontend load in a browser via the Amplify URL?

### Step 5: Connect Everything
Wire all the services together:
- Frontend environment variable points to the backend API URL
- Backend reads database credentials from Secrets Manager
- Backend connects to RDS MySQL
- Backend validates Cognito tokens with the correct User Pool
- CORS on the backend allows requests from the Amplify frontend URL
- WebSocket connections work through any load balancer or API gateway

Test the full flow: sign up on the frontend, log in, create a conversation, send messages, verify everything works.

Checkpoint: Does the full application work end-to-end when accessed via the public URLs?

### Step 6: Set Up CI/CD
Automate deployments:

**Backend (GitHub Actions):**
- On push to main, build the Docker image
- Push the new image to ECR
- Update the ECS service to use the new image
- The service performs a rolling update (no downtime)

**Frontend (Amplify auto-deploy):**
- Amplify is already configured to deploy on push to the connected branch
- Verify it works: make a small change, push, watch it deploy

Checkpoint: Can they push a code change and see it automatically deployed without any manual steps?

### Step 7: Monitoring and Alerts
Set up basic monitoring:
- **CloudWatch Logs** -- backend logs are automatically sent to CloudWatch via ECS. Verify they are there.
- **Health checks** -- ECS health check monitors the /health endpoint. If it fails, ECS restarts the container.
- **Cost alerts** -- set up a billing alarm in CloudWatch to alert if costs exceed a threshold (e.g., $25/month during learning)
- **Basic dashboard** -- optionally create a CloudWatch dashboard showing request count, error rate, and latency

Checkpoint: Can they view their backend logs in CloudWatch? Is the cost alert configured?
