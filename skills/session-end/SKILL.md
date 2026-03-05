---
name: session-end
description: Closes the session by creating handoff, session log, and proposing to save
---

# Session End

The user is about to close the session. You must create the handoff, the session log, and propose to save.

## Phase 0 — Identification

If you don't know the user's name from the conversation:
1. Check the Team list in CLAUDE.md
2. Ask: "What name should I use for this session?"
3. Fallback: use `git config user.name` if available

Use the name for filenames and the Author field.

## Phase 1 — Read current state

Before creating the handoff, read the most recent file in `docs/handoffs/` to understand where things left off (it may be from a different person).

## Phase 2 — Create handoff

Create a new file in `docs/handoffs/` with naming: `YYYY-MM-DD_HH-MM_name.md`

File contents:

```markdown
# Handoff — [DATE] [TIME]

**Author:** [name]

---

## Current State

- [what works]
- [what's in progress]
- [what's blocked]

---

## Completed Work

1. [Task 1]
2. [Task 2]

---

## Immediate Next Step

- [1 concrete action]

---

## Open Issues

[list or "None"]

---

## Modified Files

| File | Change type | Notes |
|------|-------------|-------|
| `path/to/file` | Created/Modified | [brief description] |
```

## Phase 3 — Create/Update Session Log

Create `docs/sessions/YYYY-MM-DD_name.md` using the template in `docs/sessions/TEMPLATE.md`.

If a session log for the same day and person already exists, append the completed work.

Fill in the **Author** field with the user's name.

## Phase 4 — Update lab/notes.md (if applicable)

If there are session notes not yet recorded, add them.
Use the convention: `## [DATE] — [name]` as the block heading.

## Phase 5 — Update CREATIVE_DIRECTION.md (if applicable)

If mature design decisions were made in this session, transfer them from `lab/notes.md` to `CREATIVE_DIRECTION.md`.

Fill in the **Who** column with the user's name.

## Phase 6 — Save and sync

If the project is a git repository:

1. **Show** the files modified in this session (`git status`)
2. **Ask**: "Do you want to save your changes?"
   - If YES: propose a save message based on the completed work
     (e.g. "Updated color palette and heading typography")
   - If NO: skip (files remain modified locally)
3. If a remote exists and the user saved:
   - **Ask**: "Do you want to sync with the team?"
   - If YES: pull first (to integrate others' changes), then push
   - If there are conflicts: explain in plain language what happened
     and propose a resolution
   - If NO: skip (the save stays local)

**Language to use with the team:**
- "save" → git add + commit
- "sync" → git pull + push
- "[name]'s changes" → someone else's commits
- "overlap" → merge conflict

## Phase 7 — Confirmation

After completing everything, confirm to the user:
- Which files were updated
- Whether the work was saved and synced
- Very brief status summary
- "You can close the session."
