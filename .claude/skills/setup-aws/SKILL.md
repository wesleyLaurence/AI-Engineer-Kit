---
name: setup-aws
description: Configures AWS environment for deploying AI applications. Sets up AWS CLI, IAM, Secrets Manager, and billing alerts. Use at the beginning of Phase 4 or when learner needs Secrets Manager for API keys.
compatibility: Requires AWS CLI and an AWS account
---

# Skill: AWS Setup

## What This Skill Does
Gets the learner's AWS environment configured for deploying AI applications.

## When to Use
At the beginning of Phase 4 (Production), or earlier if the learner wants to use Secrets Manager for API keys.

## Prerequisites
- AWS account created
- Learner has basic terminal comfort

## Context to Load
- `concepts/production/aws-infrastructure.md`
- `wisdom/common-pitfalls.md`
- `learner/profile.md`

---

## Process

### Step 1: AWS CLI Setup
Install or verify AWS CLI.
Configure with access keys.
Verify connectivity with a simple command.

### Step 2: IAM Configuration
Create a dedicated IAM user (not root) for development.
Explain the principle of least privilege.
Set up appropriate policies.

**Checkpoint:** Can they list S3 buckets or describe EC2 instances from the CLI?

### Step 3: Secrets Manager
Store API keys (OpenAI, Anthropic) in Secrets Manager.
Write a Python script that retrieves secrets using boto3.
Update their application to load keys from Secrets Manager instead of .env.

**Checkpoint:** Can their application load API keys from Secrets Manager?

### Step 4: Cost Alerts
Set up a billing alarm in CloudWatch:
- Alert when monthly spend exceeds a threshold (e.g., $10, $50)
- This prevents surprise bills

### Step 5: Brief Overview of What's Ahead
Preview the production infrastructure (no setup yet):
- Amplify for frontend
- ECS for backend
- RDS for database
- These get set up during the deployment skill

---

## When Done
- AWS CLI configured
- IAM user with appropriate permissions
- API keys in Secrets Manager
- Cost alerts configured
- Update `learner/progress.md` as applicable
