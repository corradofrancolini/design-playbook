---
name: setup
description: Guided project setup — fills brief, creative direction, and configuration
---

# Setup — Guided Configuration

Interactive guide for configuring a new project. Fills BRIEF.md, CREATIVE_DIRECTION.md, and adapts CLAUDE.md through a conversation.

## When to invoke

- First working session on a new project
- When BRIEF.md and CREATIVE_DIRECTION.md still contain placeholders

## Actions

### 0. Repository

Check if the project is a git repository (look for `.git/`).

**If NO:**
- "Do you want this project to be tracked and shareable? (recommended)"
- If YES: `git init`, first commit with the scaffold files
- If NO: skip — everything works anyway, just without syncing

**If YES:**
- "The project is already a git repository. Perfect."
- Check if a remote is configured
- If NO: "If you want to share with the team, you'll need a repository on GitHub/GitLab. Want me to create one?" (use `gh` if available)

### 1. Check current state

Read BRIEF.md and CREATIVE_DIRECTION.md. If they are already filled in (don't contain placeholders like `[one-line description]` or `[To be defined after benchmark]`), tell the user that setup is already done and ask if they want to update something specific.

If they still contain placeholders, proceed with the setup.

### 2. Project brief (BRIEF.md)

Guide the user through each section, one at a time. For each question, accept the answer or "skip" to leave the placeholder.

**Sequence:**

1. **Project**
   - "Describe the project in one line — what is it?"
   - "Who is it for? (client, stakeholder, organization)"
   - "What is the main goal?"

2. **Target**
   - "Who are the primary users? Profile, needs, usage context."
   - "Are there secondary users?"
   - "Primary usage context? (desktop, mobile, on-the-go, etc.)"

3. **Scope**
   - "What's included in the project? (features, pages)"
   - "What's explicitly excluded?"

4. **Tech stack**
   - "Framework? (Next.js, Nuxt, Astro, etc.)"
   - "CMS? (Payload, Sanity, none, etc.)"
   - "Hosting? (Vercel, Netlify, etc.)"
   - "Database? (PostgreSQL, MongoDB, none, etc.)"
   - "External integrations or APIs?"

5. **Content**
   - "Single language or multilingual? Which languages?"
   - "Planned page structure? (homepage, about, blog, etc.)"
   - "Is there existing content or does everything need to be created?"
   - "Tone of voice? (formal, technical, warm, direct, etc.)"

6. **References**
   - "Competitor or reference benchmarks? (links or descriptions)"
   - "Is there a Figma moodboard? (link)"
   - "Existing brand guidelines? (link or file)"

7. **Constraints**
   - "Deadline or milestones?"
   - "Technical constraints? (browser support, accessibility, performance)"
   - "Brand constraints? (non-negotiable elements)"

After each answer, update the corresponding section in BRIEF.md. Also update the "Last updated" date.

### 3. Creative direction (CREATIVE_DIRECTION.md)

Continue with creative direction questions:

1. **Starting constraints**
   - "Does the logo already exist or does it need to be created?"
   - "Are there defined brand colors? Which ones?"
   - "How do you want to be perceived? (positioning)"

2. **Typography**
   - "Are fonts already chosen or do they need to be defined?"
   - If they need to be defined: "What feeling do you want to convey? (modern, classic, technical, warm, etc.)"

3. **Visual mood**
   - "Do you have visual references? (sites, images, mood)"
   - "3 adjectives that describe the look you're going for?"

After each answer, update the corresponding section in CREATIVE_DIRECTION.md.

### 4. CLAUDE.md configuration

Read CLAUDE.md and check if the "Project structure" section reflects the stack declared in the BRIEF.

- If the stack was defined, propose a consistent project structure (e.g. for Next.js: `app/`, `components/`, `lib/`, etc.)
- Show the proposal and ask for confirmation before modifying
- If the user says "skip", leave the current structure

### 5. Team

Ask: "How many people are working on this project?"

- If more than 1: ask for names (GitHub accounts) and add them to the Team list in CLAUDE.md
- If 1: the Team list already has one line, skip

### 6. Summary

At the end, show a summary:

```
## Setup complete

### Filled in
- [list of completed sections]

### To complete
- [list of skipped sections, if any]

### Next steps
- Use `/creative` to explore design directions
- Use `/playbook` anytime for a quick reference
- Close every session with `/session-end`
```

## Notes

- Don't force answers: if the user hasn't decided something yet, "skip" is perfectly valid
- Group questions where possible to avoid being too verbose (e.g. the entire "Tech stack" block can be one question if the user is concise)
- Adapt the level of detail to the user: if they answer concisely, be concise. If they elaborate, go deeper.
