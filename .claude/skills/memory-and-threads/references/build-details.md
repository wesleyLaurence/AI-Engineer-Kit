# Build Details: Multi-Turn Chatbot with Memory

### Step 1: Basic LLM Call (Review)
Confirm the learner has a working script that calls an LLM. If not, build one first.
Use web search for the latest SDK documentation.

### Step 2: Add a System Prompt
Discuss what the chatbot's personality should be. Connect to their project:
- If they have a project idea, design the system prompt for that use case
- If using the guided project, design a helpful assistant persona

Write and iterate on the system prompt together.

Checkpoint: Does the system prompt produce the behavior they want?

### Step 3: Add Conversation History
Explain why the model "forgets" without history management.
Build message accumulation:
- Start with system message
- User input gets added as a user message
- Model response gets added as an assistant message
- The full array is sent with each request

Run it in a loop so they can have a multi-turn conversation.

Checkpoint: Can the chatbot reference things said earlier in the conversation?

### Step 4: Add Streaming
Explain why streaming matters for UX (reference the streaming concept).
Modify the chatbot to stream responses token by token.
Show the difference between the streaming and non-streaming experience.

Checkpoint: Does the response appear token by token?

### Step 5: Clean Up and Structure
Help them organize the code:
- Separate the chatbot logic from the main loop
- Add proper error handling
- Add a clean exit mechanism

Save the code in projects/experiments/ or their main project directory.
