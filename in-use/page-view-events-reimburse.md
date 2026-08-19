---
id: page-view-events-reimburse
aliases: []
tags:
  - #type/draft-issue
  - #domain/reimburse
parent: "[[track-employer-portal-usage]]"
---
# page-view-events-reimburse

## PR Comments
## PR #7458: Employer Portal Interactions

**[2026-07-08 13:01:34] stefanjcollier** — `app/javascript/employer/hooks/useEmployerPortalInteractionTracking.ts:1`

Neat trick, I was wondering how we would do that!

---

**[2026-07-08 13:02:03] stefanjcollier** — `app/javascript/employer/hooks/useEmployerPortalInteractionTracking.ts:7`

Does this remove the URL params?
I think we should, otherwise it'll get noisy

---

**[2026-07-08 15:12:15] stefanjcollier** — `app/javascript/employer/employerPortalInteractions.ts:6`

```suggestion
export const EMPLOYER_PORTAL_INTERACTIONS: Record<Camelize<Interaction>, Interaction> = {
```

---

**[2026-07-08 15:55:52] stefanjcollier** — `app/javascript/employer/dashboard/components/Footer.tsx:75`

👋 noob here

Are we confident this does not remove the link behaviour? 
I don't know enough html to be certain.

---

**[2026-07-08 15:57:50] stefanjcollier** — `app/javascript/employer/api.ts:61`

The `.catch` looks to hide a failure but also drop the error. 
Can we alert appsignal and continue to hide the error from the user?

---

**[2026-07-08 16:06:45] stefanjcollier** — `app/javascript/employer/credit_applications/steps/FunderPrimaryContactForm.tsx:214`

There's a good few `<a` link to download. 
Would some sort of component for this make it better or worse .e.g. `TrackedDownloadLink`

## Running notes
- Manually testing contracts, CSV, and trips
---
- In order to audit the use of the employer portal, and ensure the frontend is
  receiving the correct data, we will be adding a page visit event to our events
  types
- From the employer portal top-level react file, send a request to the api,
  logging an event with the following params:
  + url
  + action (download file, visit page, etc)
  + person: id, name, email
  + employer: id, name, active schemes (ecs, tcs, reimburse, etc)
- Events are then queryable from the events page
- Further: send these events to the reporting DB in a human-readable format

## Plan
- Create page visit event
- Call from controller action
- Hit controller action from top-level employer portal react file
