---
id: dual-rate-business-mileage
aliases: []
tags:
  - #planning
  - #task/to-do
---

# Dual rate business mileage

## Run through with #person/dushan
Calculator: `app/models/charge_scheme/calculators/business_mileage_reimbursement_calculator.rb`
See todo

advisory electric rate - public charger
`app/models/charge_scheme/calculators/other_mileage_cost.rb` <- where AER rate is defined, do something similar for public
single item hash

`app/services/charge_scheme/month_end/create_business_mileage_reimbursement_instruction.rb` update to use new dual_rate
update spec for unsupported

`spec/factories/month_end/charge_scheme_business_mileage_reimbursement_instruction.rb`

## Tasks
- [?] [[tcs-131-implement-dual-rate|TCS-131: Implement Dual Rate]]
- [?] TCS-122: Change employer biz miles reimbursement strat on admin
- [ ] TCS-120: Exporting to Reporting
