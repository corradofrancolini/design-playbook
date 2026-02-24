# design-playbook

A complete methodology for Art Director + AI collaborative projects. Installs process files, session continuity tools, and 8 Claude Code skills into any project.

## Quick start

```bash
git clone https://github.com/corradofrancolini/design-playbook.git
./design-playbook/install.sh ~/Projects/my-project
```

Or non-interactively (useful from Claude Desktop):

```bash
./design-playbook/install.sh --name "my-project" --force ~/Projects/my-project
```

The installer will:
1. Ask for the project name (or use `--name`)
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

## How to use

### First session

After installing, open Claude Code in the project directory. In the first session:

1. **`CREATIVE_DIRECTION.md`** — fill in constraints, palette, typography, visual mood
2. **`CLAUDE.md`** — adjust the project structure section to match your stack
3. **`review` skill** — uncomment the stack-specific sections relevant to your project (React/Next.js, Vue/Nuxt, Tailwind, TypeScript, Python)
4. **`content` skill** — fill in the glossary table with project-specific terminology

From this point on, `CLAUDE.md` is loaded automatically as project protocol every time Claude Code opens the directory.

### Working with the Adjacent Possible

By default, Claude does not execute. It maps options, names trade-offs, and flags doors that close. To trigger execution, use explicit commands:

- "esegui", "procedi", "vai con X", "fallo", or any unambiguous imperative

Everything else is exploration. When in doubt, Claude asks.

Details in `CLAUDE.md` (protocol) and `lab/PROCESS.md` (methodology).

### When to use each skill

| When | Skill |
|------|-------|
| Fork in the road — choosing between directions | `/creative` |
| Component or feature completed | `/review` |
| Before releasing a page | `/accessibility`, `/seo` |
| Writing text, labels, error messages | `/content` |
| Checking token and component consistency | `/design-system` |
| Mapping the project visually | `/project-index` |
| End of session (always) | `/session-end` |

### Closing a session

Invoke `/session-end` at the end of every session, even short ones. It will:

1. Update `SESSION_HANDOFF.md` with current state, completed work, next step, open problems
2. Create a session log in `docs/sessions/`
3. Consolidate `lab/notes.md`
4. Promote mature design decisions to `CREATIVE_DIRECTION.md`

### Picking up the next session

When Claude Code opens the project in a new session:

- `CLAUDE.md` is loaded automatically (protocol is active)
- `SESSION_HANDOFF.md` provides immediate context — what was done, what's next, what's blocked
- The session log in `docs/sessions/` has the full detail

Nothing to do manually. Session continuity is handled by `/session-end`.

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

### Adding skills

Drop a `SKILL.md` file into `.claude/skills/<skill-name>/`. Claude Code picks it up automatically.

### Removing skills

Delete the skill directory from `.claude/skills/`.

## Using from Claude Desktop

If you use Claude Code from Claude Desktop, you can install the playbook entirely from the chat — no need to open a separate terminal.

**Setup (one time):** clone the repo anywhere on your machine. Ask Claude:

> Clone https://github.com/corradofrancolini/design-playbook.git into ~/Projects

**Install into a project:** ask Claude to run the installer with `--name` and `--force` to skip interactive prompts (Claude Code doesn't have an interactive terminal):

> Run ~/Projects/design-playbook/install.sh --name "my-project" --force ~/Projects/my-project

| Flag | What it does |
|------|-------------|
| `--name <name>` | Sets project name without prompting |
| `--force` | Overwrites existing files without asking |

Claude Code will execute the script, and from that point on `CLAUDE.md` and all 8 skills are active in the project directory.

**What works automatically:**
- `CLAUDE.md` is loaded as project instructions
- Skills in `.claude/skills/` are available and invocable
- `/session-end` writes to local files (`SESSION_HANDOFF.md`, `docs/sessions/`, `lab/notes.md`) — no extra configuration needed

## Re-running the installer

The installer is safe to re-run. It will:
- Ask before overwriting existing files (default: skip)
- Not duplicate `.gitignore` entries
- Report what was installed and what was skipped

## License

MIT
