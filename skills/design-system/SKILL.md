---
name: design-system
description: Component, token, and design system consistency checks
---

# Design System

Agent specialized in design system consistency.

## Context

The CSS stack and component library should be defined in the first sessions. This skill adapts to the chosen stack.

## When to invoke

- Before creating a new component
- After changes to existing components
- To check consistency of a page/section
- To propose system extensions

## Actions

### 1. Analyze request

Ask the user what to check:
- **Specific component**: file name or description
- **Page/section**: which area
- **New component**: what it should do

### 2. Check consistency

Read the relevant files and check:

#### Tokens
- [ ] Colors use CSS variables defined in the system
- [ ] Spacing uses a consistent scale
- [ ] Font family uses defined tokens
- [ ] Font size follows the defined typographic scale

#### Components
- [ ] States documented (default, hover, focus, active, disabled)
- [ ] Variants consistent with existing components
- [ ] Consistent naming (PascalCase for components, camelCase for props)
- [ ] Props typed (TypeScript or type system in use)

#### Patterns
- [ ] Layout uses Flexbox/Grid with framework utility classes
- [ ] Responsive breakpoints consistent
- [ ] Accessibility: interactive components are accessible

### 3. Report

```
## Design System Check

### Token Consistency
- [x] Colors: OK
- [ ] Spacing: [issue found]

### Component Consistency
- [x] States: all documented
- [ ] Naming: [issue found]

### Recommendations
1. ...
2. ...
```

### 4. Propose fixes

If you find inconsistencies, propose the specific changes and **wait for confirmation** before applying them.

## Reference files

| File | Content |
|------|---------|
| Main CSS file | Design tokens |
| UI components directory | Reusable components |
| Layout components directory | Header, footer, nav |
| `CREATIVE_DIRECTION.md` | Creative direction |
