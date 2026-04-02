# Python for AI Engineering

## Why Python

Python is the language of AI engineering. Not because it's the fastest language or the most elegant — but because the entire AI ecosystem is built around it. Every major LLM provider has a Python SDK. Every major framework (LangChain, LlamaIndex, CrewAI) is Python-first. The tooling, the community, the examples — it's all Python.

This isn't Python 101. If you've programmed in any language, you can pick up Python syntax quickly with an agent's help. What you need are the specific Python concepts and patterns that matter for AI engineering work.

---

## Virtual Environments

This is the first thing that trips people up, and it's the most important foundational concept.

A virtual environment is an isolated Python installation for your project. It has its own packages, its own versions, completely separate from your system Python and every other project.

### Why This Matters

Without virtual environments, every Python project on your machine shares the same packages. Project A needs langchain 0.2, Project B needs langchain 0.3 — you have a conflict. Virtual environments eliminate this entirely.

### How It Works

You create a virtual environment in your project directory. When you "activate" it, your terminal's Python and pip commands point to this isolated copy. Packages you install go into this environment only. When you deactivate it or close the terminal, you're back to the system Python.

### The Two Main Options

**venv** — Built into Python. No extra installation needed. Creates a `.venv` folder in your project. Simple and reliable. This is the recommended choice for most AI engineering work.

**conda** — A separate package manager popular in data science. Handles non-Python dependencies (like CUDA for GPU work) better than venv. More complex. Use it if you need GPU acceleration for local model inference; otherwise, venv is simpler.

### The Workflow

1. Create the environment once per project
2. Activate it every time you open a terminal for that project
3. Install packages with pip while the environment is active
4. Use a `requirements.txt` file to track what's installed

---

## Dependency Management

### requirements.txt

A plain text file listing every package your project needs, one per line. This is how you (and anyone else) can recreate your project's environment.

You can pin exact versions (recommended for production) or allow ranges. The key principle: always track your dependencies. Never rely on "I'll remember what I installed."

### pip

Python's package installer. It downloads packages from PyPI (Python Package Index) and installs them into your active environment.

Key operations you'll use constantly:
- Install a package
- Install all packages from a requirements.txt
- Freeze current packages to a requirements.txt
- Upgrade a package

### Version Conflicts

AI libraries have deep dependency trees. LangChain depends on dozens of packages, each with their own dependencies. Sometimes two packages you need require conflicting versions of a shared dependency.

When this happens: check if newer versions of either package resolve the conflict. If not, you may need to find an alternative package or isolate the conflicting packages into separate services.

---

## Async/Await Patterns

AI engineering is heavily I/O bound. You're constantly waiting for API responses — LLM calls that take 2-30 seconds, database queries, web requests. Async programming lets you do other work while waiting.

### The Core Idea

Synchronous code waits for each operation to finish before starting the next one. If you make three LLM API calls, you wait for call 1 to return, then call 2, then call 3. Total time: sum of all three.

Asynchronous code can start all three calls and wait for them simultaneously. Total time: the longest single call.

### When It Matters

- Making multiple LLM calls that don't depend on each other
- Handling multiple user requests simultaneously in a web server (FastAPI)
- Streaming responses while doing background work
- Calling multiple tools in parallel in an agent

### The Key Concepts

**async def** — Declares a function as asynchronous. It can "pause" while waiting for something.

**await** — Pauses the current function until the awaited operation completes. Other async functions can run during this pause.

**asyncio** — Python's built-in library for running async code. Provides the event loop that coordinates everything.

Most LLM SDKs and web frameworks (FastAPI, httpx) have async versions of their APIs. Using them is almost always the right choice for AI applications.

---

## Working with HTTP APIs

Every LLM interaction is an HTTP API call. Understanding this removes the magic.

### The Request-Response Pattern

You send an HTTP request (usually POST) with a JSON body containing your messages. The server processes it and returns an HTTP response with a JSON body containing the model's output. That's it. It's the same pattern as any REST API.

