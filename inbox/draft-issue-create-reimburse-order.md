---
id: draft-issue-create-reimburse-order
aliases: []
tags:
  - draft-issue
---
# Draft Issue: Create reimburse order

_Project: Reimburse — MVP employee onboarding_
_Planning note: [[reimburse-employee-onboarding]]_

---

## User Stories

As an admin user, I can:

* Create a reimburse order for an employee by providing their vehicle registration, vehicle ownership (personal/company), fuel type, engine size band (if applicable), and activation date
* See a validation error if the combination of ownership, fuel type, and strategy is invalid

## Considerations

* No `CreateReimburseOrder` service exists — this is the foundational piece for any onboarding path
* Strategy should be derived automatically from `vehicle_ownership` + `fuel_type` using `ReimburseOrder::STRATEGY_TO_PERMITTED_CONFIG` — caller should not need to specify it
* `engine_size_band` is required for AFR (company + petrol/diesel) orders; `business_mileage_in_first_year` is required for AMAP (personal vehicle) orders
* The `car` association requires a `Cars::Car` record — for EVs this can be resolved via CapHPI (`FindElectricCarFromVrm`); for non-EVs a fallback or manual car_id input is needed for now
* No employer portal UI in this issue — backend service only
