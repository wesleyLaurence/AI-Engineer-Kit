# Understanding Checks: AWS Deployment

## Check Questions
1. Draw (or describe) your deployment architecture. What AWS services are you using and how do they connect?
2. What is Docker and why do you need it? What does your Dockerfile do?
3. Walk through the CI/CD pipeline: what happens from the moment you push code to GitHub to the moment the new version is live?
4. Why are credentials stored in Secrets Manager instead of hardcoded in code or environment variables?
5. What happens if your backend crashes? How does ECS handle that?
6. Where are your cost alerts? What is your estimated monthly cost?

## Completion Criteria
- The learner can explain their full deployment architecture and how each component connects
- They understand containerization and can explain their Dockerfile
- The application is deployed and accessible via a public URL
- CI/CD is configured: a push to GitHub triggers an automated deployment
- Credentials are managed through Secrets Manager, not hardcoded
- Monitoring is set up: CloudWatch logs, health checks, cost alerts
- The learner can deploy a code change and see it go live through the CI/CD pipeline

## Milestone Verification
- **Working deployed application** -- the application is live, accessible via URL, and users can sign up, log in, and chat with the agent

## What to Update
- `learner/progress.md` -- mark "AWS Deployment" complete, note the milestone
- `learner/notes.md` -- record their deployment architecture decisions, any AWS challenges, insights about infrastructure management
