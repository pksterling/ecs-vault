---
id: tcs-131-implement-dual-rate
aliases:
  - 1774019703-DYGW
tags:
  - #task
  - #cycle/march
---

# TCS-131: Implement Dual Rate

## Actions
- [x] Change latest rate to rate
  - [x] Add specs to test historic date rate
- [x] Add 'External' to enum
- [x] Pull frontend and column replacement into second PR

## Notes
- Added dual rate to backend
- Added dual rate to frontend
- Replaced `reimburses_business_mileage` with `business_mileage_reimbursement_calculator`
- Conversation #person/dushan
  - Pull the frontend and column replacement into separate PR
  - Add 'External' option to enum
  - Leave `reimburses_business_mileage` as ignored (remove column at a later date)

## PUUUUUUULLLLLLL-UUUUUUUUUUP
- We're using `OtherMileageCalculator` for the wrong stuff - revert the addition
  of a base class, abstract the rates

