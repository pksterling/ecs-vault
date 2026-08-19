---
id: employer-tracking-gdpr
aliases: []
tags:
  - #type/project
  - #domain/reimburse
parent: "[[projects]]"
status: inactive
related:
  - "[[track-employer-portal-usage]]"
---
# employer-tracking-gdpr
_[Copied to Notion](https://app.notion.com/p/Data-Protection-GDPR-PECR-390b5f6a3cf080d4bae1d10e20c9474d?source=copy_link)_

## Linked notes
- [[posthog-consent-gdpr-notes]]
- [[employer-tracking-consent-tiers]]
- [[more-gdpr-notes]]
- [[reimburse-tracking-convo-blair-stefan]]

## tl;dr
- Aggregated data, helping us see how the app is used, should be fine
- Company-specific tracking might be difficult without consent
- Session replays definitely needs consent
- From my limited digging, our current use of hotjar does not look good

## What we want
- We want to know which employers would benefit from using reimburse
  + We can figure this out by knowing which pages they visit and which document
    types they download - combined with the company name, the number of
    employees, number of active orders etc
- We want to know how the employer portal is being used
  + User flows, heatmaps, session replays
- How changes to the employer portal affect use
  + A/B testing

## Hurdles
- PECR means we cannot store anything on the user's end, without consent
- GDPR means we cannot store any personal data (including IP address, or data
  that could technically identify them), without legitmate interest or consent
- GDPR almost definitely prevents intrusive tracking (i.e. session recording),
  without explicit consent

## Privacy policy
- Looks like it has some stuff that covers legitimate interest level stuff
- Won't cover things requiring explicit consent

## Current usage
### Posthog
- Present in employee and lead portals
- Potentially not actually being used; defaults to not capturing anything with
  no option to opt in anywhere
- We might still be using cookies, as that hasn't been switched off - could be
  an issue

### Hotjar
- Present in employee and employer portals
- Always recording, no opt-out available
- Includes session recording and heatmaps
- Tracking tied to employee id (allowing the association between session
  tracking and all of the employees personal data)
- **Intrusive tracking, easily-identifiable via the employee id, storing cookies
  on the user's end, without consent or opt-out option**

### Event services
- Stores personal data
- No consent necessary - legitmate interest (audit/security/accountability)
- Retention could be a problem, the data isn't deleted/anonymised when admin is
  deleted

## Without consent
- With careful implementation, keeping the data anonymised and/or aggregated
  (using Posthog's cookieless mode, avoiding personal data, user IDs etc), we
  can probably use the following without consent:
  + Single-session user flows (conversion funnels)
  + Heatmaps
  + A/B testing

## Maybe consent
- Regarding company-specific data:
  + We may find it difficult to do no consent
  + If we could guarentee that the user is unidentifiable from the company data,
    it could work - however, when a company has a handful of admin users, it
    becomes difficult to guarentee to the users' anonymity
  + With that being said, in-app page tracking would give us more control of
    what is stored and _maybe potentially could_ make it compliant _-ish_

## Requires consent
- Session replays will definitely require consent, both due to the necessary use
  of cookies (PECR), and because of the intrusive nature of it (GDPR)
- Cross-session user flows (conversion funnels) would need cookie consent

---

## Related
- [[posthog-consent-gdpr-notes]]
- [[employer-tracking-consent-tiers]]
- [[more-gdpr-notes]]
