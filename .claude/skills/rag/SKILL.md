---
name: rag
description: Teaches Retrieval Augmented Generation — embeddings, vector databases, chunking, and retrieval pipelines. Use when the learner is ready to build a RAG system or asks about how to give an LLM access to custom data.
---

# Topic: RAG — Retrieval Augmented Generation

## When to Use
- Phase 2, fifth topic (after tool-calling)
- Learner asks about giving an LLM access to their own data, documents, or knowledge base
- Learner asks about embeddings, vector databases, or semantic search
- Revisiting to improve retrieval quality or add new data sources

## Prerequisites
- `tool-calling` topic complete (working chatbot with tools)
- Understands prompt engineering (RAG relies heavily on prompt design for the augmented context)

## Concept References
- `references/rag.md` — read this before teaching
- `wisdom/architecture-decisions.md` (RAG section) — weave in architecture tradeoffs
- `wisdom/common-pitfalls.md` (RAG section) — weave in common RAG mistakes

---

## Teaching Flow

### Open
Start with the problem: "Your agent can search the web and call APIs. But what about YOUR data — your company's documents, your personal notes, your product's documentation? The model does not know any of it. You could paste it all into the prompt, but what if you have thousands of pages? That is where RAG comes in. Retrieval Augmented Generation: find the relevant pieces of your data and inject them into the prompt, so the model can answer based on your information."

### Core Points to Cover

**The problem RAG solves:**
- LLMs do not know your private data. They were trained on public internet text.
- You could put everything in the context window, but context windows have limits and costs.
- Even with very large context windows, retrieval is often better — finding the right 5 paragraphs is more effective than dumping 100 pages and hoping the model finds the needle.

**Embeddings — the key concept:**
- Text gets converted into vectors (arrays of numbers) that capture semantic meaning.
- Similar text produces similar vectors. "How do I reset my password?" and "I forgot my login credentials" are close in vector space, even though they share few words.
- This is what makes semantic search possible — matching by meaning, not just keywords.
- Do not go deep into the math. The intuition is what matters: embeddings capture meaning as geometry.

**Vector databases:**
- Regular databases search by exact match or keywords. Vector databases search by similarity.
- You store your embedded text chunks. When a query comes in, you embed the query and find the most similar chunks.
- Recommend Qdrant for local development — it runs in-memory with no infrastructure needed.
- Other options exist (Pinecone, Weaviate, Chroma) — the concepts transfer across all of them.

**Chunking strategies:**
- You cannot embed an entire document as one vector — it would lose too much detail.
- You split documents into chunks. Each chunk gets its own embedding.
- Chunk size matters: too small and you lose context, too large and you lose specificity.
- Overlap between chunks prevents information from being split across boundaries.
- Start with ~500 tokens and 50 token overlap. Iterate based on results.
- Attach metadata to chunks (source document, section, page number) — this enables citation and filtering.

**The retrieval pipeline:**
- User asks a question.
- Embed the question using the same embedding model.
- Search the vector database for the top-K most similar chunks.
- Inject those chunks into the prompt as context.
- The model answers based on the provided context.
- This is where prompt engineering meets RAG — how you frame the retrieved context in the prompt matters enormously.

**RAG vs. large context windows:**
- Large context windows (100K+ tokens) make it tempting to skip RAG and dump everything in.
- RAG is still valuable: it is cheaper (only relevant chunks, not everything), it scales to larger datasets, and focused context often produces better answers than a huge context with noise.
- The right approach often combines both: RAG for retrieval, large context for including the results plus conversation history.

### Close
Connect to the build: "Let's build a RAG system for your project. You will choose documents, chunk them, embed them, store them, and wire retrieval into your agent. By the end, your agent will answer questions about your own data."

---

## Adaptive Notes

**Experienced developers:** They may already understand databases and search. Focus on what is new: embeddings as semantic representation, the chunking-quality tradeoff, and the prompt engineering required to use retrieved context well. Move through the concepts briskly and spend more time on the build and iteration.

**Beginners:** Embeddings are the hardest concept here. Use the analogy of a library: chunking is like splitting a book into index cards, embeddings are like organizing those cards by topic on a map, and retrieval is like finding the closest cards to your question on that map. Spend real time on this before rushing to the build.

**Returning learners (review mode):** Focus on quality. Are their chunks the right size? Is retrieval returning relevant results? How does the model handle questions the documents cannot answer? Iterate on chunk size, retrieval count, and prompt design.

---

## Build

Build a complete RAG system — from document ingestion to retrieval-augmented responses.

See `references/build-details.md` for the complete step-by-step build guide.

**Milestone:** First working RAG system.

---

## Understanding Checks
- Can they explain what embeddings are and why they enable semantic search?
- Can they describe the full RAG pipeline from document ingestion to augmented response?
- Do they understand why chunking strategy matters and how chunk size affects quality?

See `references/checks.md` for detailed check criteria.

---

## When Done
- Mark "RAG" complete in `learner/progress.md`
- Working RAG system that answers questions from their documents
- Add observations about their understanding of embeddings and retrieval to `learner/notes.md`
- Update `learner/project.md` with RAG architecture decisions (vector database, chunk size, embedding model)
- **Milestone:** First working RAG system
- Proceed to Phase 3: `agentic-workflows`
