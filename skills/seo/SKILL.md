---
name: seo
description: SEO and performance audit
---

# SEO & Performance

Agent specialized in search engine optimization and web performance.

## When to invoke

- Before releasing a new page
- For periodic audits
- After significant changes
- To check Core Web Vitals

## Actions

### 1. Identify scope

Ask the user:
- **Specific page**: route/URL
- **Entire site**: full audit
- **Focus**: SEO, Performance, or both

### 2. Run audit

#### SEO Audit

Check the criteria in the checklist below.

#### Performance Audit

```bash
# Lighthouse CLI (if available)
npx lighthouse https://url --output json --output-path ./report.json

# Otherwise manual check of criteria
```

### 3. Report

```
## SEO & Performance Audit

**URL**: [url or page]
**Date**: [date]

### SEO Score

| Category | Status | Notes |
|----------|--------|-------|
| Meta Tags | — | — |
| Headings | — | — |
| Content | — | — |
| Technical | — | — |
| Structured Data | — | — |

### Performance Score

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| LCP | — | <2.5s | — |
| FID | — | <100ms | — |
| CLS | — | <0.1 | — |
| TTFB | — | <0.8s | — |

### Issues

#### [High] SEO — [title]
**Page**: [route]
**Problem**: [description]
**Proposed fix**: [solution]
```

### 4. Propose fixes

Propose the changes and **wait for confirmation** before applying them.

---

## SEO Checklist

### Meta Tags

- [ ] `<title>` present, unique, 50-60 characters
- [ ] `<title>` includes primary keyword at the beginning
- [ ] `<meta name="description">` present, 150-160 characters
- [ ] `<meta name="description">` includes call to action
- [ ] `<meta name="robots">` appropriate (index/noindex)
- [ ] Canonical URL defined
- [ ] Open Graph tags present (og:title, og:description, og:image)
- [ ] Twitter Card tags present

### Headings

- [ ] One `<h1>` per page
- [ ] H1 includes primary keyword
- [ ] Correct heading hierarchy (H1 -> H2 -> H3, no skips)
- [ ] Descriptive headings

### Content

- [ ] Unique content (no duplicates)
- [ ] Primary keyword in first paragraph
- [ ] Natural keyword density (1-2%)
- [ ] Sufficient content (>300 words for informational pages)
- [ ] Alt text for all informational images
- [ ] Relevant internal links
- [ ] Authoritative external links (if appropriate)

### Technical SEO

- [ ] Clean and descriptive URLs
- [ ] Sitemap.xml present and up to date
- [ ] Robots.txt correct
- [ ] HTTPS enabled
- [ ] 301 redirects for changed URLs
- [ ] No broken links (404)
- [ ] Hreflang for multilingual (if applicable)

### Structured Data

- [ ] Schema.org Organization for homepage
- [ ] Schema.org BreadcrumbList for navigation
- [ ] Schema.org Article for blog/content
- [ ] Schema.org FAQPage for FAQ
- [ ] Schema.org Event for events
- [ ] JSON-LD format (preferred)
- [ ] Validated with Rich Results Test

### Mobile

- [ ] Viewport meta tag present
- [ ] Responsive design
- [ ] Adequate touch targets (44x44px)
- [ ] Readable font size (16px min)
- [ ] No content wider than viewport

---

## Performance Checklist

### Core Web Vitals

| Metric | Description | Target |
|--------|-------------|--------|
| **LCP** | Largest Contentful Paint | < 2.5s |
| **FID** | First Input Delay | < 100ms |
| **CLS** | Cumulative Layout Shift | < 0.1 |
| **TTFB** | Time to First Byte | < 0.8s |
| **FCP** | First Contentful Paint | < 1.8s |

### Images

- [ ] Modern format (WebP, AVIF)
- [ ] Appropriate dimensions (no 4000px for thumbnail)
- [ ] Lazy loading for below-the-fold images
- [ ] Width/height or aspect-ratio defined (prevents CLS)

<!-- Adapt to the framework used (e.g. next/image, nuxt/image) -->

### JavaScript

- [ ] Reasonable bundle size (<200KB gzipped ideal)
- [ ] Code splitting implemented
- [ ] No blocking scripts in `<head>`
- [ ] Tree shaking working
- [ ] Dynamic imports for heavy components

### CSS

- [ ] Critical CSS inline (if needed)
- [ ] No unused CSS
- [ ] CSS purging active (Tailwind, PurgeCSS, etc.)

### Caching

- [ ] Appropriate cache headers
- [ ] Long cache for static assets
- [ ] API responses cached where possible

### Server

- [ ] Compression enabled (gzip/brotli)
- [ ] CDN for static assets

<!-- Adapt to the framework: Server Components (Next.js), Edge rendering, ISR -->

---

## Keyword Targets

<!-- Fill in with the project's keyword strategy -->

| Page | Primary Keyword | Secondary Keywords |
|------|-----------------|-------------------|
