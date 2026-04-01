# Tool Design

How to design tools that LLMs actually use well. The tool schema is a prompt — the model reads it to decide when and how to use each tool.

---

### The Tool Description Is a Prompt

This is the most important thing to understand. The model reads your tool's name, description, and parameter descriptions to decide whether to use the tool and how. A vague description ("database operations") produces vague tool usage. A specific description ("Query the user database by email address. Use this when you need to look up a user's account details, subscription tier, or usage history. Returns user profile data including name, email, tier, and last login date.") produces precise, correct tool usage.

### Clear Names Matter

Tool names should be action-oriented and unambiguous. "search_web" is immediately clear. "web" is not. "search_docs_by_embedding" is clear. "find_stuff" is not. If two tools have similar names, the model will confuse them. Make names distinctive.

### Keep Tools Focused

Each tool should do one thing. "search_and_create_ticket" is a bad tool — it combines two actions. The model can't search without creating a ticket, or create a ticket without searching. "search_issues" and "create_ticket" are better. The model composes simple tools into complex workflows naturally.

### Describe When to Use, Not Just What It Does

"Searches the knowledge base" tells the model what the tool does. "Search the knowledge base for product documentation, FAQs, and troubleshooting guides. Use this when the user asks a question about how to use the product, reports a problem, or needs help with a specific feature." tells the model WHEN to use it. The second description leads to dramatically better tool selection.

### Return Useful, Structured Responses

Tool responses should give the model what it needs to take the next step. Don't return raw API responses with 50 fields when the model only needs 3. Don't return just "success" — return the relevant data. Structure the response clearly so the model can extract what it needs.

### Handle Errors in Tool Responses

When a tool fails, return a clear error message as the tool result — not a generic exception. "Error: No user found with email john@example.com. The email may be misspelled or the user may not have an account." gives the model enough information to adjust its approach. An unhandled exception gives the model nothing useful.

### Limit the Number of Tools

Model performance degrades as tool count increases. Each tool schema consumes context tokens, and the model has more difficulty choosing correctly from a large set. The practical limit is around 10-15 tools.

If you need more than 15 tools, consider:
- Grouping related tools and only loading relevant groups based on context
- A routing step that selects the relevant tool category first
- MCP servers that provide tools dynamically

### Use Enums for Constrained Parameters

If a parameter has a fixed set of valid values, use an enum. Instead of a free-text "status" parameter (where the model might pass anything), define the options: ["open", "in_progress", "resolved", "closed"]. This eliminates a class of errors entirely.

### Required vs. Optional Parameters

Mark parameters as required only if the tool genuinely can't function without them. Optional parameters with sensible defaults give the model flexibility. But don't make everything optional — required parameters signal to the model that this information is essential.

### Test Tools with the Model, Not Just in Isolation

A tool might work perfectly as a function but fail as an LLM tool because the description is confusing, the parameters are ambiguous, or the response format isn't helpful to the model. Test the full loop: model reads description → model calls tool → tool returns result → model uses result correctly.

### The Production Reality

Tools that work in demos often fail in production because:
- Demo inputs are clean; production inputs are messy
- Demo volumes are low; production volumes reveal performance issues
- Demo errors are rare; production errors are constant
- Demo tools are tested by the developer; production tools face real users

Build tools defensively: validate inputs, handle errors gracefully, log everything, and set timeouts.
