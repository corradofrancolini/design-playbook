# Changelog

## [2.0.0] — 2026-03-05

### Added
- **Multi-user collaboration**: multiple people can work on the same project without conflicts
- **Handoff directory**: `docs/handoffs/` — one file per session (date, time, author), no overwrites
- **Identity tracking**: Claude asks name at session start; Team list in CLAUDE.md; `git config` fallback
- **Git workflow for non-developers**: `/session-end` proposes "save" (commit) and "sync" (push); `/setup` handles `git init`
- **`assets/` directory**: source materials (brand guidelines, moodboard, client brief), committed and shared
- **`.playbook-version` file**: version tracking for automatic migration
- **Automatic migration**: installer detects v1 projects, migrates SESSION_HANDOFF.md content, cleans gitignore

### Changed
- `SESSION_HANDOFF.md` is now a pointer to `docs/handoffs/` (was the handoff itself)
- `lab/` is now committed and shared (was gitignored)
- `.gitignore` only ignores `docs/sessions/` (was `docs/` and `lab/`)
- `session-end` skill rewritten: 7 phases with identity, handoff directory, git save/sync
- `setup` skill: added git init step and team size question
- `playbook` skill: updated for new structure
- `BACKLOG.md` and `CREATIVE_DIRECTION.md`: added "Chi" column for attribution
- `docs/sessions/TEMPLATE.md`: added "Autore" field

## [1.3.0] — 2026-03-04

### Added
- **benchmark** skill: comparative benchmark analysis — collect references from Figma, URLs, or screenshots; hybrid annotations; dimensional analysis; pattern map (convergences, divergences, absences); proposals for CREATIVE_DIRECTION.md

## [1.2.0] — 2026-02-28

### Added
- **playbook** skill: quick reference guide — project state, available skills, getting started steps
- **setup** skill: guided project configuration — fills BRIEF.md, CREATIVE_DIRECTION.md, adapts CLAUDE.md
- First-session detection in `CLAUDE.md`: Claude proactively introduces the playbook on initial use
- Enhanced post-install summary: shows all installed files, skills with descriptions, and getting started steps

## [1.1.0] — 2026-02-28

### Added
- **storybook** skill: scaffolds Storybook component library with Tailwind 4 workarounds, tiered story approach, vitest browser testing
- `--skill <name>` flag: install a single skill into an existing project
- `--list-skills` flag: list available skills

## [1.0.0] — 2026-02-26

Initial release: 8 scaffold files, 8 skills, idempotent installer.
