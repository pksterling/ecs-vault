---
id: employer-portal-tracking-options-comparison
aliases: []
tags:
  - #type/reference
  - #domain/reimburse
---
# Employer Portal Tracking: PostHog vs Hotjar vs Admin Events

## What's already in the codebase

Before comparing, it helps to know the starting point:

**PostHog** — `posthog-js ^1.382.0` is in `package.json`. It's fully set up on
the employee portal (`EmployeeApp.tsx` wraps with `PostHogProvider`,
`EmployeeEnvContext` has `posthogApiKey`/`posthogHost`). The employer portal has
**none of this** — `EmployerApp.tsx` has no `PostHogProvider`, and
`EmployerEnvContext` has no PostHog fields. It's a new vendor that's already a
vendor.

**Hotjar** — already installed on the employer portal. The `_hotjar.html.erb`
partial is rendered in `employer.html.erb` with `HOTJAR_EMPLOYER_PORTAL_ID`. A
`useHotjarIdentify` hook exists in `shared/hooks/`, but it's only wired into the
employee portal, not the employer portal. So Hotjar loads, but users are
anonymous.

**Admin events** — the event system (`make_from_employer_admin_user_action`)
already captures meaningful business operations for employer admins. The
reimburse scheme already has `TripCreated`, `MileageClaimCreated`,
`ReimburseInstructionsCreated` events. The audit trail is alive and healthy.

---

## The Three Camps

### Camp 1: PostHog

**What it does:** Product analytics — pageviews, user journeys, funnels,
cohorts, feature flags, session replay. Designed to answer "what are users doing
across the product?"

**Cost:**
- Free tier: 1M events/month, 5K session recordings — generous and likely covers
  employer portal volume for a long time
- After that: usage-based, ~$0.00005/event and $0.005/recording. Hard billing
  caps per product so no surprise bills
- No per-seat cost — unlimited team members on all plans

**Strengths:**
- Automatic SPA pageview tracking once `PostHogProvider` is added — every route
  change fires a `$pageview` with `$pathname`, `$current_url`, and user identity
- `posthog.identify(employerAdminId, { employer_name, schemes: ['reimburse'],
  ... })` ties every event to a specific employer admin and their employer
  attributes
- Cohort builder: "show me all employer admins who visited
  `/employers/dashboard/business_mileage_reimbursements` in the last 30 days but
  are not yet on the reimburse scheme" — this is exactly the warm leads list for
  reimburse
- Funnels, Paths, Trends out of the box — no SQL needed for common questions
- Session replay included (same tool, no extra vendor)
- Already a vendor — no procurement overhead

**Weaknesses:**
- Not yet wired into the employer portal — requires setup work
- Less good at qualitative UX questions ("why are users confused on this page?")
  vs Hotjar
- Data lives with PostHog (SaaS) — worth noting for GDPR, though EU hosting is
  available (`api_host: 'https://eu.i.posthog.com'`)

**Implementation effort — low:**
1. Add `posthogApiKey` and `posthogHost` to `EmployerEnvContext.ts` (copy
pattern from `EmployeeEnvContext.ts`)
2. Wrap `EmployerApp.tsx` with `PostHogProvider` (copy from `EmployeeApp.tsx`,
~10 lines)
3. Call `posthog.identify(employer.id, { employer_name, schemes, has_reimburse:
true/false, ... })` in `EmployerContext.tsx` when `isAuth` becomes true
4. Add `posthog.capture('file downloaded', { file_name })` at download points
5. Wire up env vars in Rails config

Roughly a day's work. The hard decisions (vendor, package, pattern) are already
made.

---

### Camp 2: Hotjar (now Contentsquare)

**What it is now:** Hotjar was acquired by Contentsquare. The two products have
merged into a single "experience intelligence platform." The Hotjar brand still
exists under the Contentsquare umbrella but the pricing page redirects to
Contentsquare.

**Cost:**
- Free plan still exists: 200K sessions/month, heatmaps, session replay, 100
  survey responses
- Paid tiers require contacting sales — no public pricing since the
  Contentsquare merger
- The acquisition means the product's direction and pricing are less predictable
  going forward

**What it actually does:**
- Session recordings — watch exactly what individual users did, including
  clicks, rage clicks, scroll depth
- Heatmaps — aggregate click/scroll/move patterns across all sessions on a page
- Surveys and feedback widgets
- Since Contentsquare: also funnels, error monitoring, performance monitoring,
  AI-powered insights (Sense AI)
- Has a custom Events API: `hj('event', 'download_clicked')` — but events are
  primarily for *filtering recordings* and *triggering surveys*, not analytics
  reporting

**What it can't do well:**
- Answer "how many employers visited page X this week" — you get session counts,
  not page-level analytics
- Build a query like "employer admins who visited the mileage page but haven't
  converted to reimburse" — no cohort builder against your own data
- Identify specific employer admins systematically — you can call
  `hj('identify', userId)` to tag recordings, but can't then query "show me all
  sessions by employers on the charge scheme"
- Track downloads as analytics data — events trigger survey popups or segment
  recordings, they don't feed a reporting dashboard

**Strengths — and this is real:**
- Already installed and loading on the employer portal right now. Zero
  additional setup to see heatmaps and session recordings
- To get user identity, just wire `useHotjarIdentify` into `EmployerContext`
  (the hook already exists, 5-line change)
- Exceptional for qualitative UX questions: "why do employers drop off on the
  direct debit page?" — watch 10 recordings and you'll know
- Complementary to analytics, not a replacement

