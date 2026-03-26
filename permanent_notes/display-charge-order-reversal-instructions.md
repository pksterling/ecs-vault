---
id: display-charge-order-reversal-instructions
aliases: []
tags:
  - #task/completed
  - #ruby-rails
  - #react
---

# Display charge order reversal instructions

## Notes

### The hunt for the missing negative number
app/view_models/admin/charge_scheme/charge_order_view_model.rb
`reversal_instruction` contains a bunch of abs

I now understand: the reversal instruction that is being used for the other
section in the payroll section isn't actually the charge order reversal payroll
instruction (:

### And now we continue
Imma work from the front backwards!

Check the git diff, maybe a bit confused about where to change types -
PayrollInstruction looks like it's been manually set so I'll follow that.

### [[ecs-rails-to-react-type-flow|Types]] sorted?
- Edited view model
- Edited openapi ruby file
- Ran type api script
- Pulled the types into tsx file:
  - `GetChargeSchemeOrderT['response']['reversalPayrollInstruction'];`

### Where to calulate net savings
- Employee net savings is a sum of payment instructions savings
- Do I sum in place, use the calculator service, add it to the model, or add it
  to the order model
- Speaking to #person/dushan, using the calculator should be fine
- #person/dushan
  - Green tick for live run column
  - Include public charging total cost
  - For all summed columns, filter to before payroll month
  - Discussed adding attributes to reversal payroll instruction model to capture
    summed data, but decided there's no benefit at this point
  - Don't worry about date order, split reversals and payroll into two
  - Remove payroll vs reversal column
- PR:
  - [x] Merge `reversal_payroll_instruction` and `reversal_instruction`
  - [x] Add view model specs
  - [x] Add calculator spec
