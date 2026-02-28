---
name: storybook
description: Scaffold Storybook component library con test e integrazione design system
---

# Storybook

Agente specializzato nello scaffold e configurazione di Storybook per progetti del playbook.

## Contesto

Storybook è la component library visiva del progetto. Questa skill configura Storybook adattandosi allo stack rilevato, applica i workaround noti (Tailwind 4, App Router, ESM) e crea le prime stories seguendo un approccio a tier.

## Quando invocare

- All'inizio di un progetto, dopo aver definito stack e design system
- Quando si aggiunge Storybook a un progetto esistente
- Per aggiungere stories a componenti non coperti
- Per configurare test visivi con Vitest

## Azioni

### 1. Rileva stack

Leggi `package.json` e identifica:

- **Framework**: Next.js (App Router / Pages), Vite, Remix, altro
- **CSS**: Tailwind 3, Tailwind 4, CSS Modules, vanilla CSS
- **TypeScript**: sì / no
- **Monorepo**: sì / no — dove vivono i componenti

Riporta lo stack rilevato prima di procedere. **Attendi conferma**.

### 2. Installa dipendenze

```bash
npx storybook@latest init
```

Aggiungi addon:
- `@storybook/addon-vitest` — test integrati
- `@storybook/addon-a11y` — audit accessibilità inline
- `@storybook/addon-docs` — documentazione automatica

#### Workaround noti

**Tailwind 4 + Vite/Next.js Vite**: Tailwind 4 usa `@import "tailwindcss"` che richiede il plugin PostCSS ufficiale. Storybook con Vite può confliggere. Soluzione:

- Creare `postcss.config.storybook.mjs` separato con solo `@tailwindcss/postcss`
- In `.storybook/main.ts`, nella funzione `viteFinal`, puntare a questo file:
  ```ts
  viteFinal: async (config) => {
    config.css = { ...config.css, postcss: './postcss.config.storybook.mjs' }
    return config
  }
  ```

**Next.js App Router**: Usare `@storybook/nextjs-vite` come framework e abilitare `experimentalRSC: true` nelle features.

**ESM e `__dirname`**: Se il progetto usa ESM (`"type": "module"` in `package.json`), usare `import.meta.url` + `fileURLToPath` invece di `__dirname`.

**Font loading (Next.js `next/font`)**: Next.js font non funzionano in Storybook. Caricare i font via CSS `@font-face` in un file separato o usare il fallback del sistema.

**CMS/API dependencies**: Componenti che dipendono da Payload, Sanity, o altre API vanno mockati. Creare alias in `viteFinal` per i moduli problematici:
  ```ts
  config.resolve = {
    ...config.resolve,
    alias: {
      ...(config.resolve?.alias || {}),
      '@payloadcms/richtext-lexical/react': path.resolve(__dirname, '../src/__mocks__/PayloadRichText.tsx'),
    },
  }
  ```

### 3. Configura

#### `.storybook/main.ts`

```ts
import type { StorybookConfig } from '@storybook/nextjs-vite' // adatta al framework

const config: StorybookConfig = {
  stories: ['../src/components/**/*.stories.@(ts|tsx)'],
  addons: [
    '@storybook/addon-vitest',
    '@storybook/addon-a11y',
    '@storybook/addon-docs',
  ],
  framework: {
    name: '@storybook/nextjs-vite', // adatta al framework
    options: {},
  },
  features: {
    experimentalRSC: true, // solo Next.js App Router
  },
  viteFinal: async (config) => {
    // PostCSS workaround per Tailwind 4
    // Alias per mock CMS/API
    return config
  },
}
```

#### `.storybook/preview.ts`

Leggi `CREATIVE_DIRECTION.md` per estrarre la palette e configura i backgrounds:

```ts
const preview: Preview = {
  parameters: {
    backgrounds: {
      default: 'primary-bg',
      values: [
        // Usa colori da CREATIVE_DIRECTION.md
      ],
    },
    layout: 'fullscreen',
    a11y: { test: 'todo' },
  },
}
```

#### `.storybook/vitest.setup.ts`

File di setup dedicato per il progetto Storybook di Vitest (separato dal setup root per evitare crash con dotenv in browser context):

```ts
import { beforeAll } from 'vitest'
import { setProjectAnnotations } from 'storybook'
import * as previewAnnotations from './preview'

beforeAll(() => {
  setProjectAnnotations([previewAnnotations])
})
```

### 4. Crea prime stories

Segui un approccio a **3 tier**, in ordine di complessità:

#### Tier 1 — Componenti puri (nessuna dipendenza esterna)
- Bottoni, input, card, badge, dialog
- Priorità massima: sono testabili subito

#### Tier 2 — Componenti con routing/layout
- Nav, footer, sidebar
- Richiedono mock di `usePathname`, `useRouter` via parametri `nextjs.navigation`

#### Tier 3 — Componenti CMS-dependent
- Rich text, blocchi contenuto, form con API
- Richiedono mock espliciti (alias in `viteFinal` o `__mocks__/`)

**Template story**:

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
    // props di default
  },
}
```

Per ogni componente, crea almeno: `Default`, varianti principali, e stati edge (empty, loading, error dove applicabile).

### 5. Configura test

Aggiungi il progetto Storybook a `vitest.config.mts`:

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

Verifica che i test passino:

```bash
npx vitest --project storybook --run
```

### 6. Report

```
## Storybook Setup

### Stack rilevato
- Framework: [Next.js App Router / Vite / ...]
- CSS: [Tailwind 4 / Tailwind 3 / CSS Modules / ...]
- TypeScript: [sì / no]

### Workaround applicati
- [ ] PostCSS separato per Tailwind 4
- [ ] experimentalRSC per App Router
- [ ] Alias mock per CMS/API
- [ ] Font loading fallback

### Stories create
| Tier | Componente | Stories | Test |
|------|-----------|---------|------|
| 1    | Button    | 3       | pass |
| 1    | Card      | 2       | pass |
| 2    | Nav       | 4       | pass |
| ...  | ...       | ...     | ...  |

### Comandi
- `pnpm storybook` — avvia dev server (porta 6006)
- `npx vitest --project storybook --run` — esegui test
```

### 7. Proponi fix

Se trovi problemi durante il setup (dipendenze mancanti, conflitti PostCSS, test che falliscono), proponi le modifiche specifiche e **attendi conferma** prima di applicarle.

## File di riferimento

| File | Contenuto |
|------|-----------|
| `package.json` | Dipendenze e script |
| `.storybook/main.ts` | Configurazione Storybook |
| `.storybook/preview.ts` | Preview con backgrounds e parametri |
| `.storybook/vitest.setup.ts` | Setup test Storybook |
| `vitest.config.mts` | Configurazione Vitest con progetto Storybook |
| `postcss.config.storybook.mjs` | PostCSS dedicato (se Tailwind 4) |
| `CREATIVE_DIRECTION.md` | Palette per backgrounds |
| Directory componenti | Sorgente delle stories |
