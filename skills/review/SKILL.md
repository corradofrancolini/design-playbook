---
name: review
description: Code review qualita, pattern e best practice
---

# Code Review

Agente specializzato in revisione codice.

## Contesto

Lo stack tecnologico del progetto va definito nella prima sessione operativa. Questa skill si adatta allo stack scelto.

## Quando invocare

- Prima di committare modifiche significative
- Dopo aver scritto un nuovo componente o modulo
- Per verificare pattern e best practice
- Per identificare problemi di performance/sicurezza

## Azioni

### 1. Identifica scope

Chiedi all'utente:
- **File specifici**: path o glob pattern
- **Ultimo commit**: review delle modifiche recenti
- **Area**: componenti, API, styling, etc.

### 2. Esegui review

Leggi i file e verifica le categorie sotto.

### 3. Report

```
## Code Review

**Scope**: [file/area]
**Data**: [data]

### Summary

| Categoria | Issues |
|-----------|--------|
| Correttezza | 0 |
| Performance | 0 |
| Sicurezza | 0 |
| Manutenibilita | 0 |
| Accessibilita | 0 |

### Issues

#### [Alta] Correttezza — [titolo]
**File**: `path/to/file:linea`
**Problema**: [descrizione]
**Fix proposto**: [codice]

### Suggerimenti (non bloccanti)
- ...
```

### 4. Proponi fix

Per ogni issue, proponi la modifica e **attendi conferma** prima di applicarla.

---

## Checklist Review

### Correttezza

- [ ] Logica corretta, edge case gestiti
- [ ] Error handling presente e appropriato
- [ ] Types corretti, no `any` non necessari
- [ ] Null/undefined checks dove necessario
- [ ] Async/await usato correttamente

### Performance

- [ ] No re-render non necessari (inline objects, inline functions)
- [ ] Memo/useMemo/useCallback dove appropriato
- [ ] No blocking operations nel render path
- [ ] Immagini ottimizzate
- [ ] Bundle size considerato (specific imports vs barrel)

### Sicurezza

- [ ] No secrets hardcoded
- [ ] Input validation presente
- [ ] SQL injection prevenuta (parameterized queries)
- [ ] XSS prevenuto (escaped output, no dangerouslySetInnerHTML)
- [ ] CSRF considerato per mutations
- [ ] Auth checks su route protette

### Manutenibilita

- [ ] Naming chiaro e consistente
- [ ] Funzioni/componenti non troppo lunghi (<100 righe ideale)
- [ ] Single responsibility principle
- [ ] DRY senza over-engineering
- [ ] Comments solo dove necessari (self-documenting code)
- [ ] No magic numbers/strings (usare costanti)

### Accessibilita

- [ ] Semantic HTML
- [ ] ARIA attributes corretti
- [ ] Keyboard navigation funzionante
- [ ] Focus management appropriato
- [ ] Alt text per immagini

<!-- Sezioni stack-specifiche: decommentare quelle rilevanti per il progetto. -->

<!--
### React / Next.js

- [ ] Server vs Client Components scelti appropriatamente
- [ ] `'use client'` solo dove necessario
- [ ] Metadata esportata per SEO
- [ ] Loading/error states gestiti
- [ ] Suspense boundaries dove appropriato
-->

<!--
### Vue / Nuxt

- [ ] Composition API usata consistentemente
- [ ] Uso corretto di computed vs methods
- [ ] Stato reattivo gestito correttamente
- [ ] SEO meta gestito via useHead/useSeoMeta
- [ ] Lazy loading per route e componenti
-->

<!--
### Tailwind

- [ ] Classi ordinate (layout > spacing > typography > colors > effects)
- [ ] Design tokens usati al posto di valori arbitrari
- [ ] Classi responsive consistenti
- [ ] Dark mode considerato (se applicabile)
-->

<!--
### TypeScript

- [ ] Types espliciti per props e return values
- [ ] No `as` cast non necessari
- [ ] Discriminated unions per stati
- [ ] Generics usati appropriatamente
-->

<!--
### Python

- [ ] Type hints presenti
- [ ] Docstrings per funzioni pubbliche
- [ ] No bare `except` clauses
- [ ] Context managers per risorse
- [ ] Async/sync boundaries chiare
-->
