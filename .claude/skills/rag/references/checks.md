# Understanding Checks: RAG — Retrieval Augmented Generation

## Check Questions
1. What problem does RAG solve? Why can't you just put all your documents in the prompt?
2. What are embeddings? Explain in your own words how they enable semantic search — finding results by meaning rather than keywords.
3. Walk me through the full RAG pipeline: from a user asking a question to the model responding with an answer based on your documents.
4. Why does chunk size matter? What happens if your chunks are too small? Too large?
5. You have a 200K token context window. Do you still need RAG? Why or why not?
6. Your RAG system returns irrelevant chunks for a query. What are three things you could try to improve retrieval quality?

## Completion Criteria
- The learner can explain embeddings as semantic representations — similar meaning produces similar vectors — without needing to understand the math
- The learner can trace the full RAG pipeline: chunk documents, embed chunks, store in vector database, embed query, retrieve similar chunks, inject into prompt, generate response
- The learner understands that chunking strategy directly affects retrieval quality and can articulate the size tradeoff
- The learner understands why RAG is valuable even with large context windows (cost, scale, focused context)
- The learner has a working RAG system that retrieves relevant information and produces accurate, grounded responses
- The learner can identify when retrieval fails and has strategies for improving it

## What to Update
- `learner/progress.md` — mark "RAG" complete, record milestone "First working RAG system"
- `learner/notes.md` — add observations about their understanding of embeddings and retrieval, any areas that need reinforcement, retrieval quality observations
- `learner/project.md` — document RAG architecture decisions: vector database choice, embedding model, chunk size and overlap, number of retrieved chunks, prompt template for context injection
