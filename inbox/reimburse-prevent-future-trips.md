---
id: reimburse-prevent-future-trips
aliases: []
tags: []
---
# reimburse-prevent-future-trips
_[Linear ticket](https://linear.app/electriccarscheme/issue/TCS-182/un-submitted-future-trips-logic-in-claims)_

- When we re-submit a mileage claim (i.e add, delete, or edit a trip), the
  submitted_at attribute should be updated
- [x] Future trips should be prevented from being submitted (but should be allowed,
  as an unsubmitted trip)
- If a trip date is edited to be in the future, the trip should be unsubmitted
