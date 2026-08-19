---
id: draft-issue-create-reimburse-order
aliases: []
tags:
  - #type/draft-issue
  - #domain/reimburse
  - draft-issue
parent: "[[reimburse-employee-onboarding]]"
---
# Draft Issue: Create reimburse order

_Project: Reimburse — MVP employee onboarding_
_Planning note: [[reimburse-employee-onboarding]]_

---

## User Stories

As an admin user, I can:

* Create a reimburse order for an employee by providing their vehicle
  registration, vehicle ownership (personal/company)

## Considerations

* No `CreateReimburseOrder` service exists
* Strategy should be derived automatically from `vehicle_ownership` +
  `fuel_type`
* We currently use the CapHPI API for EV vehicle lookup

---

## Related
- [[create-reimburse-order-snippet]]
