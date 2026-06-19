---
id: draft-issue-bulk-reimburse-order-creation
aliases: []
tags:
  - draft-issue
---
# Draft Issue: Bulk reimburse order creation
_Project: Reimburse — MVP employee onboarding_
_Planning note: [[reimburse-employee-onboarding]]_

---

## User Stories

As an admin user, I can:

* Run a script with a CSV to create reimburse orders in bulk, creating employees
  where they don't already exist
* See per-row errors if a row fails validation, without the rest of the batch
  being rolled back

## Considerations

* Modelled on `ChargeScheme::ChargeQuotes::BulkCreate` can be used as a reference
* No `CreateReimburseOrder` service exists
* Strategy should be derived automatically from `vehicle_ownership` +
  `fuel_type`
* We currently use the CapHPI API for EV vehicle lookup