**Implementation effort — very low for basic, impossible for the analytics use
case:**
- To get identified sessions: add `useHotjarIdentify({ id: employer?.id })` to
  `EmployerContext` — half a day
- To answer "which employers visited reimburse pages": not achievable with
  Hotjar

---

### Camp 3: Admin Events

**What it is:** The existing event system — `EventServiceV2` classes that create
records in `events_partitioned` with `initiator_role: :employer_admin_user`.
Business operations already create these events (trip creation, mileage claim
submission, etc.).

**Cost:** Zero. It's our own infrastructure.

**What it already captures that's relevant:**
- `Events::ReimburseScheme::TripCreated` — which employer admins have employees
  submitting trips
- `Events::ReimburseScheme::MileageClaimCreated` — which employer admins have
  claims being submitted
- Every significant employer portal action that's been explicitly instrumented

**The argument for using admin events for tracking:** Already in the
infrastructure, queryable via BigQuery (`electric-car-scheme-production`), joins
naturally with all other ECS data, no external vendor, your own data.

**Why admin events are the wrong tool for page/navigation tracking:** The event
system is an **audit log for business operations**. The `before` block validates
preconditions; `apply!` makes a database write; handlers trigger side effects. A
pageview equivalent has none of these — there's no precondition to validate, no
state to change, no handler to fire. You'd be creating hollow event definitions
purely to log navigation, which pollutes the audit trail and makes it harder to
reason about what the events table represents.

Also: there's no analytics UI on top of the events table. You'd be writing
BigQuery SQL for every question.

**Implementation effort — high, for the wrong purpose.**

---

## The Comparison

| | PostHog | Hotjar/Contentsquare | Admin Events | |---|---|---|---| | **Page
visit tracking** | Automatic on SPA navigation | Session recordings only — watch
but not query | Wrong tool — possible but architectural misuse | | **Download
tracking** | `posthog.capture()` → analytics data | Events trigger survey
popups, not analytics | Reasonable if download is a meaningful business action |
| **User identification** | `posthog.identify()` with employer properties |
`hj('identify', userId)` for session filtering | Native — events carry
`initiator_user_id` | | **"Who visited reimburse pages"** | Yes — cohort
builder, exact employer IDs, exportable | No — watch recordings manually | Only
if you explicitly instrument every page visit | | **Heatmaps** | No | Yes — its
  core strength | No | | **Session recordings** | Yes (5K/month free) | Yes —
  its core strength | No | | **Funnels / journeys** | Yes — built in | Yes
  (since Contentsquare merger) | No — build it yourself in SQL | | **Cost** |
  Free to ~1M events/month | Free to 200K sessions/month (pricing murky
  post-acquisition) | Zero | | **Vendor risk** | Stable, VC-backed, growing |
  Acquired by Contentsquare — direction unclear | None | | **Already installed**
  | In package.json, on employee portal | On employer portal right now | In the
  codebase | | **Setup effort** | ~1 day | ~half a day for identification |
  High, and shouldn't be done | | **GDPR** | EU hosting available | EU hosting
  available | Your own data |

---

## Easiest Route

Wire up Hotjar identification. It's already loading — just add
`useHotjarIdentify({ id: employer?.id })` to `EmployerContext.tsx` and you get
identified session recordings. Half a day. Immediately useful for watching
sessions. Won't answer aggregate questions, but fast qualitative insight.

---

## Most Featureful Route

PostHog on the employer portal, with Hotjar still running alongside.

These tools answer different questions. PostHog answers "what is happening and
to whom" (quantitative). Hotjar answers "why is it happening" (qualitative).
PostHog tells you a page has a high drop-off rate; Hotjar recordings show you
why.

---

## The Reimburse Sales Question

This is where PostHog has a clear answer and the other options don't.

From `Dashboard.tsx`, there are two types of warm leads for reimburse:

1. **Charge scheme employers with
`businessMileageReimbursementStrategyEnabled`** — rendering
`/employers/dashboard/business_mileage_reimbursements`. Already doing mileage
reimbursement within charge scheme. Warmest possible leads.
2. **Employers visiting `/employers/dashboard/mileage`** — in the mileage
section, thinking about it.
3. **Charge-scheme-only employers with regular logins but no reimburse** — might
not know it exists.

With PostHog, after calling: ```js posthog.identify(employerAdminId, {
  employer_id, employer_name, schemes: ['charge'], has_mileage_strategy:
  true/false, has_reimburse: false, }) ``` You can build a cohort in PostHog's
  UI: "employer admins who visited
  `/employers/dashboard/business_mileage_reimbursements` in the last 60 days,
  where `has_reimburse` is false." Export as a list. Hand to sales.

With Hotjar: manually watching session recordings and noting which ones visited
the mileage section — not scalable.

With admin events: only see employers who have already taken a reimburse
business action (already on reimburse). No signal on prospective ones.

---

## Recommendation

**Do both PostHog and Hotjar, in that order of priority.**

1. **PostHog first** — analytics and the reimburse leads use case require it.
Low setup effort given the employee portal pattern is already there. Stay on the
free tier (1M events/month is ample for employer admin volume).
2. **Wire up Hotjar identification** — already installed, half a day,
immediately useful for watching sessions.
3. **Leave admin events as-is** — doing their job well as a business audit
trail. If specific meaningful employer actions are worth recording (e.g.
"employer downloaded year-end documents" as a business event that might trigger
follow-up), add them as admin events — not as page tracking.

---

## Related
- [[tcs-167-posthog-identity-tracking]]
- [[posthog-consent-gdpr-notes]]
- [[tcs-178-ph-session-replays]]
