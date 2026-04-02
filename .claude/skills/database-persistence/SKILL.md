---
name: database-persistence
description: Teaches database persistence with MySQL -- schema design, connection management, and migrating from in-memory to persistent storage for conversations and threads. Use when the learner asks about databases, persistence, saving conversations, or MySQL.
---

# Topic: Database Persistence

## When to Use
- Phase 4, after authentication
- Learner asks about saving conversations, database storage, or persistence
- Learner asks about MySQL, SQL, or why their data disappears when the server restarts
- Learner notices that in-memory thread storage is lost on restart

## Prerequisites
- `authentication` topic complete (users and threads exist)
- Working backend with in-memory thread storage
- Basic understanding of data structures (they have been using dictionaries for thread storage)

## Concept References
- `../aws-deployment/references/aws-infrastructure.md` (database section) -- read this before teaching

---

## Teaching Flow

### Open with the Problem
Start with the obvious flaw: "Restart your server. What happened to all your conversations? Gone. Every thread, every message -- wiped out. That is because your thread storage is a Python dictionary living in memory. When the process stops, the memory is freed. In production, you need your data to survive restarts, deployments, crashes, and scaling. You need a database."

### Core Points to Cover

**Why a database:**
- In-memory storage is fine for development but unacceptable for production
- Data must survive: server restarts, deployments, crashes, scaling to multiple instances
- A database is a separate service that stores data independently of your application
- When you scale to multiple server instances, they all need to access the same data -- a database provides that shared state

**Why MySQL (via RDS):**
- Relational databases are the right fit for structured data like users, threads, and messages
- MySQL is widely supported, well-documented, and runs on AWS RDS
- RDS is a managed service -- AWS handles backups, patching, and availability
- The learner gets experience with SQL, which is a fundamental skill
- The schema is straightforward: users, threads, messages with foreign key relationships

**Schema design for a chat application:**
- `threads` table: id, user_id, title, created_at, updated_at
- `messages` table: id, thread_id, role (user/assistant), content, created_at
- Foreign keys: messages belong to threads, threads belong to users
- Indexes: query by user_id (list a user's threads), query by thread_id (load a thread's messages)
- The schema mirrors the data structures they have already been using in memory

**Connection management:**
- Connection pooling -- do not open a new database connection for every request
- Use an async-compatible library (since FastAPI is async)
- Handle connection errors gracefully -- the database may be temporarily unavailable
- Environment variables for connection strings -- never hardcode credentials

**Migration from in-memory to database:**
- This is a swap, not a rewrite -- the API endpoints stay the same, only the storage layer changes
- Replace dictionary operations with SQL queries
- The API contract does not change -- the frontend does not know or care where data is stored
- This is why separation of concerns matters: the storage layer is independent of the API layer

### Close
Transition to the build: "Let's replace your in-memory storage with a real database. Your API endpoints will stay the same -- the only thing that changes is where the data lives. And after this, your conversations will survive anything."

---

## Adaptive Notes

**Experienced developers:** They likely know SQL and databases. Focus on the async patterns with FastAPI, connection pooling, and the migration strategy. Quick build -- 30-45 minutes.

**Beginners:** SQL may be new. Spend time on the basics: tables, rows, columns, foreign keys, queries. Use a visual tool to inspect the database. Build will take 60-90 minutes.

**Returning learners (review mode):** Focus on optimization: query performance, indexing, connection pool tuning. Review their schema design and suggest improvements.

---

## Build

Add database persistence to replace in-memory thread and message storage.

This is a hands-on build. See `references/build-details.md` for the full step-by-step process.

**High-level flow:**
1. Design the database schema
2. Set up MySQL (local for development)
3. Create the database and tables
4. Build the data access layer
5. Replace in-memory storage with database calls
6. Add chat naming (auto-generate thread titles)
7. Test end-to-end

---

## Understanding Checks
- Can the learner explain why in-memory storage is insufficient for production?
- Can they describe their schema and the relationships between tables?
- Can they explain connection pooling and why it matters?
- Does their application persist data across server restarts?

See `references/checks.md` for detailed check criteria.

---

## When Done
- MySQL database running with threads and messages tables
- All thread and message operations use the database instead of in-memory storage
- Data persists across server restarts
- Connection pooling configured
- Thread titles auto-generated
- Tested end-to-end
- Code saved in `projects/`
- Mark "Database Persistence" complete in `learner/progress.md`
- Add observations about their understanding of databases and persistence to `learner/notes.md`
- Proceed to `aws-deployment`
