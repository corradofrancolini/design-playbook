# Evals

Evaluation files for testing playbook skills using the [Skill Creator](https://claude.com/blog/improving-skill-creator-test-measure-and-refine-agent-skills) framework.

## Structure

```
evals/
├── trigger-eval.json           # Cross-skill trigger accuracy tests
└── README.md                   # This file

skills/<name>/evals/
└── evals.json                  # Skill-specific evals (per skill)
```

## Running evals

### Skill-specific evals

Test a single skill's behavior:

```
/skill-creator eval --skill-path skills/<name>/
```

### Trigger evaluation

Test which skill activates for which prompt:

```
/skill-creator improve --eval-set evals/trigger-eval.json --skill-path skills/<name>/
```

### Benchmark mode

Compare skill versions or measure against baseline:

```
/skill-creator benchmark --skill-path skills/<name>/
```

Produces `benchmark.json` and `benchmark.md` with pass rates, token usage, and timing.

## Eval format

Each `evals/evals.json` follows this structure:

```json
{
  "skill_name": "skill-name",
  "evals": [
    {
      "id": 1,
      "prompt": "User prompt that triggers the skill",
      "expected_output": "Description of what good output looks like",
      "assertions": [
        { "text": "What to verify in the output", "type": "contains" }
      ]
    }
  ]
}
```

## Trigger eval format

`trigger-eval.json` tests cross-skill routing:

```json
[
  { "query": "user prompt", "should_trigger": "skill-name" },
  { "query": "unrelated prompt", "should_trigger": false }
]
```

## Coverage

| Skill | Evals | Key behaviors tested |
|-------|-------|---------------------|
| setup | 5 | Guided flow, existing config detection, git init, team, skip |
| session-end | 4 | Handoff creation, name identification, save/sync language, creative direction update |
| playbook | 4 | Project state, contextual suggestions, skill details, configured state |
| creative | 4 | Divergent directions, post-rejection analysis, anti-convergence, constraint separation |
| review | 3 | Checklist execution, scope clarification, wait for confirmation |
| benchmark | 4 | Reference collection, batch input, existing benchmark detection, report generation |
| accessibility | 4 | WCAG audit, form-specific checks, visual fix picker, wait for confirmation |
| content | 4 | Microcopy, error messages, alt text, empty states |
| design-system | 3 | Token consistency, new component patterns, page-level check |
| seo | 4 | SEO audit, Core Web Vitals, wait for confirmation, dual audit |
| storybook | 4 | Stack detection, workarounds, tiered stories, CMS mocking |
| project-index | 3 | YAML detection, filesystem scan, large project handling |
