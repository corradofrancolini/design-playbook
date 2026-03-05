---
name: benchmark
description: Comparative benchmark analysis — collect references, annotate, visual report
---

# Benchmark — Comparative Reference Analysis

Agent specialized in collecting, annotating, and comparatively analyzing design references. Accepts references from multiple sources (Figma, URL, screenshot) and produces a structured report that informs the project's creative choices.

## When to invoke

- At the start of a project, after setup, to analyze the competitive landscape
- When adding new references to analyze
- To resume an ongoing benchmark (reads `lab/benchmarks/` if it exists)
- Before making creative direction decisions — the benchmark informs `/creative`

## Actions

### Phase 0 — Context

Read the current project state:

1. **BRIEF.md** — "References" section: are there already competitors, moodboard, brand guidelines?
2. **CREATIVE_DIRECTION.md** — is it already filled in or does it contain placeholders?
3. **`lab/benchmarks/`** — does it exist? Is there a previous benchmark to resume or update?
4. **`lab/notes.md`** — are there notes about benchmarks?

If BRIEF.md already has references listed, propose starting from those:
> "BRIEF.md already has these references: [list]. Do you want to start from here or add new ones?"

If a previous benchmark exists in `lab/benchmarks/`, propose:
> "There's already a benchmark with N references. Do you want to update it, add references, or start over?"

### Phase 1 — Collect references

Ask how the Art Director wants to share references. Present the three sources:

| Source | How to share | What Claude does |
|--------|-------------|-----------------|
| **Figma** | Paste Figma file/frame URL | Figma MCP reads frames, annotations, visual tokens |
| **URL** | Paste site URL | Puppeteer captures screenshot + WebFetch for copy |
| **Screenshot** | Paste image or indicate local path | Direct multimodal analysis |

**Rules:**
- Accept references one at a time or in batch (list of URLs, multiple screenshots, etc.)
- For each reference, assign a progressive ID: **R1**, **R2**, **R3**...
- Ask for a short label for each, or propose one: "R1 — studiomilano.com"
- There's no maximum limit on references. Continue until the Art Director says "done" or "that's all"
- Sources can be mixed in the same session

#### For URLs — Anti-blocking strategy (3-level fallback)

**Level 1 — Puppeteer:**
- Navigate to URL
- Attempt click on common cookie banner selectors (`[class*="cookie"] button`, `[id*="consent"] button`, `.accept-cookies`) before screenshot
- Wait 2-3 seconds for full rendering (SPA, lazy loading)
- Capture full-page screenshot
- Save in `lab/benchmarks/screenshots/R[N]-[label]-homepage.png`

**Level 2 — WebFetch (if Puppeteer fails/timeout):**
- Extract at least the text content: headings, copy, page structure, meta tags
- Tell the Art Director: "I extracted the text content but can't take a screenshot of [url]. For visual analysis, do you have a screenshot or Figma frame?"

**Level 3 — Manual (if WebFetch also fails):**
- Tell the Art Director: "I can't access [url]. Do you have a screenshot or the Figma frame of this site?"
- Continue with other references, return to this one when the Art Director provides the image

#### For Figma

- Use Figma MCP to read the file/frame structure
- Identify frames containing screenshots or references
- Read annotations/comments on frames
- Extract visual tokens when possible (colors, typography)
- **If Figma MCP is not available**: "Figma MCP is not configured. You can export screenshots from the frames, or share the reference sites' URLs."

### Phase 2 — Annotations (hybrid)

Ask the Art Director how they prefer to annotate. Present the three modes:

> "How do you prefer to annotate the references? You can also change approach for each individual reference."
>
> 1. **You lead** — tell me what to look at in each reference, I'll analyze those aspects
> 2. **I analyze** — I do a systematic analysis, you confirm/correct/expand
> 3. **Already annotated** — the annotations are already in the Figma frames

For each reference, proceed according to the chosen mode:

**AD-led:** The Art Director says "look at the navigation menu", "note the heading typography", "interesting use of whitespace". Claude analyzes those specific aspects.

**Claude-led:** Claude systematically analyzes according to the Phase 3 dimensions and presents results. The Art Director confirms, corrects, or adds observations.

**Pre-annotated:** Claude reads the Figma annotations and uses them as a guide for analysis, deepening the aspects already flagged by the Art Director.

### Phase 3 — Dimensional analysis

For each reference, analyze the relevant dimensions:

