---
id: employer-tracking-consent-tiers
aliases: []
tags:
  - #cycle/june
  - #gdpr
parent: "[[employer-tracking-gdpr]]"
---
# employer tracking - consent tiers (pm summary)

## the rule
- 2 triggers for consent: **storing anything on device** + **collecting anything that IDs a person**
- avoid both = no consent. cross either = consent
- "anonymous" judged incl. OUR ability to re-link via auth session, not just posthog's

## no consent (anonymous, aggregate)
- which pages/features used (aggregate)
- **flow within ONE visit** - A→B→drop at C, funnels, drop-off point
  + ephemeral in-memory session id, dies on reload, linked to no one
  + breaks on full reload (e.g. company switch)
- form error / validation rates (by form name, not fields)
- slow pages, perf, js error rates
- device/browser mix (bucketed)
- NO identity, NO cross-visit, NO single company

## with consent
- do users return / retention over time
- follow one person across visits
- which **specific company** uses what
- session replay
- tie usage to named admin for support

## why cross-visit + per-company need consent
- needs persistent id = device storage (PECR) + re-identifiable (GDPR)
- per-company: employers avg ~4 admins (8k admins / 2k employers)
  + "company X viewed orders" = singled out the person
  + employer_id joins to auth session = personal data
- no company "big enough" - need k≈20-30, we don't have it
- fix = don't attach company/user identity at all, NOT company size

## session replay
- = recording of real session (screen, clicks, inputs, network)
- **always consent-tier, cannot be anonymised**
  + records names, employees, car regs, salaries, bank details
  + separate pipeline - our anonymising filter does NOT cover it
  + needs persistent id (storage)
- if used: explicit + specific opt-in, **mask all inputs/sensitive text**, privacy notice, DPO
- best tool for "why are users stuck" - but later, gated

## reimburse targeting
- using analytics to find/contact people for reimburse = **NO**, either tier
- different purpose (marketing) = needs its own consent
- email outreach = direct marketing = stricter rules (soft opt-in maybe, DPO call)
- anon tier can't (no identity); analytics consent ≠ marketing consent
- pseudonymise → re-identify → contact does NOT launder it
- do instead: separate consented outreach flow (onboarding ask / DPO soft opt-in)
- one-liner: analytics = how product is used, NOT a marketing list

## how consent must be presented
- opt-in BEFORE any tracking/storage starts
- clear + specific, no pre-ticked boxes, refuse as easy as accept
- withdrawable, logged (who + when)
- **purpose-bound** - analytics ≠ replay ≠ reimburse marketing (each separate)
- expect many to decline → identified data = partial sample, not everyone

## recommendation
- ship anon tier first - most product Qs, no banner, no friction
- add consent-gated identity later only if specific need (retention / per-company / replay / support)
- reimburse outreach = separate project, separate consent

---

## Related
- [[posthog-consent-gdpr-notes]]
- [[more-gdpr-notes]]
