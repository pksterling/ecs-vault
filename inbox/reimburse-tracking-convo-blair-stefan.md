---
id: reimburse-tracking-convo-blair-stefan
aliases: []
tags:
  - #planning
  - #cycle/june
---
# reimburse-tracking-convo-blair-stefan

- Two questions:
  + Reimburse users: how are they using the app? Are they using it correctly?
  + Which employer admin users are using reimburse-adjacent stuff?

## Reimburse users
- This will likely require Posthog
- Aggragate-level data won't require consent if we're careful
- For things like session replays and cross-session user flows, we need consent
- This is a larger task, and we don't currently have reimburse users - pushing
  this out of scope

## Reimburse-adjacent tracking
- #person/alex-blair
  + We have everything we need server-side to do this - why would we use Posthog
    to achieve this?
- #person/stefan
  + In order to audit the use of the employer portal, and ensure the frontend is
    receiving the correct data, we will be adding a page visit event to our events
    types
  + From the employer portal top-level react file, send a request to the api,
    logging an event with the following params:
    * url
    * action (download file, visit page, etc)
    * person: id, name, email
    * employer: id, name, active schemes (ecs, tcs, reimburse, etc)
  + Events are then queryable from the events page
  + Further: send these events to the reporting DB in a human-readable format

---

## Related
- [[page-view-events-reimburse]]
- [[posthog-consent-gdpr-notes]]
