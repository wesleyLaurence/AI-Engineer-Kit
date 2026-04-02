# AWS Setup Guide

## Overview
Set up the AWS environment for deploying the application. This covers AWS CLI, IAM, Secrets Manager, and cost alerts.

---

### Step 1: AWS CLI Setup
Install or verify the AWS CLI:
- Check if already installed (`aws --version`)
- If not, install the latest version (use web search for current installation instructions)
- Configure with `aws configure` -- provide access key, secret key, default region
- Test connectivity: `aws sts get-caller-identity` should return account details

Checkpoint: Does `aws sts get-caller-identity` return their account information?

### Step 2: IAM Configuration
Set up a dedicated IAM user for deployments:
- Create a new IAM user (or use an existing one with appropriate permissions)
- Apply least-privilege permissions -- only the services needed for this deployment
- Key policies needed: ECR, ECS, RDS, Secrets Manager, Amplify, CloudWatch, IAM (for role creation)
- Store the access keys securely -- these should be in `~/.aws/credentials`, not in code

For learning purposes, broader permissions are acceptable. For production, scope down to exactly what is needed.

Checkpoint: Is the IAM user configured with appropriate permissions?

### Step 3: Secrets Manager
Store API keys and credentials in AWS Secrets Manager:
- Create a secret for the LLM API key (e.g., Anthropic API key)
- Create a secret for database credentials (will be used when RDS is set up)
- Write a Python utility function to retrieve secrets at runtime
- Update the application to read API keys from Secrets Manager instead of environment variables or .env files

This is a security improvement -- API keys are no longer in code, config files, or environment variables on your laptop.

Checkpoint: Can the application retrieve secrets from Secrets Manager and use them?

### Step 4: Cost Alerts
Set up billing monitoring to avoid surprise charges:
- Create a billing alarm in CloudWatch
- Set the threshold to an appropriate amount for learning (e.g., $25/month)
- Configure notification via email (SNS topic)
- Review the AWS Free Tier limits for the services being used

Checkpoint: Is the billing alarm configured and will it send an email if costs exceed the threshold?

### Step 5: Brief Overview
Preview the production infrastructure that will be built:
- ECR for container images
- ECS for running the backend
- RDS for the database
- Amplify for the frontend
- The learner does not need to set these up yet -- this is a mental model for what is coming

This step is informational. The actual infrastructure setup happens in the deployment build.
