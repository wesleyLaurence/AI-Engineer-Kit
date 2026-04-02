# Understanding Checks: Database Persistence

## Check Questions
1. Why is in-memory storage insufficient for production? What specific scenarios cause data loss?
2. Describe your database schema. What tables do you have, and how are they related?
3. Why do messages have a foreign key to threads, and threads have a foreign key to users? What does that enforce?
4. What is connection pooling? Why do you not open a new connection for every request?
5. Restart your server and verify your data is still there. Walk through what is happening differently now.
6. If you scaled to three server instances, would your data still be consistent? Why?

## Completion Criteria
- The learner can explain why persistent storage is necessary and what problems it solves
- They have a well-designed schema with proper relationships and indexes
- MySQL is running and the data access layer is implemented
- All in-memory storage has been replaced with database operations
- Data survives server restarts
- Connection pooling is configured
- Thread titles are auto-generated from conversation content
- The application works end-to-end with the database

## What to Update
- `learner/progress.md` -- mark "Database Persistence" complete
- `learner/notes.md` -- record their schema design decisions, any SQL challenges, insights about data modeling
