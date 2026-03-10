# Your Project — Tech Stack

**Last updated:** 2025-01-15

---

## Stack

- **Framework**: Next.js 15 (App Router)
- **Styling**: Tailwind CSS 4
- **CMS**: Payload CMS 3 (self-hosted, same Next.js instance)
- **Database**: PostgreSQL (Neon)
- **Hosting**: Vercel
- **Package manager**: pnpm
- **Other**: Resend for contact form emails, Cloudinary for image optimization

---

## Architecture decisions

| Decision | Choice | Why | Alternatives considered |
|----------|--------|-----|------------------------|
| Rendering strategy | App Router with RSC | Content-heavy site benefits from server rendering, simpler data fetching | Pages Router, Astro |
| CMS | Payload CMS 3 | Self-hosted in same Next.js instance, no external service costs | Sanity, Strapi |
| Database hosting | Neon | Serverless PostgreSQL, scales to zero, Vercel integration | Supabase, PlanetScale |
| Email | Resend | Simple API, good deliverability, generous free tier | SendGrid, Postmark |

---

## Key dependencies

| Package | Role | Notes |
|---------|------|-------|
| @payloadcms/richtext-lexical | Rich text editor | Payload's default editor |
| cloudinary | Image optimization | Used via URL transforms, not SDK uploads |
| resend | Transactional email | Contact form only |

---

## Integration constraints

- Payload CMS admin panel runs on the same Next.js instance (`/admin` route)
- Cloudinary transforms are applied via URL parameters, no server-side SDK needed
- Resend API key required in production (`.env.production`)

---

## Patterns

- Server Components by default, `use client` only for interactivity (forms, animations)
- Co-locate data fetching in server components using Payload Local API
- All Payload collections use TypeScript-generated types (`payload-types.ts`)
- Images served via Cloudinary URL transforms for responsive sizes

---

## Notes

Italian-only site for now. i18n may be added later — keep text in CMS, not hardcoded.
