# Build Details: First LLM Call

Step-by-step guide for building a script that makes an LLM API call.

---

## Step 1: Choose Provider and Model
Based on the learner's setup (from environment-setup):
- If they have an OpenAI key: use the `openai` SDK with `gpt-4o-mini` (cheap, fast, good for learning)
- If they have an Anthropic key: use the `anthropic` SDK with `claude-3-5-haiku` (cheap, fast equivalent)
- If they have both: pick one to start. They can try the other after.

Use web search to confirm the current recommended models and SDK syntax — these change frequently.

---

## Step 2: Write the Basic Script
Build this together, explaining each part:

1. **Import and load environment:** Load the API key from .env using python-dotenv
2. **Create the client:** Instantiate the provider's SDK client
3. **Define the messages:** Create a messages array with:
   - A system message (e.g., "You are a helpful assistant.")
   - A user message (e.g., "What is AI engineering?")
4. **Make the call:** Use the SDK's chat completion method
5. **Print the result:** Extract and print the response text

Use web search for the current SDK documentation to get the exact syntax right. API patterns change between SDK versions.

**Checkpoint:** Does the script run and print a response?

---

## Step 3: Explore the Response Object
After the basic call works, examine what came back:

1. **The text:** The model's actual response content
2. **Token usage:** Print the input token count, output token count, and total
3. **Finish reason:** Print why the model stopped generating
4. **Model info:** Which model version processed the request

Calculate the cost: look up the per-token price for the model they used and multiply by the token counts. Make the economics tangible.

**Checkpoint:** Can they find and explain each part of the response?

---

## Step 4: Experiment with Parameters
Modify the script to try different settings:

### Temperature
- Set temperature to 0, run the same prompt 3 times. Observe: same or nearly same output each time.
- Set temperature to 1.0 or higher, run the same prompt 3 times. Observe: different output each time.
- Discuss: when do you want deterministic output (code generation, classification) vs. creative output (brainstorming)?

### Max Tokens
- Set max_tokens to a small number (e.g., 20). Run the script.
- Observe: the response gets cut off mid-sentence. Check the finish reason — it should be "length" instead of "stop."
- Discuss: this is a safety limit, not a target. The model won't pad to reach it.

### System Prompt
- Change the system prompt to something specific: "You are a pirate who explains technology using nautical metaphors."
- Run the same user message. Observe how the response style changes completely.
- Discuss: the system prompt is your primary tool for controlling model behavior.

**Checkpoint:** Do they understand how each parameter affects the output?

---

## Step 5: Save and Clean Up
- Save the script in `projects/experiments/` (e.g., `first_call.py`)
- Make sure the script is clean and well-commented — they'll reference it later
- Optionally, add a few variations they can uncomment to experiment further

This script becomes their reference implementation for "how to call an LLM" throughout the rest of the curriculum.
