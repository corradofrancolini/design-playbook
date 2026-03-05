---
name: storybook
description: Scaffold Storybook component library with tests and design system integration
---

# Storybook

Agent specialized in scaffolding and configuring Storybook for playbook projects.

## Context

Storybook is the project's visual component library. This skill configures Storybook by adapting to the detected stack, applies known workarounds (Tailwind 4, App Router, ESM), and creates the first stories following a tiered approach.

## When to invoke

- At the start of a project, after defining the stack and design system
- When adding Storybook to an existing project
- To add stories for uncovered components
- To configure visual tests with Vitest

## Actions

### 1. Detect stack

Read `package.json` and identify:

- **Framework**: Next.js (App Router / Pages), Vite, Remix, other
- **CSS**: Tailwind 3, Tailwind 4, CSS Modules, vanilla CSS
- **TypeScript**: yes / no
- **Monorepo**: yes / no — where do the components live

Report the detected stack before proceeding. **Wait for confirmation**.

### 2. Install dependencies

```bash
npx storybook@latest init
```

Add addons:
- `@storybook/addon-vitest` — integrated tests
- `@storybook/addon-a11y` — inline accessibility audit
- `@storybook/addon-docs` — automatic documentation

#### Known workarounds

**Tailwind 4 + Vite/Next.js Vite**: Tailwind 4 uses `@import "tailwindcss"` which requires the official PostCSS plugin. Storybook with Vite can conflict. Solution:

- Create a separate `postcss.config.storybook.mjs` with only `@tailwindcss/postcss`
- In `.storybook/main.ts`, in the `viteFinal` function, point to this file:
  ```ts
  viteFinal: async (config) => {
    config.css = { ...config.css, postcss: './postcss.config.storybook.mjs' }
    return config
  }
  ```

**Next.js App Router**: Use `@storybook/nextjs-vite` as framework and enable `experimentalRSC: true` in features.

**ESM and `__dirname`**: If the project uses ESM (`"type": "module"` in `package.json`), use `import.meta.url` + `fileURLToPath` instead of `__dirname`.

**Font loading (Next.js `next/font`)**: Next.js fonts don't work in Storybook. Load fonts via CSS `@font-face` in a separate file or use the system fallback.

**CMS/API dependencies**: Components that depend on Payload, Sanity, or other APIs need mocking. Create aliases in `viteFinal` for problematic modules:
  ```ts
  config.resolve = {
    ...config.resolve,
    alias: {
      ...(config.resolve?.alias || {}),
      '@payloadcms/richtext-lexical/react': path.resolve(__dirname, '../src/__mocks__/PayloadRichText.tsx'),
    },
  }
  ```

### 3. Configure

#### `.storybook/main.ts`

```ts
import type { StorybookConfig } from '@storybook/nextjs-vite' // adapt to framework

const config: StorybookConfig = {
  stories: ['../src/components/**/*.stories.@(ts|tsx)'],
  addons: [
    '@storybook/addon-vitest',
    '@storybook/addon-a11y',
    '@storybook/addon-docs',
  ],
  framework: {
    name: '@storybook/nextjs-vite', // adapt to framework
    options: {},
  },
  features: {
    experimentalRSC: true, // Next.js App Router only
  },
  viteFinal: async (config) => {
    // PostCSS workaround for Tailwind 4
    // Aliases for CMS/API mocks
    return config
  },
}
```

#### `.storybook/preview.ts`

Read `CREATIVE_DIRECTION.md` to extract the palette and configure backgrounds:

```ts
const preview: Preview = {
  parameters: {
    backgrounds: {
      default: 'primary-bg',
      values: [
        // Use colors from CREATIVE_DIRECTION.md
      ],
    },
    layout: 'fullscreen',
    a11y: { test: 'todo' },
  },
}
```

#### `.storybook/vitest.setup.ts`

Dedicated setup file for the Storybook Vitest project (separate from root setup to avoid crashes with dotenv in browser context):

```ts
import { beforeAll } from 'vitest'
import { setProjectAnnotations } from 'storybook'
import * as previewAnnotations from './preview'

beforeAll(() => {
  setProjectAnnotations([previewAnnotations])
})
```

### 4. Create first stories

Follow a **3-tier** approach, in order of complexity:

#### Tier 1 — Pure components (no external dependencies)
- Buttons, inputs, cards, badges, dialogs
- Highest priority: immediately testable

#### Tier 2 — Components with routing/layout
- Nav, footer, sidebar
- Require mocking `usePathname`, `useRouter` via `nextjs.navigation` parameters

#### Tier 3 — CMS-dependent components
- Rich text, content blocks, forms with API
- Require explicit mocks (aliases in `viteFinal` or `__mocks__/`)

**Story template**:

```tsx
import type { Meta, StoryObj } from '@storybook/nextjs-vite'
import { ComponentName } from './ComponentName'

const meta = {
  title: 'Category/ComponentName',
  component: ComponentName,
  tags: ['autodocs'],
} satisfies Meta<typeof ComponentName>

export default meta
type Story = StoryObj<typeof meta>

export const Default: Story = {
  args: {
    // default props
  },
}
```

For each component, create at least: `Default`, main variants, and edge states (empty, loading, error where applicable).

### 5. Configure tests

Add the Storybook project to `vitest.config.mts`:

```ts
import { storybookTest } from '@storybook/addon-vitest/vitest-plugin'

export default defineConfig({
  test: {
    projects: [{
      plugins: [
        tsconfigPaths(),
        react(),
        storybookTest({ configDir: path.join(dirname, '.storybook') }),
      ],
      test: {
        name: 'storybook',
        browser: {
          enabled: true,
          headless: true,
          provider: 'playwright',
          instances: [{ browser: 'chromium' }],
        },
        setupFiles: ['.storybook/vitest.setup.ts'],
      },
    }],
  },
})
```

Verify that tests pass:

```bash
npx vitest --project storybook --run
```

### 6. Report

```
## Storybook Setup

### Detected Stack
- Framework: [Next.js App Router / Vite / ...]
- CSS: [Tailwind 4 / Tailwind 3 / CSS Modules / ...]
- TypeScript: [yes / no]

### Applied Workarounds
- [ ] Separate PostCSS for Tailwind 4
- [ ] experimentalRSC for App Router
- [ ] Mock aliases for CMS/API
- [ ] Font loading fallback

### Stories Created
| Tier | Component | Stories | Test |
|------|-----------|---------|------|
| 1    | Button    | 3       | pass |
| 1    | Card      | 2       | pass |
| 2    | Nav       | 4       | pass |
| ...  | ...       | ...     | ...  |

### Commands
- `pnpm storybook` — start dev server (port 6006)
- `npx vitest --project storybook --run` — run tests
```

### 7. Propose fixes

If you find issues during setup (missing dependencies, PostCSS conflicts, failing tests), propose the specific changes and **wait for confirmation** before applying them.

## Reference files

| File | Content |
|------|---------|
| `package.json` | Dependencies and scripts |
| `.storybook/main.ts` | Storybook configuration |
| `.storybook/preview.ts` | Preview with backgrounds and parameters |
| `.storybook/vitest.setup.ts` | Storybook test setup |
| `vitest.config.mts` | Vitest configuration with Storybook project |
| `postcss.config.storybook.mjs` | Dedicated PostCSS (if Tailwind 4) |
| `CREATIVE_DIRECTION.md` | Palette for backgrounds |
| Components directory | Story sources |
