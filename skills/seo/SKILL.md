---
name: seo
description: Audit SEO e performance
---

# SEO & Performance

Agente specializzato in ottimizzazione per motori di ricerca e performance web.

## Quando invocare

- Prima di rilasciare una nuova pagina
- Per audit periodici
- Dopo modifiche significative
- Per verificare Core Web Vitals

## Azioni

### 1. Identifica scope

Chiedi all'utente:
- **Pagina specifica**: route/URL
- **Intero sito**: audit completo
- **Focus**: SEO, Performance, o entrambi

### 2. Esegui audit

#### SEO Audit

Verifica i criteri nella checklist sotto.

#### Performance Audit

```bash
# Lighthouse CLI (se disponibile)
npx lighthouse https://url --output json --output-path ./report.json

# Altrimenti verifica manuale dei criteri
```

### 3. Report

```
## SEO & Performance Audit

**URL**: [url o pagina]
**Data**: [data]

### SEO Score

| Categoria | Status | Note |
|-----------|--------|------|
| Meta Tags | — | — |
| Headings | — | — |
| Content | — | — |
| Technical | — | — |
| Structured Data | — | — |

### Performance Score

| Metrica | Valore | Target | Status |
|---------|--------|--------|--------|
| LCP | — | <2.5s | — |
| FID | — | <100ms | — |
| CLS | — | <0.1 | — |
| TTFB | — | <0.8s | — |

### Issues

#### [Alta] SEO — [titolo]
**Pagina**: [route]
**Problema**: [descrizione]
**Fix proposto**: [soluzione]
```

### 4. Proponi fix

Proponi le modifiche e **attendi conferma** prima di applicarle.

---

## Checklist SEO

### Meta Tags

- [ ] `<title>` presente, unico, 50-60 caratteri
- [ ] `<title>` include keyword primaria all'inizio
- [ ] `<meta name="description">` presente, 150-160 caratteri
- [ ] `<meta name="description">` include call to action
- [ ] `<meta name="robots">` appropriato (index/noindex)
- [ ] Canonical URL definito
- [ ] Open Graph tags presenti (og:title, og:description, og:image)
- [ ] Twitter Card tags presenti

### Headings

- [ ] Un solo `<h1>` per pagina
- [ ] H1 include keyword primaria
- [ ] Gerarchia heading corretta (H1 -> H2 -> H3, no salti)
- [ ] Headings descrittivi

### Content

- [ ] Contenuto unico (no duplicati)
- [ ] Keyword primaria nel primo paragrafo
- [ ] Keyword density naturale (1-2%)
- [ ] Contenuto sufficiente (>300 parole per pagine informative)
- [ ] Alt text per tutte le immagini informative
- [ ] Link interni rilevanti
- [ ] Link esterni autorevoli (se appropriato)

### Technical SEO

- [ ] URL puliti e descrittivi
- [ ] Sitemap.xml presente e aggiornata
- [ ] Robots.txt corretto
- [ ] HTTPS abilitato
- [ ] 301 redirect per URL cambiati
- [ ] No broken links (404)
- [ ] Hreflang per multilingua (se applicabile)

### Structured Data

- [ ] Schema.org Organization per homepage
- [ ] Schema.org BreadcrumbList per navigazione
- [ ] Schema.org Article per blog/contenuti
- [ ] Schema.org FAQPage per FAQ
- [ ] Schema.org Event per eventi
- [ ] JSON-LD format (preferito)
- [ ] Validato con Rich Results Test

### Mobile

- [ ] Viewport meta tag presente
- [ ] Design responsive
- [ ] Touch target adeguati (44x44px)
- [ ] Font size leggibile (16px min)
- [ ] No contenuto piu largo del viewport

---

## Checklist Performance

### Core Web Vitals

| Metrica | Descrizione | Target |
|---------|-------------|--------|
| **LCP** | Largest Contentful Paint | < 2.5s |
| **FID** | First Input Delay | < 100ms |
| **CLS** | Cumulative Layout Shift | < 0.1 |
| **TTFB** | Time to First Byte | < 0.8s |
| **FCP** | First Contentful Paint | < 1.8s |

### Immagini

- [ ] Formato moderno (WebP, AVIF)
- [ ] Dimensioni appropriate (no 4000px per thumbnail)
- [ ] Lazy loading per immagini below-the-fold
- [ ] Width/height o aspect-ratio definiti (previene CLS)

<!-- Adattare al framework usato (es. next/image, nuxt/image) -->

### JavaScript

- [ ] Bundle size ragionevole (<200KB gzipped ideale)
- [ ] Code splitting implementato
- [ ] No blocking scripts in `<head>`
- [ ] Tree shaking funzionante
- [ ] Dynamic imports per componenti pesanti

### CSS

- [ ] CSS critico inline (se necessario)
- [ ] No CSS inutilizzato
- [ ] CSS purging attivo (Tailwind, PurgeCSS, etc.)

### Caching

- [ ] Cache headers appropriati
- [ ] Cache lunga per static assets
- [ ] API responses cachate dove possibile

### Server

- [ ] Compression abilitata (gzip/brotli)
- [ ] CDN per static assets

<!-- Adattare al framework: Server Components (Next.js), Edge rendering, ISR -->

---

## Keyword Targets

<!-- Compilare con la strategia keyword del progetto -->

| Pagina | Keyword Primaria | Keyword Secondarie |
|--------|-----------------|-------------------|
