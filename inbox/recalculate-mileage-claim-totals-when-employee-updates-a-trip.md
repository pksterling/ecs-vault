---
id: recalculate-mileage-claim-totals-when-employee-updates-a-trip
aliases: []
tags:
  - #task
  - #rails
---
# Recalculate mileage claim totals when employee updates a trip

## PR #7226: Recalculate mileage claim totals when employee updates a trip

`app/controllers/api/public/employee/reimburse_scheme/trips_controller.rb:63`
Guard against mileage claim not existin
_Don't; we don't need a mileage claim id if there is no mileaege claim_

---
`app/services/reimburse_scheme/handle_mileage_claim_on_trip_deletion.rb:21`
Replace class with inline conditional

---
`app/services/reimburse_scheme/update_mileage_claim_totals.rb:1`
Keep as an event - search "def make_event"

---
`app/services/reimburse_scheme/withdraw_mileage_claim.rb:19`
Replace contract with a `halt_unless`

## [[services-handlers-events|Conversation with #person/stefan with events]]

---

## Related
- [[services-handlers-events]]
