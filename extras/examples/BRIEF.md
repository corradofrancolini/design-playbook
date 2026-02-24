# Your Project — Project Brief

**Last updated:** 2026-02-20

---

## Project

- **What**: Corporate website for a design studio — portfolio, team, services, contact
- **For whom**: The studio's founding partners
- **Goal**: Replace the current single-page site with a structured, content-managed website that showcases the studio's work and attracts new clients

---

## Target

- **Primary users**: Potential clients (real estate developers, private homeowners) browsing projects and looking for contact information
- **Secondary users**: Industry press, award juries, potential hires
- **Usage context**: Desktop-first (presentations, office research), but must work well on mobile (quick lookups, sharing links)

---

## Scope

### Included

- Homepage with featured projects
- Project archive with filtering by typology
- Individual project pages (photo gallery, description, technical data)
- Team page
- Contact page with form
- Basic SEO and performance optimization

### Excluded

- Blog (may be added later, but not in scope now)
- E-commerce or paid content
- Client portal / login area
- Multi-language (Italian only for now)

---

## Technical stack

- **Framework**: Next.js 15 (App Router)
- **CMS**: Payload CMS (self-hosted, same Next.js instance)
- **Hosting**: Vercel
- **Database**: PostgreSQL (Neon)
- **Other**: Resend for contact form emails, Cloudinary for image optimization

---

## Content

- **Languages**: Italian only
- **Page structure**: Home, Projects (archive + detail), Team, Contact
- **Existing content**: Full photo archive (high-res), project descriptions in a spreadsheet, team bios and portraits
- **Tone of voice**: Professional but warm, concise, no jargon

---

## References

| Type | Link / Note |
|------|-------------|
| Competitor | studiomilano.com — clean grid, good project navigation |
| Competitor | officekersten.com — strong photography, minimal UI |
| Moodboard | Figma file "Visual References" (shared with team) |
| Brand guidelines | Logo usage PDF from 2024 rebrand |

---

## Constraints

- **Budget**: Mid-range — no custom illustration or video production
- **Timeline**: MVP live by end of March, full site by end of April
- **Technical**: Must score 90+ on Lighthouse performance, WCAG 2.1 AA
- **Brand**: Logo wordmark and primary colors are fixed (from 2024 rebrand)

---

## Notes

The studio has a strong photo archive — the design should let photography lead. Avoid competing with the images through heavy UI or decorative elements.
