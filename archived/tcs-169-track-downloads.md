---
id: tcs-169-track-downloads
aliases: []
tags:
  - #type/task
  - #domain/reimburse
  - #cycle/june
parent: "[[track-employer-portal-usage]]"
---
# Track downloads
_[Linear issue](https://linear.app/electriccarscheme/issue/TCS-169/track-downloads)_

## Goals

- Once this ticket is complete: [CSV Downloads Level 2](https://linear.app/electriccarscheme/project/csv-downloads-level-2-8d349cb1f58c/overview). Matt is trained on the data
- [Stretch] (0.5 day challenge) export this data to reporting DB
- If we fail to get Level 2 downloads complete, fallback to use PH captures for downloads

## Claude Summary

Covers functional requirement #2 (download tracking) — logging each business-miles / odometer content download by file type, employer and timestamp.

Primary path is the adjacent **CSV Downloads Level 2** project; the deliverable here is making sure Matt is trained on those events and they carry enough info for him to act. If Level 2 doesn't land in time, fall back to PostHog event captures for downloads. Exporting download events to the reporting DB is a stretch (~0.5 day).

---

## Related
- [[tcs-167-posthog-identity-tracking]]
