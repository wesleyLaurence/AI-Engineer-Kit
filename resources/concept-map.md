# Concept Map

How every topic in the curriculum connects. Read top-to-bottom for the learning progression. Arrows show dependencies — what builds on what.

---

## The Full Picture

```
                        ┌─────────────────────┐
                        │   PHASE 0            │
                        │   Orientation         │
                        │                       │
                        │   Coding Agents ──────┼──── The meta-skill that
                        │   How This Works      │     powers everything
                        └──────────┬────────────┘
                                   │
                        ┌──────────▼────────────┐
                        │   PHASE 1              │
                        │   Foundations           │
                        │                        │
                        │   Python for AI        │
                        │        │               │
                        │   Environment Setup    │
                        │        │               │
                        │   Foundation Models    │
                        │        │               │
                        │   First LLM Call ◆─────┼──── Milestone: It works!
                        └──────────┬─────────────┘
                                   │
              ┌────────────────────▼─────────────────────┐
              │   PHASE 2: Core Skills                    │
              │                                           │
              │   Prompt Engineering                      │
              │        │                                  │
              │   Memory & Threads ──► Chatbot ◆          │
              │        │                                  │
              │   Streaming                               │
              │        │                                  │
              │   Tool Calling ──────► Agent w/ Tools ◆   │
              │        │                                  │
              │   RAG ───────────────► RAG System ◆       │
              └────────────────────┬──────────────────────┘
                                   │
    ┌──────────────────────────────▼──────────────────────────────┐
    │   PHASE 3: Agent Architecture                                │
    │                                                              │
    │   Agentic Workflows (when to use agents)                     │
    │        │                                                     │
    │   ReAct Agents ────────────► Full Agent ◆                    │
    │        │                                                     │
    │   ┌────┴──────────────┬─────────────────┐                    │
    │   │                   │                 │                    │
    │   MCP Servers    Agent Skills    Context Engineering         │
    │                  & AGENTS.md                                 │
    │   │                   │                 │                    │
    │   └────┬──────────────┴─────────────────┘                    │
    │        │                                                     │
    │   Human in the Loop                                          │
    │        │                                                     │
    │   Subagents & Multi-Agent                                    │
    │        │                                                     │
    │   Deep Agents ─────────────► Complete Agent System ◆         │
    └──────────────────────────────┬───────────────────────────────┘
                                   │
    ┌──────────────────────────────▼───────────────────────────────┐
    │   PHASE 4: Production                                        │
    │                                                              │
    │   FastAPI Backend ─────────► Agent as API ◆                  │
    │        │                                                     │
    │   WebSocket Streaming                                        │
    │        │                                                     │
    │   Next.js Frontend                                           │
    │        │                                                     │
    │   ┌────┴──────────────┬─────────────────┐                    │
    │   │                   │                 │                    │
    │   Authentication   Database &      AWS Deployment            │
    │   (Cognito)        Persistence     (Amplify + ECS)           │
    │   │                   │                 │                    │
    │   └────┬──────────────┴─────────────────┘                    │
    │        │                                                     │
    │   Usage Tracking & Payments (Stripe)                         │
    │        │                                                     │
    │   Eval, Tracing & Monitoring                                 │
    │        │                                                     │
    │   Security & Guardrails                                      │
    │        │                                                     │
    │   Cost Optimization                                          │
    │        │                                                     │
    │   ◆ DEPLOYED PRODUCTION APPLICATION                          │
    └──────────────────────────────────────────────────────────────┘
```

◆ = Milestone (something concrete you've built)

---

## Cross-Cutting Themes

These topics weave through multiple phases:

| Theme | Where It Appears |
|---|---|
| **Context management** | Memory (P2), RAG (P2), Context Engineering (P3), Cost Optimization (P4) |
| **Cost awareness** | Model selection (P1), Token management (P2), Agent loops (P3), Cost Optimization (P4) |
| **Security** | API keys (P1), Tool permissions (P2), Human-in-the-loop (P3), Security (P4) |
| **User experience** | Streaming (P2), Frontend (P4), Error handling (P4) |
| **Testing & quality** | Behavioral testing (P3), Evaluation (P4), Monitoring (P4) |

---

## Dependency Summary

| To learn this... | You need this first... |
|---|---|
| Prompt Engineering | First LLM Call |
| Memory & Threads | Prompt Engineering |
| Tool Calling | Memory & Threads |
| RAG | Tool Calling, Embeddings concept |
| ReAct Agents | Tool Calling |
| MCP Servers | ReAct Agents |
| Subagents | ReAct Agents |
| FastAPI Backend | Working agent locally |
| WebSocket Streaming | FastAPI Backend |
| Frontend | WebSocket Streaming |
| Deployment | Frontend + Backend + Database |
| Payments | Authentication |
| Cost Optimization | Monitoring |

---

## The Key Insight

Everything builds bottom-up. You can't understand agents without understanding tools. You can't understand tools without understanding LLM calls. You can't deploy what you haven't built. The curriculum respects these dependencies — that's why the sequence matters.
