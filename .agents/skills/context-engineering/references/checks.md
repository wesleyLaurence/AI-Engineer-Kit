# Understanding Checks: Context Engineering

## Check Questions
1. What is the context window, and what happens when you exceed it?
2. How does context size affect cost? How does it affect model performance?
3. If you have a 128K context window and need to include a system prompt, conversation history, retrieved documents, and leave room for a response -- how would you budget the tokens?
4. What is the "lost in the middle" problem, and how does it affect where you place important information?
5. Name three strategies for managing context when you have more information than fits in the window.
6. How is RAG a form of context engineering?

## Completion Criteria
- The learner understands context windows as a finite, expensive resource
- They can explain the relationship between context size, cost, and performance
- They can describe concrete strategies: summarization, selective retrieval, truncation, prioritization
- They see context engineering as a unifying thread across RAG, memory, agents, and prompt design
- They can reason about token budgets for their own project

## What to Update
- `learner/progress.md` -- mark "Context Engineering" complete
- `learner/notes.md` -- record their context awareness level, any insights about their project's context usage
