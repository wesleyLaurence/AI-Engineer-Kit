# Build Details: RAG System

### Step 1: Choose a Vector Database
Recommend Qdrant (local mode for development). Explain why.
Use web search for current Qdrant Python client documentation.
Install the client library.

### Step 2: Prepare Documents
Help the learner choose documents to ingest:
- For their project: relevant documents for their use case
- For the guided project: sample documents or documentation

If they don't have documents, create sample ones or use publicly available text.

### Step 3: Build the Chunking Pipeline
Implement chunking with LangChain's text splitters.
Use web search for the latest LangChain document loader and splitter APIs.

Start with recursive character splitting (~500 tokens, 50 token overlap).
Attach metadata to each chunk (source document, section, etc.).

Checkpoint: Can they see the chunks and verify they make sense? Are they the right size?

### Step 4: Generate Embeddings
Choose an embedding model (OpenAI's text-embedding or equivalent).
Embed all chunks.
Explain what's happening — text is being converted to vectors that capture meaning.

### Step 5: Store in Vector Database
Create a Qdrant collection.
Upload the embedded chunks with metadata.
Verify by running a test similarity search.

Checkpoint: Does a test query return relevant chunks?

### Step 6: Build the Retrieval Pipeline
Given a user query:
1. Embed the query
2. Search the vector database for top-K similar chunks
3. Format the retrieved chunks for injection into the prompt

### Step 7: Wire Into the Agent
Add retrieved context to the model's prompt:
- Include retrieved chunks in the system message or as a context section
- Instruct the model to answer based on the provided context
- Instruct the model to say when it doesn't have enough context

Test with real questions about the ingested documents.

Checkpoint: Does the agent answer questions using the document content? Does it cite or reference the right sources?

### Step 8: Iterate and Improve
- Try different chunk sizes and see how quality changes
- Try different numbers of retrieved chunks (3, 5, 10)
- Test with questions the documents DON'T answer — does the agent handle this well?
