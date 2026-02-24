# design-playbook

A complete methodology for Art Director + AI collaborative projects. Installs process files, session continuity tools, and 8 Claude Code skills into any project.

Born from the [Adjacent Possible](https://en.wikipedia.org/wiki/Adjacent_possible) — the idea that innovation happens at the edge of what already exists, one step at a time.

## Quick start

```bash
git clone https://github.com/corradofrancolini/design-playbook.git
./design-playbook/install.sh ~/Projects/my-project
```

The installer will:
1. Ask for the project name
2. Copy scaffold files into the project root
3. Install 8 skills into `.claude/skills/`
4. Update `.gitignore`

## What it installs

### Scaffold files (project root)

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Project protocol — Adjacent Possible methodology, AD/AI workflow, execution triggers |
| `SESSION_HANDOFF.md` | Current project state, updated at the end of each session |
| `BACKLOG.md` | Active backlog, open decisions, closed decisions |
| `CREATIVE_DIRECTION.md` | Creative brief — palette, typography, visual mood, constraints |
| `lab/PROCESS.md` | Anti-sycophancy methodology and operational protocol |
| `lab/notes.md` | Working notes, benchmarks, design decisions |
| `docs/sessions/TEMPLATE.md` | Session log template |

### Skills (`.claude/skills/`)

| Skill | Description |
|-------|-------------|
| `session-end` | Session closing protocol — updates handoff, session log, notes, creative direction |
| `creative` | Structured divergence — maps possibility space, prevents premature convergence |
| `review` | Code review — correctness, performance, security, maintainability, accessibility |
| `accessibility` | WCAG 2.1/2.2 AA audit with visual fix picker |
| `content` | Microcopy, error messages, alt text, meta tags, tone of voice |
| `design-system` | Token, component, and pattern consistency checks |
| `seo` | SEO and performance audit with Core Web Vitals |
| `project-index` | Visual project map generator |

## The method

### Adjacent Possible

The AI does not converge by default. For every decision, it:

- **Maps options** — presents alternatives, not just the most likely one
- **Names trade-offs** — every option has a cost and a benefit
- **Flags closed doors** — every choice precludes others; says which, and the cost to reopen
- **Signals jumps** — warns before irreversible or high-cost decisions

Execution happens only on explicit trigger from the Art Director ("esegui", "procedi", "vai con X", or any unambiguous imperative).

### Anti-sycophancy

AI assistants trained with RLHF tend to agree with the user. This methodology includes:

- **Exploitation vs exploration** framework — recognize when the AI is optimizing locally vs exploring broadly
- **Post-rejection analysis** — when the AD rejects a proposal, analyze *why* before proposing alternatives
- **Structured divergence** — systematic techniques to break out of convergent thinking

Details in `lab/PROCESS.md` after installation.

### Session continuity

Each session produces artifacts that feed the next:

```
SESSION_HANDOFF.md  ←  updated by /session-end
docs/sessions/      ←  one log per session
BACKLOG.md          ←  decisions tracked
CREATIVE_DIRECTION.md  ←  design decisions accumulated
lab/notes.md        ←  working notes preserved
```

## Project structure after installation

```
my-project/
├── CLAUDE.md
├── SESSION_HANDOFF.md
├── BACKLOG.md
├── CREATIVE_DIRECTION.md
├── lab/
│   ├── PROCESS.md
│   └── notes.md
├── docs/
│   └── sessions/
│       └── TEMPLATE.md
├── .claude/
│   └── skills/
│       ├── session-end/SKILL.md
│       ├── creative/SKILL.md
│       ├── review/SKILL.md
│       ├── accessibility/SKILL.md
│       ├── content/SKILL.md
│       ├── design-system/SKILL.md
│       ├── seo/SKILL.md
│       └── project-index/SKILL.md
└── .gitignore  (updated)
```

`docs/` and `lab/` are gitignored by default — they are local process files, not project deliverables.

## Customization

### First session checklist

After installing, open Claude Code in the project and:

1. **`CREATIVE_DIRECTION.md`** — fill in constraints, typography, visual mood
2. **`CLAUDE.md`** — adjust the project structure section to match your stack
3. **`review` skill** — uncomment the stack-specific sections relevant to your project (React/Next.js, Vue/Nuxt, Tailwind, TypeScript, Python)
4. **`content` skill** — fill in the glossary table with project-specific terminology

### Adding skills

Drop a `SKILL.md` file into `.claude/skills/<skill-name>/`. Claude Code picks it up automatically.

### Removing skills

Delete the skill directory from `.claude/skills/`.

## Re-running the installer

The installer is safe to re-run. It will:
- Ask before overwriting existing files (default: skip)
- Not duplicate `.gitignore` entries
- Report what was installed and what was skipped

## License

MIT
