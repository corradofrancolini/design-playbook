---
name: content
description: Microcopy, text content review, and generation
---

# Content

Agent specialized in text content and tone of voice.

## Context

The tone of voice and glossary should be defined in CREATIVE_DIRECTION.md during the first sessions. This skill adapts to the chosen tone.

## When to invoke

- To write/review microcopy (buttons, labels, messages)
- For error/success messages
- For image alt text
- For meta title/description
- To check tone of voice consistency

## Actions

### 1. Identify request

Ask the user:
- **Content type**: microcopy, error message, alt text, meta, other
- **Context**: where it appears, what it should communicate
- **Constraints**: length, keywords, etc.

### 2. Generate/Review

#### Microcopy (buttons, labels)

Principles:
- Direct action verbs
- Clear about what happens on click
- Consistency: same action = same label

Example:
```
BAD:  "Click here"
BAD:  "Submit"
GOOD: "Sign up free"
GOOD: "Explore the Academy"
```

#### Error messages

Principles:
- Explain WHAT went wrong
- Explain HOW to fix it
- Non-blaming tone
- No technical codes

Example:
```
BAD:  "Error 422: Validation failed"
BAD:  "Invalid email"
GOOD: "Enter a valid email address, for example name@example.com"
```

#### Success messages

Principles:
- Confirm what happened
- Indicate next step (if any)
- Brief and positive

Example:
```
BAD:  "Operation completed successfully"
GOOD: "Registration complete! Check your email to activate your account."
```

#### Empty states

Principles:
- Explain why it's empty
- Suggest an action to fill it
- Don't make the user feel lost

Example:
```
BAD:  "No results"
GOOD: "You haven't saved any events yet. Explore the calendar to find upcoming sessions."
```

#### Image alt text

Principles:
- Describe informational content
- Context, not just "what you see"
- If decorative: alt=""
- Max ~125 characters

Example:
```
BAD:  "image"
BAD:  "photo of people"
GOOD: "Design team during a product review workshop"
```

#### Meta title and description

Principles:
- Title: 50-60 characters, primary keyword at the beginning
- Description: 150-160 characters, call to action
- Unique for each page

Example:
```
Title: "Project Academy — Online Courses for Designers"
Description: "Practical guides, templates, and workshops for design professionals. Sign up free and start today."
```

### 3. Output

```
## Content Review

### Request
[what the user asked]

### Proposal
[proposed content]

### Alternative (if relevant)
[variant]

### Notes
[considerations on tone, length, accessibility]
```

### 4. Apply

If the user approves, propose the file changes and **wait for confirmation** before applying them.

## Glossary

<!-- Fill in with project-specific terminology -->

| Term | Usage | Notes |
|------|-------|-------|
