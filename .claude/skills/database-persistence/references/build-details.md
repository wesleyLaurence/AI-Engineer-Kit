# Build Details: Database Persistence

## Overview
Replace in-memory thread and message storage with MySQL, adding persistent storage that survives restarts and supports multiple server instances.

---

### Step 1: Design the Database Schema
Design the tables for the chat application:
- `threads` table: id (UUID or auto-increment), user_id (from Cognito), title, created_at, updated_at
- `messages` table: id, thread_id (foreign key to threads), role (user/assistant), content, created_at
- Foreign keys enforce data integrity: every message belongs to a thread, every thread belongs to a user
- Indexes: on threads.user_id (for listing a user's threads), on messages.thread_id (for loading a thread's messages)
- Consider ordering: messages should be retrievable in chronological order

Checkpoint: Does the schema cover all the data they currently store in memory? Are the relationships correct?

### Step 2: Set Up MySQL Locally
Install MySQL for local development (or use Docker for a containerized instance).
Create a database for the project.
Connect with a MySQL client and verify access.

Store connection details in environment variables -- never hardcode credentials.

Checkpoint: Can they connect to MySQL and run a simple query?

### Step 3: Create the Database and Tables
Write SQL to create the tables.
Run the creation scripts.
Verify the tables exist with the correct structure.

Optionally, create a simple migration system (even just numbered SQL files) so the schema can be recreated consistently.

Checkpoint: Do the tables exist with the correct columns, types, and constraints?

### Step 4: Build the Data Access Layer
Create a database module that handles all data operations:
- Use an async-compatible MySQL library (aiomysql or similar)
- Set up connection pooling -- a pool of connections shared across requests
- Implement CRUD operations:
  - Create thread (insert into threads, return the new thread)
  - List threads for a user (select from threads where user_id matches, ordered by updated_at)
  - Get thread with messages (select thread and its messages, ordered chronologically)
  - Create message (insert into messages, update thread's updated_at)
  - Delete thread (delete thread and its messages)
- Handle errors: connection failures, constraint violations, not found

Use web search for the current async MySQL libraries compatible with FastAPI.

Checkpoint: Can they create a thread, add messages, and retrieve them using the data access layer?

### Step 5: Replace In-Memory Storage with Database Calls
Swap out the in-memory dictionary operations in the API endpoints:
- Thread creation endpoint now calls the database create function
- Thread listing endpoint now queries the database
- Chat endpoint now saves messages to the database
- Thread deletion endpoint now deletes from the database

The API contract does not change -- the same request/response format, the same endpoints. Only the storage layer is different.

This is a mechanical replacement: find every place the in-memory dictionary is used and replace it with the corresponding database function.

Checkpoint: Do all existing API tests still pass with the database backend?

### Step 6: Add Chat Naming
Auto-generate thread titles from conversation content:
- After the first assistant response in a thread, generate a short title
- Use the LLM to summarize the first exchange into a 3-5 word title
- Update the thread's title in the database
- Display the title in the frontend's conversation sidebar

This improves the UX of the conversation sidebar -- users see meaningful names instead of "Untitled" or timestamps.

Checkpoint: Do new conversations get auto-generated titles? Do they appear in the sidebar?

### Step 7: Test End-to-End
Full flow test:
1. Start the server
2. Create a conversation, send messages, verify they are stored in the database
3. Restart the server -- verify conversations are still there
4. Load conversation history -- verify messages appear in order
5. Delete a conversation -- verify it is removed from the database
6. Test with multiple users -- verify data isolation (User A cannot see User B's threads)
7. Check that thread titles are generated and displayed correctly
