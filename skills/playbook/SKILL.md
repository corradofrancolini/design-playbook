---
name: playbook
description: Quick reference guide — files, skills, method, project state
---

# Playbook — Quick Reference

Quick reference for the design-playbook. Shows what's installed, what to do, and when to use each skill.

## Actions

### 1. Check project state

Read these files and identify their state:

- **BRIEF.md** — does it still contain placeholders like `[one-line description]` or has it been filled in?
- **CREATIVE_DIRECTION.md** — does it still contain `[To be defined after benchmark]` or does it have real content?
- **docs/handoffs/** — what's the latest handoff? By whom?
- **CLAUDE.md** — Team section: how many people?

### 2. Show guide

Generate this output, adapting the "State" section based on what you found:

```
## design-playbook — Quick Reference

### Project state

- BRIEF.md: [filled in / to be filled in]
- CREATIVE_DIRECTION.md: [filled in / to be filled in]
- Latest handoff: [date, author from docs/handoffs/]
- Team: [names from CLAUDE.md, or "single user"]

### Method

This project uses the Adjacent Possible: Claude maps options
and trade-offs, does not converge. Execute only with an explicit trigger
("execute", "proceed", "go with X").

Details: CLAUDE.md (protocol), lab/PROCESS.md (methodology)

### Available skills

| Skill | When |
|-------|------|
| /setup | Initial setup — fill in brief and creative direction |
| /creative | Creative fork — explore alternative directions |
| /review | Component or feature completed — code review |
| /accessibility | Before releasing a page — WCAG audit |
| /content | Writing text, labels, error messages |
| /design-system | Checking token and component consistency |
| /seo | Before releasing — SEO and performance audit |
| /project-index | Mapping the project structure visually |
| /storybook | Setting up component library and tests |
| /benchmark | Comparative analysis of design references |
| /session-end | End of session — update handoff (always) |
| /playbook | This guide |

### Process files

| File | Purpose |
|------|---------|
| CLAUDE.md | Project protocol (auto-loaded by Claude Code) |
| BRIEF.md | Project brief — scope, target, content, constraints |
| STACK.md | Tech stack, architecture decisions, dependencies, patterns |
| CREATIVE_DIRECTION.md | Creative direction — palette, typography, mood |
| SESSION_HANDOFF.md | Pointer to docs/handoffs/ |
| docs/handoffs/ | Session handoffs (shared across the team) |
| BACKLOG.md | Backlog and decisions |
| assets/ | Source materials (brand guidelines, moodboard, client brief) |
| lab/PROCESS.md | Anti-sycophancy methodology (reference) |
| lab/notes.md | Working notes |
| docs/sessions/ | Session logs (personal) |
```

### 3. Contextual suggestions

Based on the project state:

- If BRIEF.md is not filled in: "I suggest `/setup` for a guided configuration, or fill in BRIEF.md manually."
- If CREATIVE_DIRECTION.md is not filled in: "Fill in CREATIVE_DIRECTION.md before you start designing."
- If both are filled in: "The project is configured. You can start working or use `/creative` to explore directions."

### 4. Answer questions

If the user asks for details about a specific skill, read the corresponding SKILL.md in `.claude/skills/<name>/SKILL.md` and summarize what it does and when to use it.
