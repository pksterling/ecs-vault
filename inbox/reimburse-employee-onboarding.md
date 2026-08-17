---
id: reimburse-employee-onboarding
aliases: []
tags:
  - #task
---
# reimburse-employee-onboarding
_[Linear issue](https://linear.app/electriccarscheme/issue/TCS-175/bulk-reimburse-order-creation)_

## What?
- Employer can upload a csv of employees with info about their cars
- For each employee:
  + Create the employee (if they don't already exist)
  + Create a reimburse order associated to the employee
  + Reimburse strategy should be automatically derived from the CSV data

## How?
- Use CapHPI (or maybe DVLA) for vehicle data
- Show per row errors, without hindering other rows

## Steps
- Service that creates a reimburse order
- Strategy derivation
- Bulk create
- Error handling
- CSV upload

## CreateReimburseOrder
- #person/stefan already created this
- Just need to make it fit for real use

### Notes
The current service is set up to receive just about every attribute from the
event payload. I'm not sure if this is the best idea or not. I'm going to be
setting up so that some stuff is automated. But then what if we need to manually
add. What would the best course of action be here? I think it needs to be
flexible, which would suggest keeping it attribute-y but then where is the
automation handled? Keep it simple, I just need a service that won't break.

I think the service works as is..? Messaging stefan
> Oh yeh it just needs a tonne more added to it
> e.g. but not limited to:
> - cannot create reimburse order (RO) with same reg plate as a charge order (CO)
>   + that you don't also own
>   + that is not linked to this reimburse order aka they must be linked
> - you cannot create a RO with a car reg that matches an existing
> - you cannot create an RO if you have more than one already
>   + might be able to use the CanRunEngine contract for this one 
> - if you've linked to a CO, your order must be business type and elec

---

## Related
- [[reimburse-employee-onboarding-planning]]
- [[draft-issue-bulk-reimburse-order-creation]]
- [[create-reimburse-order-snippet]]
