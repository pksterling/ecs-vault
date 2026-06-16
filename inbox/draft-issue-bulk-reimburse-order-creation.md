---
id: draft-issue-bulk-reimburse-order-creation
aliases: []
tags:
  - draft-issue
---
# Draft Issue: Bulk reimburse order creation (CRAP script)

_Project: Reimburse — MVP employee onboarding_
_Planning note: [[reimburse-employee-onboarding]]_

---

## User Stories

As an admin user, I can:

* Run a script with a CSV to create reimburse orders in bulk, creating employees where they don't already exist
* See per-row errors if a row fails validation, without the rest of the batch being rolled back

## Considerations

* Modelled on `ChargeScheme::ChargeQuotes::BulkCreate` — tab-delimited CSV, wraps each row in a transaction
* Minimum CSV columns: employee email, first name, last name, vehicle registration, vehicle ownership (personal/company), fuel type, engine size band (optional), activated on, business mileage in first year (AMAP only)
* Strategy auto-assigned from ownership + fuel type — not a CSV column
* No VRM lookup in this issue — caller provides fuel type and engine size directly
* Depends on the `CreateReimburseOrder` service from the sibling issue