### HTTP Libraries

**requests** — The classic Python HTTP library. Simple, synchronous. Good for scripts and quick tests.

**httpx** — Modern replacement for requests. Supports both sync and async. Recommended for AI applications because you'll want async support.

Most of the time, you'll use the provider's SDK (openai, anthropic) rather than making raw HTTP calls. But understanding that it's just HTTP underneath helps you debug issues, understand rate limits, and work with APIs that don't have SDKs.

---

## Type Hints

Type hints annotate what types your functions expect and return. Python doesn't enforce them at runtime, but they make your code dramatically easier to understand and catch bugs early.

### Why They Matter for AI Engineering

LLM responses are structured data — messages, tool calls, token counts. Type hints help you keep track of these complex data structures. They also power IDE autocompletion, which speeds up development significantly.

Modern AI frameworks use type hints extensively. FastAPI uses them to automatically validate request data and generate API documentation. Pydantic (used everywhere in AI tooling) uses them to define data models.

---

## Dataclasses and Pydantic Models

### Dataclasses

Python's built-in way to create classes that are primarily containers for data. Instead of writing a class with an `__init__` method that sets a bunch of attributes, you declare the fields and Python generates the boilerplate.

Useful for: internal data structures, configuration objects, anything where you need a structured container for related data.

### Pydantic Models

Similar to dataclasses but with automatic validation and serialization. Define a model with typed fields, and Pydantic ensures any data you load into it matches the types. It also converts to and from JSON automatically.

Pydantic is everywhere in AI engineering:
- FastAPI uses it for request/response validation
- LangChain uses it for tool definitions and structured output
- OpenAI's SDK uses it for response parsing

Understanding Pydantic models is essential — you'll use them constantly.

---

## Environment Variables

API keys, database credentials, configuration values — these should never be hardcoded in your source code. Environment variables keep secrets out of your code and your git history.

### The Pattern

Store sensitive values as environment variables. Load them in your code at runtime. Use a `.env` file for local development (and add it to `.gitignore` so it never gets committed).

For production, use a secrets manager (like AWS Secrets Manager) rather than environment variables directly. But for local development, environment variables with a `.env` file are the standard approach.

---

## JSON Handling

LLM APIs send and receive JSON. Tool definitions are JSON schemas. Configuration is often JSON. You'll work with JSON constantly.

Python's built-in `json` module handles serialization (Python objects to JSON strings) and deserialization (JSON strings to Python objects). Pydantic models can convert to and from JSON automatically, which is usually cleaner than manual JSON handling.

### Key Patterns

- Parsing API responses from JSON strings to Python dictionaries
- Building request bodies as Python dictionaries and serializing to JSON
- Defining tool schemas as dictionaries that match JSON Schema format
- Reading and writing JSON configuration files

---

## File I/O

You'll read files for RAG ingestion, write files for logging and output, and manage configuration files. Python's built-in file handling is straightforward.

### The Context Manager Pattern

Always use `with` statements for file operations. They automatically close the file when you're done, even if an error occurs. This is a Python idiom you'll see everywhere.

### Common File Operations for AI Work

- Reading text files for document processing
- Reading PDFs and other formats (using libraries like PyPDF2)
- Writing logs and output files
- Loading and saving JSON configuration
- Processing CSV data

---

## Key Takeaways

- Virtual environments are non-negotiable — always isolate your project dependencies
- Track dependencies in requirements.txt — never rely on memory
- Async/await is essential for AI applications — LLM calls are I/O-bound and benefit enormously from concurrent execution
- Understand that LLM APIs are just HTTP — this demystifies everything
- Type hints and Pydantic models are used everywhere in AI frameworks — learn them early
- Keep secrets in environment variables, never in code
- You don't need to be a Python expert to do AI engineering — you need to be comfortable with these specific patterns
