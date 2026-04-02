# Understanding Checks: Threads and Conversation Memory

## Check Questions
1. Why does an LLM "forget" what you said in a previous message? What is actually happening at the API level?
2. What is in the messages array you send to the API? Walk me through a three-turn conversation — what does the array look like after each turn?
3. If the conversation gets very long, what problems will you run into? What strategies could you use to manage this?
4. What is the difference between how ChatGPT handles memory and how your chatbot handles memory?
5. Why does each turn of a long conversation cost more tokens than a short one?

## Completion Criteria
- The learner can explain LLM statelessness in their own words — the model genuinely does not remember, memory is managed externally
- The learner understands the messages array is the sole mechanism for conversation context
- The learner can trace through the accumulation pattern: system message, then user/assistant pairs growing with each turn
- The learner has a working chatbot that maintains conversation history across multiple turns
- The learner is aware of context window limits and cost implications, even if they have not hit them yet

## What to Update
- `learner/progress.md` — mark "Threads and Conversation Memory" complete, record milestone "First chatbot with memory"
- `learner/notes.md` — add observations about their grasp of statelessness, any misconceptions that surfaced, chatbot behavior observations
- `learner/project.md` — update with chatbot architecture decisions (memory strategy, code location)
