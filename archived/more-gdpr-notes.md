---
id: more-gdpr-notes
aliases: []
tags:
  - #type/reference
  - #domain/reimburse
parent: "[[employer-tracking-gdpr]]"
---
# more-gdpr-notes

- If what we do requires consent, we will likely lose a huge amount of data.
  Ideally, we figure out the maximum amount of tracking we can do without
  consent and also ask for consent for more detailed tracking.
- GDPR

- Anonymous company-level tracking is allowed without consent, provided the data
  is genuinely anonymized and can't be re-identified back to an individual.
- Ephemeral session tokens (created during a session, never stored, deleted
  immediately) don't create re-identification risk—so "session token XYZ from
  Company A visited page Z" is functionally the same as "Company A visited page
  Z."
- Timestamps are the main cross-referencing risk. Precise timestamps
  (second/minute-level) could let you link anonymous session data back to
  identified event data in your database (e.g. "Peter filled out a form at
  13:01:47"). Rounding to the hour is safer; the right precision depends on your
  traffic volume and how unique your event patterns are.
- Relative timestamps (T0, then +1 minute, etc.) let you capture user flow and
  temporal sequence through the site without absolute timing that could be
  cross-referenced.
- Small companies increase risk. With only ~10 users, tying sessions to a
  company edges toward indirect re-identification. Safest to just record
  "someone from Company A visited page Z" without session-level detail.
- Session replays require explicit consent—they capture detailed individual
  behaviour (clicks, scrolls, form inputs).
- Heatmaps and rage-click analysis are fine without consent if aggregated and
  not tied to individuals.
- Generic interaction flows (button clicks, page navigation with identifiers
  sanitized) aren't personal data on their own. Visiting a page about a
  sensitive topic isn't personal data unless the action itself reveals
  identifying/sensitive info.
- Golden rule: if there's no way to link the data back to an actual person,
  you're generally outside GDPR's scope.

---

## Related
- [[employer-tracking-consent-tiers]]
- [[posthog-consent-gdpr-notes]]
