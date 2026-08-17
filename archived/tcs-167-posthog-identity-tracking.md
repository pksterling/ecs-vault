---
id: tcs-167-posthog-identity-tracking
aliases: []
tags:
  - #cycle/june
  - #task
parent: "[[track-employer-portal-usage]]"
---
# PostHog Identity Tracking
_[Linear issue](https://linear.app/electriccarscheme/issue/TCS-167/posthog-identity-tracking)_

## Running notes
- No simple way of getting posthog to work throughout the react and rails flow
- Already been implemented on other portals
- A few options for how to do it:
  + [*] **Get Claude to do it;**
  + Get Claude to point out where it has been done in the app already;
  + Get Claude to lay out the documentation flowl;
  + Figure out myself.
- Wow, looking at the calendar, I have three weeks to get everything done. Looks
  like Claude is doing it.
- Claude mentioned opt-in/opt-out and it's made me think of GDPR
- Currently exploring if this counts as legitimate interest

## Goals

- Posthog in employer portal
- Posthog tracks pageviews (aka `posthog.identify(ID,
  OPTIONAL_OBJECT_OF_ATTRS)`)

## Claude Summary

Foundational ticket for the project — gets PostHog into the employer portal and
identifies who's using it so every other tracking ticket has data to work with.

Per Stefan's notes on the project, identify on the employer admin user id but
also pass **email** (Matt can't resolve who a raw id belongs to) and the
**employer id**. The employer id must update when the current employer changes.
Once identity + pageviews are flowing, page-level tracking (employer, page,
timestamp) comes essentially for free from PostHog autocapture.

---

## Related
- [[employer-portal-tracking-options-comparison]]
- [[posthog-consent-gdpr-notes]]
