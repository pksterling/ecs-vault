---
id: quote-retrieval-claude-plan
aliases: []
tags: []
---
# quote-retrieval-claude-plan

## Context

Employees can't see or resume their Net Zero Home quotes — every visit starts fresh.
Goal: a portal section listing in-progress + completed quotes, resume where you left off, and
a read-only view of a finished quote.

**Built for the new Lead-based flow** (not the current two quote tools) — retrieval operates
over **Leads** and the comparison output derived from them.

## Priority (per Lucas/Peyton)

1. **Finish in-progress quotes** (resume) — highest
2. **View quotes + the "my quotes" page** — next

## Decisions

- **In-progress quotes never expire** — a Lead stays resumable indefinitely. No expiry/abandoned
  work needed (drops the old priority-3 item).

## What already exists to reuse

- The old solar/heat-pump quote tools already implement the exact *pattern* we need — a proven
  template to port onto the Lead model:
  - Employee-scoped `index` + `show` controllers (`current_employee.solar_quotes.find(...)`)
    and paginated QuotesViewModels.
  - List hooks: `useGetSolarQuotes()` (`api_solar.ts`), `useGetHeatPumpQuotes()`
    (`api_heat_pump.ts`).
  - ViewModels render *persisted* pricing read-only (solar `latest_cash_quote` /
    `latest_finance_quote`; heat pump `estimate` JSONB) — so a finished quote re-shows as it was.
  - `Show.tsx` auto-navigates to the first incomplete step when opened with no `?step=`.

## Depends on (not built yet)

- **Lead model + multi-product question flow** — Product Selection & Qualification Flow
  ([[product-selection-qualification-claude-plan]]): Lead creation (NZB-103), question flow
  (NZB-104).
- **Comparison page** for the completed-quote view — Leighton's "Final Quote & Multi-Installer
  Comparison Page" project.

## Proposed setup

- **In-progress** = a Lead whose flow isn't finished → resume into
  `/employees/net-zero-home/lead/:id`; the shared step controller lands at the correct step
  (product selection / question flow / comparison) with answers intact.
- **Completed** = a Lead that reached the comparison page → read-only re-render of the
  comparison output.
- **My quotes list** = the employee's Leads, grouped in-progress vs completed. Dashboard
  (`pages/Dashboard.tsx`) gets an NZH section linking in.
- **Admin real-time (AC4)** — resume PATCHes the same Lead, so admin reflects progress for
  free; if an `abandoned` status is added, resume must un-abandon it (cf. solar "Lost deals"
  NZB-76 "unlose" pattern).

Data/services:
- `Lead` scoped to `current_employee` (like `solar_quotes`); port the index/show + ViewModel
  pattern onto Leads.
- Status/stage split for the in-progress vs completed grouping.

## Open questions (product decisions, from Linear)

- ~~Expiry~~ — decided: never expires (see Decisions).
- On resume, re-run qualification/pricing or show what they originally saw? (stale-supplier risk)
- Access: logged-in only, or unique link (e.g. from email)?
- Completed quotes: read-only, or "get an updated quote" re-runnable?
