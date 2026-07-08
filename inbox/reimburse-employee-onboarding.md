---
id: reimburse-employee-onboarding
aliases: []
tags: []
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
