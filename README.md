# design-playbook

A complete methodology for Art Director + AI collaborative projects. Installs process files, session continuity tools, and 12 Claude Code skills into any project. Supports solo and multi-person teams.

## Table of contents

- [Quick start](#quick-start)
- [What it installs](#what-it-installs)
- [How to use](#how-to-use)
  - [First session](#first-session)
  - [Working with the Adjacent Possible](#working-with-the-adjacent-possible)
  - [When to use each skill](#when-to-use-each-skill)
  - [Closing a session](#closing-a-session)
  - [Picking up the next session](#picking-up-the-next-session)
- [The method](#the-method)
- [Project structure after installation](#project-structure-after-installation)
- [Customization](#customization)
  - [Adding skills](#adding-skills)
  - [Removing skills](#removing-skills)
  - [Figma integration](#optional-figma-integration)
- [Using from Claude Desktop](#using-from-claude-desktop)
- [Working in a team](#working-in-a-team)
- [Re-running the installer](#re-running-the-installer)

## Quick start

First time — clone the toolkit and install into your project in one go:

```bash
git clone https://github.com/corradofrancolini/design-playbook.git && ./design-playbook/install.sh ~/Projects/my-project
```

Replace `my-project` with the name of the project you'll work on (e.g. `brand-redesign`, `landing-page`). The folder is created if it doesn't exist.

Already cloned? For additional projects, just run the installer:

```bash
./design-playbook/install.sh ~/Projects/another-project
```

The installer will:
1. Ask for the project name (or use `--name`)
2. Migrate existing installations if needed
3. Copy scaffold files into the project root
4. Install 12 skills into `.claude/skills/`
5. Update `.gitignore`
6. Write `.playbook-version`

## What it installs

### Scaffold files (project root)

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Project protocol — Adjacent Possible methodology, AD/AI workflow, team list |
| `BRIEF.md` | Project brief — scope, target, content, references, constraints |
| `STACK.md` | Tech stack, architecture decisions, dependencies, patterns |
| `SESSION_HANDOFF.md` | Pointer to `docs/handoffs/` (latest handoff) |
| `BACKLOG.md` | Active backlog, open decisions, closed decisions |
| `CREATIVE_DIRECTION.md` | Creative direction — palette, typography, visual mood, design decisions |
| `lab/PROCESS.md` | Anti-sycophancy methodology and operational protocol |
| `lab/notes.md` | Working notes, benchmarks, design decisions |
| `docs/handoffs/` | Session handoffs — one file per session, shared with team |
| `docs/sessions/TEMPLATE.md` | Session log template (personal, gitignored) |
| `assets/` | Source materials — brand guidelines, moodboard, client brief |

### Skills (`.claude/skills/`)

| Skill | Description |
|-------|-------------|
| `session-end` | Session closing — creates handoff, session log, proposes save and sync |
| `creative` | Structured divergence — maps possibility space, prevents premature convergence |
| `review` | Code review — correctness, performance, security, maintainability, accessibility |
| `accessibility` | WCAG 2.1/2.2 AA audit with visual fix picker |
| `content` | Microcopy, error messages, alt text, meta tags, tone of voice |
| `design-system` | Token, component, and pattern consistency checks |
| `seo` | SEO and performance audit with Core Web Vitals |
| `project-index` | Visual project map generator |
| `storybook` | Storybook scaffold — component library, tests, Tailwind/RSC workarounds |
| `playbook` | Quick reference — project state, available skills, getting started |
| `setup` | Guided project setup — fills BRIEF.md, CREATIVE_DIRECTION.md, configures CLAUDE.md |
| `benchmark` | Comparative benchmark analysis — collect references, annotate, visual report |

## How to use

### First session

After installing, open Claude Code in the project directory. Claude will automatically introduce the playbook and its capabilities on the first session.

**Quickest path:** run `/setup` — it walks you through filling BRIEF.md, STACK.md, and CREATIVE_DIRECTION.md with guided questions.

**Manual path:**

1. **`BRIEF.md`** — fill in project scope, target, content, references, constraints
2. **`STACK.md`** — fill in framework, dependencies, architecture decisions, patterns
3. **`CREATIVE_DIRECTION.md`** — fill in palette, typography, visual mood
4. **`CLAUDE.md`** — adjust the project structure section to match your stack
4. **`review` skill** — uncomment the stack-specific sections relevant to your project (React/Next.js, Vue/Nuxt, Tailwind, TypeScript, Python)
5. **`content` skill** — fill in the glossary table with project-specific terminology

See [extras/examples/](extras/examples/) for filled-in examples of these files.

From this point on, `CLAUDE.md` is loaded automatically as project protocol every time Claude Code opens the directory. Type `/playbook` anytime for a quick reference.

### Working with the Adjacent Possible

By default, Claude does not execute. It maps options, names trade-offs, and flags doors that close. To trigger execution, use explicit commands:

- "execute", "proceed", "go with X", "do it", or any unambiguous imperative

Everything else is exploration. When in doubt, Claude asks.

Details in `CLAUDE.md` (protocol) and `lab/PROCESS.md` (methodology).

### When to use each skill

| When | Skill |
|------|-------|
| First time setup — filling brief and creative direction | `/setup` |
| Analyzing competitors and design references | `/benchmark` |
| Fork in the road — choosing between directions | `/creative` |
| Component or feature completed | `/review` |
| Before releasing a page | `/accessibility`, `/seo` |
| Writing text, labels, error messages | `/content` |
| Checking token and component consistency | `/design-system` |
| Mapping the project visually | `/project-index` |
| Setting up component library and visual tests | `/storybook` |
| Need a quick reference or forgot what's available | `/playbook` |
| End of session (always) | `/session-end` |

### Closing a session

Invoke `/session-end` at the end of every session, even short ones. It will:

1. Create a handoff in `docs/handoffs/` with current state, completed work, next step
2. Create a session log in `docs/sessions/`
3. Consolidate `lab/notes.md`
4. Promote mature design decisions to `CREATIVE_DIRECTION.md`
5. Propose to save (commit) and sync (push) — Claude handles all git operations

### Picking up the next session

When Claude Code opens the project in a new session:

- `CLAUDE.md` is loaded automatically (protocol is active)
- Claude reads the latest handoff from `docs/handoffs/` — what was done, what's next, what's blocked
- The session log in `docs/sessions/` has the full detail

Nothing to do manually. Session continuity is handled by `/session-end`.

## The method

### Adjacent Possible

The AI does not converge by default. For every decision, it:

- **Maps options** — presents alternatives, not just the most likely one
- **Names trade-offs** — every option has a cost and a benefit
- **Flags closed doors** — every choice precludes others; says which, and the cost to reopen
- **Signals jumps** — warns before irreversible or high-cost decisions

Execution happens only on explicit trigger from the Art Director ("execute", "proceed", "go with X", or any unambiguous imperative).

### Anti-sycophancy

AI assistants trained with RLHF tend to agree with the user. This methodology includes:

- **Exploitation vs exploration** framework — recognize when the AI is optimizing locally vs exploring broadly
- **Post-rejection analysis** — when the AD rejects a proposal, analyze *why* before proposing alternatives
- **Structured divergence** — systematic techniques to break out of convergent thinking

Details in `lab/PROCESS.md` after installation.

### Session continuity

Each session produces artifacts that feed the next:

```
docs/handoffs/         ←  one handoff per session (shared with team)
docs/sessions/         ←  one log per session (personal)
BACKLOG.md             ←  decisions tracked
CREATIVE_DIRECTION.md  ←  design decisions accumulated
lab/notes.md           ←  working notes preserved
```

## Project structure after installation

```
my-project/
├── CLAUDE.md
├── BRIEF.md
├── STACK.md
├── SESSION_HANDOFF.md       ← pointer to docs/handoffs/
├── BACKLOG.md
├── CREATIVE_DIRECTION.md
├── assets/                  ← source materials (committed)
├── lab/                     ← experiments, notes (committed)
│   ├── PROCESS.md
│   └── notes.md
├── docs/
│   ├── handoffs/            ← session handoffs (committed, shared)
│   └── sessions/            ← session logs (gitignored, personal)
│       └── TEMPLATE.md
├── .claude/
│   └── skills/              ← 12 skills
├── .playbook-version
└── .gitignore
```

Only `docs/sessions/` is gitignored (personal session logs). Everything else — `lab/`, `docs/handoffs/`, `assets/` — is committed and shared with the team.

## Customization

### Adding skills

Drop a `SKILL.md` file into `.claude/skills/<skill-name>/`. Claude Code picks it up automatically.

### Removing skills

Delete the skill directory from `.claude/skills/`.

### Optional: Figma integration

For bidirectional Figma integration (design-to-code, code-to-Figma, token extraction, Code Connect), install the official [Figma plugin for Claude Code](https://github.com/mcp/com.figma.mcp/mcp):

```bash
claude plugin install figma@claude-plugins-official
```

The plugin configures the Figma MCP server and installs agent skills for implementing designs, connecting components, and creating design system rules.

## Using from Claude Desktop

If you use Claude Code from Claude Desktop, you can install the playbook entirely from the chat — no need to open a separate terminal.

**First time — clone and install in one step:**

```bash
git clone https://github.com/corradofrancolini/design-playbook.git ~/Projects/design-playbook && ~/Projects/design-playbook/install.sh --name "brand-redesign" --force ~/Projects/brand-redesign
```

Replace `brand-redesign` with your project name. Use `--name` and `--force` to skip interactive prompts (Claude Code doesn't have an interactive terminal).

**Already cloned? Just install:**

```bash
~/Projects/design-playbook/install.sh --name "another-project" --force ~/Projects/another-project
```

| Flag | What it does |
|------|-------------|
| `--name <name>` | Sets project name without prompting |
| `--force` | Overwrites existing files without asking |
| `--skill <name>` | Install a single skill (skip scaffold) |
| `--list-skills` | List available skills |

Claude Code will execute the script, and from that point on `CLAUDE.md` and all 12 skills are active in the project directory.

**What works automatically:**
- `CLAUDE.md` is loaded as project instructions
- Skills in `.claude/skills/` are available and invocable
- `/session-end` creates handoffs, session logs, and proposes to save — no extra configuration needed

## Working in a team

The playbook supports multiple people working on the same project. No git knowledge required — Claude handles all version control.

### How it works

- **Identity**: Claude asks your name at the start of each session. Names are listed in CLAUDE.md (Team section).
- **Handoffs**: each `/session-end` creates a separate file in `docs/handoffs/` with date, time, and author. No overwrites, no collisions.
- **Saving**: `/session-end` proposes to "save" (commit) and "sync" (push) your changes. Accept and Claude does the rest.
- **Picking up**: at the start of a session, Claude reads the latest handoff — regardless of who wrote it.
- **Conflicts**: if two people modify the same file, Claude explains the overlap and proposes a resolution.

### Git for non-developers

Claude is the git interface. You never need to type git commands:

| What you want | What to do |
|---------------|-----------|
| Save your work | `/session-end` → "save changes" |
| Share with the team | `/session-end` → "sync with team" |
| Start a new project as a repo | `/setup` handles `git init` |
| See what changed | Claude shows modified files during `/session-end` |

### Source materials

Put brand guidelines, moodboards, client briefs, and other reference files in `assets/`. This directory is committed and shared with the team.

## Re-running the installer

The installer is safe to re-run. It will:
- Detect existing installations and migrate automatically (e.g. v1 → v2)
- Ask before overwriting existing files (default: skip)
- Clean obsolete `.gitignore` entries and add new ones
- Report what was installed and what was skipped

## Updating

When new skills or features are added to the playbook:

1. **Pull the latest version** of the playbook repo:
   ```bash
   cd ~/Projects/design-playbook && git pull
   ```

2. **Check what changed** in `CHANGELOG.md`

3. **Install new skills** without touching your existing scaffold:
   ```bash
   ./design-playbook/install.sh --skill <name> ~/Projects/my-project
   ```

4. Or **re-run the full installer** — it will ask before overwriting anything:
   ```bash
   ./design-playbook/install.sh ~/Projects/my-project
   ```

To see all available skills: `./design-playbook/install.sh --list-skills`

### Updating to v2.0.0

v2.0.0 adds multi-user collaboration, `assets/` directory, handoff directory, and automatic git workflow. Re-run the full installer:

```bash
cd ~/Projects/design-playbook && git pull
./design-playbook/install.sh ~/Projects/my-project
```

The installer automatically:
- Migrates your existing `SESSION_HANDOFF.md` content to `docs/handoffs/`
- Removes obsolete `.gitignore` entries (`docs/`, `lab/`) and adds `docs/sessions/`
- Creates `assets/` and `docs/handoffs/` directories
- Writes `.playbook-version`

Scaffold files will ask before overwriting — you can skip files you've customized.

### Updating to v1.2.0

v1.2.0 adds two new skills (`/playbook` and `/setup`) and a first-session introduction in `CLAUDE.md`. If you already have a project set up:

```bash
cd ~/Projects/design-playbook && git pull
./design-playbook/install.sh --skill playbook ~/Projects/my-project
./design-playbook/install.sh --skill setup ~/Projects/my-project
```

The first-session introduction in `CLAUDE.md` only applies to new projects. For existing projects it is not needed — you already know the playbook. Run `/playbook` anytime for a quick reference.

## License

MIT
