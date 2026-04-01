# Contributing to AI Engineer Kit

Thanks for wanting to make this better. The kit is designed to be community-driven — the core structure comes from Wes, but the knowledge should grow from everyone who's building real AI systems.

## What You Can Contribute

### Wisdom
"I learned this the hard way so you don't have to."

If you've built production AI systems, you have scars worth sharing. Submit a PR adding entries to the relevant wisdom file, or propose a new wisdom file if the topic isn't covered.

Good wisdom entries:
- Are specific and actionable (not vague advice)
- Come from real experience (not hypothetical)
- Include the "why" — what went wrong, what you learned
- Are mostly timeless (not tied to a specific library version)

### Concept Improvements
Better explanations, clearer analogies, corrections, additional depth. If something in a concept file confused you or could be clearer, improve it.

Keep in mind: concept files explain **what** and **why**, not **how** (no code examples). They should be implementation-agnostic where possible.

### New Skills
Skills for specific use cases beyond the core curriculum: `/build-slack-bot`, `/build-email-agent`, `/build-data-pipeline`, etc.

Follow the existing skill format — read relevant concept and wisdom files, guide incrementally, explain the why at each step, check in with the learner.

### Resources
Links to great tutorials, tools, podcasts, books. Quality over quantity — only submit resources you've personally found valuable.

### Translations
Concept files and wisdom in other languages. This opens the kit to a global audience.

## What Stays Curated

The curriculum structure (AGENTS.md), the learning path order, and the overall architecture are maintained by Wes. This ensures the kit stays coherent and opinionated rather than becoming a sprawling, unfocused collection.

Contributions are welcomed but curated — every PR is reviewed for quality, accuracy, and fit.

## How to Submit

1. Fork the repo
2. Create a branch (`git checkout -b improve-rag-concept`)
3. Make your changes
4. Submit a PR with a clear description of what you changed and why

## Guidelines

- Keep the tone approachable but precise — explain things to a smart person who hasn't built this before
- Don't add code examples to concept files — the agent handles implementation
- Don't modify anything in `learner/` or `projects/` (these are gitignored and personal to each learner)
- Test your changes by opening the repo in a coding agent and seeing if the experience still flows well
