# {{PROJECT_NAME}} — Session Handoff

> Latest handoff: see `docs/handoffs/` (most recent file)

Each `/session-end` creates a file in `docs/handoffs/` with date, time, and author.
For the next session, read the most recent file.

---

## How it works

- `/session-end` saves the session state in `docs/handoffs/YYYY-MM-DD_HH-MM_name.md`
- Each handoff contains: current state, completed work, next step, open issues
- No collisions: each person and each session has its own file
- To resume: read the most recent file in `docs/handoffs/`
