---
name: review
description: Code review for quality, patterns, and best practices
---

# Code Review

Agent specialized in code review.

## Context

The project's tech stack should be defined in the first working session. This skill adapts to the chosen stack.

## When to invoke

- Before committing significant changes
- After writing a new component or module
- To verify patterns and best practices
- To identify performance/security issues

## Actions

### 1. Identify scope

Ask the user:
- **Specific files**: path or glob pattern
- **Latest commit**: review recent changes
- **Area**: components, API, styling, etc.

### 2. Run review

Read the files and check the categories below.

### 3. Report

```
## Code Review

**Scope**: [file/area]
**Date**: [date]

### Summary

| Category | Issues |
|----------|--------|
| Correctness | 0 |
| Performance | 0 |
| Security | 0 |
| Maintainability | 0 |
| Accessibility | 0 |

### Issues

#### [High] Correctness — [title]
**File**: `path/to/file:line`
**Problem**: [description]
**Proposed fix**: [code]

### Suggestions (non-blocking)
- ...
```

### 4. Propose fixes

For each issue, propose the change and **wait for confirmation** before applying it.

---

## Review Checklist

### Correctness

- [ ] Logic correct, edge cases handled
- [ ] Error handling present and appropriate
- [ ] Types correct, no unnecessary `any`
- [ ] Null/undefined checks where needed
- [ ] Async/await used correctly

### Performance

- [ ] No unnecessary re-renders (inline objects, inline functions)
- [ ] Memo/useMemo/useCallback where appropriate
- [ ] No blocking operations in render path
- [ ] Images optimized
- [ ] Bundle size considered (specific imports vs barrel)

### Security

- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] SQL injection prevented (parameterized queries)
- [ ] XSS prevented (escaped output, no dangerouslySetInnerHTML)
- [ ] CSRF considered for mutations
- [ ] Auth checks on protected routes

### Maintainability

- [ ] Clear and consistent naming
- [ ] Functions/components not too long (<100 lines ideal)
- [ ] Single responsibility principle
- [ ] DRY without over-engineering
- [ ] Comments only where necessary (self-documenting code)
- [ ] No magic numbers/strings (use constants)

### Accessibility

- [ ] Semantic HTML
- [ ] Correct ARIA attributes
- [ ] Keyboard navigation working
- [ ] Appropriate focus management
- [ ] Alt text for images

<!-- Stack-specific sections: uncomment those relevant to the project. -->

<!--
### React / Next.js

- [ ] Server vs Client Components chosen appropriately
- [ ] `'use client'` only where needed
- [ ] Metadata exported for SEO
- [ ] Loading/error states handled
- [ ] Suspense boundaries where appropriate
-->

<!--
### Vue / Nuxt

- [ ] Composition API used consistently
- [ ] Correct use of computed vs methods
- [ ] Reactive state managed correctly
- [ ] SEO meta handled via useHead/useSeoMeta
- [ ] Lazy loading for routes and components
-->

<!--
### Tailwind

- [ ] Classes ordered (layout > spacing > typography > colors > effects)
- [ ] Design tokens used instead of arbitrary values
- [ ] Responsive classes consistent
- [ ] Dark mode considered (if applicable)
-->

<!--
### TypeScript

- [ ] Explicit types for props and return values
- [ ] No unnecessary `as` casts
- [ ] Discriminated unions for states
- [ ] Generics used appropriately
-->

<!--
### Python

- [ ] Type hints present
- [ ] Docstrings for public functions
- [ ] No bare `except` clauses
- [ ] Context managers for resources
- [ ] Async/sync boundaries clear
-->
