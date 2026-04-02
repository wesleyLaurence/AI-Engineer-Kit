# RAG — Retrieval Augmented Generation

## The Problem: The Model Doesn't Know Your Data

LLMs know a lot about the world in general, but they know nothing about your specific data. Your company's documentation, your user's files, your product's knowledge base — none of this exists in the model's training data.

You could fine-tune a model on your data, but that's expensive, slow, and needs to be redone whenever your data changes. You could paste your entire knowledge base into the prompt, but context windows have limits, it costs a fortune in tokens, and model performance degrades with very long contexts.

RAG is the solution. It retrieves only the relevant pieces of your data and injects them into the model's context right when they're needed. The model generates its response augmented by this retrieved information — hence the name.

RAG is one of the most widely used patterns in AI engineering because it solves the most common problem: making an LLM useful with your specific data.

---

## How RAG Works: The Mental Model

Think of RAG as giving the model a search engine for your data. Instead of the model trying to remember everything (which it can't), it searches for relevant information when it needs it.

### The Two Phases

**Ingestion (offline):** Take your documents, break them into chunks, convert each chunk into a vector (a list of numbers that captures its meaning), and store those vectors in a database. This happens once (and again when your data updates).

**Retrieval (at query time):** When a user asks a question, convert their question into a vector, search the database for chunks whose vectors are most similar, and inject those chunks into the model's prompt. The model then generates a response using this context.

---

## Embeddings: How Meaning Becomes Numbers

An embedding is a vector — a list of numbers — that represents the meaning of a piece of text. Texts with similar meanings have similar vectors, even if they use completely different words.

### Why This Matters

"How do I reset my password?" and "I can't log in, forgot my credentials" mean similar things but share almost no words. Traditional keyword search would miss this connection. Embedding-based search captures it because both texts produce similar vectors.

### How Embeddings Are Created

Embedding models (different from chat models) take text as input and produce a vector as output. These are specialized models trained to map semantically similar texts to nearby points in vector space.

Common embedding models:
- OpenAI's text-embedding models
- Cohere's embed models
- Open-source options like sentence-transformers

### Embedding Dimensions

Each embedding is a list of numbers, typically 256 to 3072 dimensions. More dimensions can capture more nuance but require more storage and computation. For most applications, the default dimensions from your embedding provider work well.

---

## Vector Databases: Where Embeddings Live

A vector database stores embeddings and allows you to search them efficiently. Given a query vector, it finds the most similar stored vectors — and by extension, the most relevant documents.

### How Similarity Search Works

The database computes the "distance" between the query vector and every stored vector (or uses clever indexing to avoid comparing every single one). The closest vectors correspond to the most relevant documents.

Common similarity metrics:
- **Cosine similarity** — Measures the angle between vectors. Most common for text embeddings.
- **Euclidean distance** — Measures straight-line distance between vectors.
- **Dot product** — A computation that combines magnitude and direction.

### Popular Vector Databases

**Qdrant** — Open-source, high-performance, great filtering support. Can run locally or in the cloud. Strong recommendation for getting started.

**Pinecone** — Fully managed cloud service. Easy to set up, good for production. No self-hosting option.

**Chroma** — Open-source, lightweight, designed for prototyping. Good for experiments, may need to be replaced for production scale.

**pgvector** — PostgreSQL extension that adds vector search. Good if you already use PostgreSQL and want to avoid adding another database.

### Choosing a Vector Database

For learning and prototyping: Qdrant (local mode) or Chroma. Both run without external infrastructure.

For production: Qdrant (cloud or self-hosted) or Pinecone. Choose based on whether you want to manage infrastructure (Qdrant) or not (Pinecone).

---

## Chunking: The Most Underestimated Step

Before you can embed your documents, you need to break them into chunks. This is the step that most people get wrong on their first try, and it has an outsized impact on retrieval quality.

### Why Chunking Matters

If your chunks are too large, you waste context tokens on irrelevant content. If they're too small, you lose the context that makes the information meaningful. The chunk size and strategy determine what your retrieval system can find.

### Chunking Strategies

**Fixed size** — Split text every N tokens with some overlap between chunks. Simple and works surprisingly well for many use cases. The overlap ensures that information at chunk boundaries isn't lost.

**Semantic** — Split at natural boundaries (paragraphs, sections, topic changes). Better preserves meaning within chunks. More complex to implement.

**Document structure** — Use the document's own structure (headings, sections, pages) to define chunks. Works well for structured documents like documentation or reports.

**Recursive** — Start with large chunks and recursively split them if they exceed the size limit, trying to split at natural boundaries. This is LangChain's default approach and works well for diverse document types.

### Chunk Size Guidelines

- **Too small** (under 100 tokens): Chunks lack context. "Set the value to 3" means nothing without knowing what value and why.
- **Too large** (over 1000 tokens): Chunks contain irrelevant information. You're paying for tokens the model doesn't need.
- **Sweet spot**: 200-500 tokens for most use cases. Enough context to be meaningful, small enough to be focused.

### Overlap

Overlapping chunks by 10-20% ensures that information at boundaries isn't lost. If a key fact spans two chunks, the overlap means it appears in full in at least one of them.

### Metadata

Attach metadata to each chunk: which document it came from, what section, the page number, the date. This lets you filter retrieval results and gives the model context about where the information comes from.

---

## The Retrieval Pipeline

When a user asks a question, the retrieval pipeline finds the most relevant chunks:

1. **Query embedding** — Convert the user's question into a vector using the same embedding model used for ingestion
2. **Similarity search** — Find the top-K most similar chunks in the vector database
3. **Filtering** (optional) — Apply metadata filters (only chunks from a specific document, only recent chunks, etc.)
4. **Reranking** (optional) — Use a cross-encoder or other reranking model to re-sort the results by relevance. More accurate than vector similarity alone but adds latency.
5. **Context injection** — Insert the retrieved chunks into the model's prompt, typically as part of the system message or a dedicated context section.

### How Many Chunks to Retrieve

Start with 3-5 chunks. More chunks provide more context but cost more tokens and may include irrelevant information that confuses the model. Experiment with your specific data to find the right number.

---

## RAG vs. Large Context Windows

Context windows keep getting bigger. Claude can handle 200K tokens. Gemini can handle 2M. Why not just paste everything in?

### When Large Context Windows Win

- Your entire knowledge base is small (under ~50 pages)
- You need the model to reason across the full document set
- Setting up RAG infrastructure isn't worth the complexity for your use case
- You're doing one-off analysis rather than building a persistent system

### When RAG Wins

- Your knowledge base is large (hundreds or thousands of documents)
- Your data changes frequently (you don't want to re-upload everything each time)
- You need to be surgical about what context the model sees
- Cost matters — large context windows are expensive per request
- The "lost in the middle" problem: models struggle to find information buried in very long contexts, but RAG sidesteps this by putting only the relevant information in context
- You need to cite sources or track where information came from

### The Practical Answer

For most production applications with substantial knowledge bases, RAG is the right choice. It's more cost-effective, more reliable for retrieval, and scales to arbitrary amounts of data. Large context windows are great for ad-hoc analysis and small knowledge bases.

---

## Hybrid Search

Pure vector (semantic) search is powerful but has blind spots. It can miss exact matches, specific names, or precise technical terms. Keyword search handles these well but misses semantic relationships.

Hybrid search combines both:
- **Semantic search** finds conceptually relevant results
- **Keyword search** finds exact term matches
- Results are combined and ranked

Most production RAG systems use hybrid search because it covers both cases. Many vector databases (including Qdrant) support hybrid search natively.

---

## Key Takeaways

- RAG solves the fundamental problem of making LLMs useful with your specific data
- The pattern: embed your documents, store the vectors, retrieve relevant chunks at query time, inject them into the prompt
- Chunking strategy has an outsized impact on quality — invest time in getting it right
- Start with 200-500 token chunks with 10-20% overlap
- Attach metadata to chunks for filtering and source attribution
- RAG beats large context windows for cost, scalability, and retrieval reliability in most production scenarios
- Hybrid search (semantic + keyword) covers the blind spots of either approach alone
- Start simple — a basic RAG pipeline with good chunking often outperforms a complex one with poor chunking
