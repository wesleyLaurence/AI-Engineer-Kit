# Tools and Services

Recommended tools for AI engineering. Opinionated choices for each category.

---

## LLM Providers

| Provider | Best Model | Best For | Notes |
|---|---|---|---|
| **Anthropic** | Claude Sonnet/Opus | Complex instructions, coding, long context | Recommended primary provider |
| **OpenAI** | GPT-4o, o3 | Broad capabilities, large ecosystem | Most widely used, good tool calling |
| **Google** | Gemini 2.5 Pro | Massive context windows, multimodal | Up to 2M token context |

**Recommendation:** Start with Anthropic or OpenAI. Use both in production for redundancy. Use small models (Haiku, GPT-4o-mini) for routing and simple tasks.

---

## Frameworks

| Framework | What It Does | When to Use |
|---|---|---|
| **LangChain** | Agent framework, chains, RAG pipelines | Primary recommendation for this curriculum. Model-agnostic, mature, comprehensive. |
| **LangGraph** | Graph-based agent workflows | Complex agent architectures with branching and cycles |
| **LlamaIndex** | Data framework for LLM apps | Strong RAG focus, good for data-heavy applications |

**Recommendation:** LangChain for this curriculum. It's the most mature, model-agnostic toolkit for building agents.

---

## Vector Databases

| Database | Type | Best For |
|---|---|---|
| **Qdrant** | Open-source, self-hosted or cloud | Primary recommendation. High performance, great filtering, runs locally. |
| **Pinecone** | Fully managed cloud | Zero operational overhead, no self-hosting option |
| **Chroma** | Open-source, lightweight | Quick prototyping, not recommended for production scale |
| **pgvector** | PostgreSQL extension | Already using PostgreSQL, want to avoid adding a database |

**Recommendation:** Qdrant. It runs locally for development and scales to production. Great balance of capability and simplicity.

---

## Development Tools

| Tool | What It Does | When to Use |
|---|---|---|
| **Claude Code** | CLI coding agent | Primary recommendation for this curriculum |
| **Cursor** | AI-powered IDE | Prefer a visual IDE over terminal |
| **VS Code** | Code editor | When you want a standard editor alongside Claude Code |
| **httpx** | Async HTTP client for Python | Making API calls in async applications |
| **python-dotenv** | Load .env files | Managing API keys in development |

---

## Backend

| Tool | What It Does | When to Use |
|---|---|---|
| **FastAPI** | Async Python web framework | Primary recommendation for AI backends |
| **uvicorn** | ASGI server | Running FastAPI in development and production |
| **Pydantic** | Data validation | Request/response models (included with FastAPI) |
| **SQLAlchemy** | Database ORM | Database access from Python |

---

## Frontend

| Tool | What It Does | When to Use |
|---|---|---|
| **Next.js** | React framework | Primary recommendation for chat frontends |
| **Tailwind CSS** | Utility-first CSS | Styling the frontend quickly |
| **react-markdown** | Markdown rendering | Displaying formatted agent responses |

---

## Infrastructure

| Service | What It Does | When to Use |
|---|---|---|
| **AWS Amplify** | Frontend hosting + CI/CD | Deploying Next.js |
| **AWS ECS** | Container orchestration | Running the FastAPI backend |
| **AWS RDS** | Managed database | MySQL for conversation storage |
| **AWS Secrets Manager** | Secret storage | API keys, database credentials |
| **AWS Cognito** | Authentication | User management, JWT tokens |
| **Stripe** | Payments | Subscriptions, usage-based billing |

---

## Monitoring and Tracing

| Tool | What It Does | When to Use |
|---|---|---|
| **LangSmith** | LLM tracing and evaluation | If using LangChain (deep integration) |
| **Langfuse** | Open-source LLM observability | Want self-hosted or open-source option |
| **AWS CloudWatch** | Logs and metrics | Infrastructure monitoring on AWS |

---

## The Stack at a Glance

For the guided project in this curriculum:

**Development:** Python + LangChain + Qdrant (local) + Claude Code
**Backend:** FastAPI + uvicorn + SQLAlchemy
**Frontend:** Next.js + Tailwind
**Infrastructure:** AWS (Amplify + ECS + RDS + Cognito + Secrets Manager)
**Payments:** Stripe
**Monitoring:** LangSmith or Langfuse + CloudWatch