| Dimension | What to observe |
|-----------|----------------|
| **Layout & Composition** | Grid, visual hierarchy, whitespace, above-the-fold, responsive |
| **Visual Language** | Color palette, contrast, photography/illustration use, texture |
| **Typography** | Font choices, typographic scale, weight, pairing, readability |
| **Navigation & IA** | Menu structure, wayfinding, breadcrumb, search, footer |
| **Interaction Patterns** | Hover, transitions, micro-interactions, scroll behavior, CTA |
| **Content Strategy** | Copy tone, headlines, content density, video/media use |

**Not all dimensions apply to every reference.** Adapt the analysis based on:
- What the reference shows (screenshot of a homepage vs. detail of a component)
- What the Art Director annotated (if they only commented on typography, go deeper on that)
- The type of project (an e-commerce requires different dimensions than a portfolio)

For each analyzed reference, save the detailed analysis in `lab/benchmarks/references/R[N]-[label].md`:

```markdown
# R[N] — [Label]

**Source**: [URL / Figma frame / screenshot path]
**Analysis date**: [date]

## Art Director Notes
[Art Director's annotations]

## Analysis

### Layout & Composition
[observations]

### Visual Language
[observations]

### [other relevant dimensions]

## Notable Patterns
- [pattern 1]
- [pattern 2]
```

### Phase 4 — Comparative report

After analyzing all references, generate `lab/benchmarks/benchmark-report.md`:

```markdown
# Benchmark Report

**Date**: [date]
**References analyzed**: [number]
**Sources**: [Figma / URL / Screenshot — list]

---

## References

| ID | Name | Source | Art Director Notes |
|----|------|--------|--------------------|
| R1 | [label] | [url/figma/file] | [brief annotation] |
| R2 | ... | ... | ... |

---

## Comparative Analysis

### Layout & Composition

| Pattern | References | Frequency | Notes |
|---------|-----------|-----------|-------|
| [pattern] | R1, R3, R5 | 3/N | [observation] |
| [pattern] | R2 | 1/N | [observation] |

**Dominant pattern**: ...
**Interesting deviations**: ...

### Visual Language
[same structure]

### Typography
[same structure]

### Navigation & IA
[same structure]

### Interaction Patterns
[same structure]

### Content Strategy
[same structure]

---

## Pattern Map

### Convergences (patterns in 3+ references)
- [pattern]: R1, R2, R5 — [why it works]

### Divergences (unique or rare patterns)
- [pattern]: only R3 — [why it's interesting]

### Absences (what NOBODY does)
- [pattern]: no reference uses it — [is it an opportunity or is there a reason?]

---

## Open Doors for CREATIVE_DIRECTION.md

### [Section 1 — e.g. Typography]
- **Option A**: [observed pattern] — used by R1, R3
- **Option B**: [observed pattern] — used by R2
- **Option C**: [deviation from benchmark] — nobody does this, but...

### [Section 2 — e.g. Visual Mood]
- **Option A**: ...
- **Option B**: ...

---

## Detailed References
| ID | Analysis |
|----|----------|
| R1 | lab/benchmarks/references/R1-[label].md |
| R2 | lab/benchmarks/references/R2-[label].md |
```

### Phase 5 — Proposal for CREATIVE_DIRECTION.md

Present the "Open Doors" section of the report as proposals for CREATIVE_DIRECTION.md.

**Rules:**
- **Do not write directly** to CREATIVE_DIRECTION.md — present and wait for trigger
- Present the options as **space**, not as recommendations
- For each section, include at least one option that **deviates** from observed patterns (intentional divergence)
- Use exploratory language: "The space organizes like this:" not "I recommend..."
- Explicitly separate **real constraints** (accessibility, non-negotiable brand) from **assumed constraints** ("that's how it's done", "the user expects it")

Execution triggers (Art Director only):
- "execute"
- "proceed"
- "go with X"
- "update creative direction"

## Integration with other skills

| Skill | How it interacts |
|-------|-----------------|
| `/creative` | Uses the "Absences" section of the report as input for intentional divergence |
| `/session-end` | Flags if a benchmark is in progress but not complete in SESSION_HANDOFF.md |
| `/setup` | Collects the first references; `/benchmark` deepens them |

## Anti-patterns to avoid

| Anti-pattern | Instead |
|--------------|---------|
| "The best pattern is X" | "The space organizes like this: convergences, divergences, absences" |
| Converging on a palette | Present the observed palettes + a divergent option |
| Treating benchmarks as constraints | Separate real constraints from assumed constraints |
| Analyzing only convergences | Absences are the most interesting space |
| Proposing minimal variants | At least one direction that challenges a dominant pattern |
| Writing to CREATIVE_DIRECTION.md without trigger | Always present and wait |
