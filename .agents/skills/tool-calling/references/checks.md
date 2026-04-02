# Understanding Checks: Tool Calling

## Check Questions
1. Walk me through the tool calling flow. What happens from the moment you send a message to the model until the user sees a response that used a tool?
2. The model wants to search the web. Who actually performs the search — the model or your code? Why is this distinction important?
3. You are designing a tool for [their project use case]. What would the schema look like? What would the description say?
4. What makes a bad tool description? What goes wrong when the description is vague or misleading?
5. What happens if a tool call fails (network error, invalid input)? How should your code handle this?

## Completion Criteria
- The learner can trace the complete tool calling flow: define tools, model generates call request, your code executes, result sent back, model incorporates result
- The learner understands that the model generates structured requests but does NOT execute tools — their code does
- The learner can write clear, well-structured tool schemas with descriptions that guide model behavior
- The learner understands the importance of tool descriptions for controlling when and how tools are used
- The learner has at least one working tool integrated into their chatbot

## What to Update
- `learner/progress.md` — mark "Tool Calling" complete, record milestone "First agent with tools"
- `learner/notes.md` — add observations about their tool design approach, any issues with tool selection or parameter passing
- `learner/project.md` — document tools added, tool design decisions, and how tools connect to the project goal
