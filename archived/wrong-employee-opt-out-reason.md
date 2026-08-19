---
id: wrong-employee-opt-out-reason
aliases: []
tags:
  - #type/debugging
  - #domain/batman
---
# Wrong employee opt out reason
_[Zendesk](https://electriccarschemehelp.zendesk.com/agent/tickets/71538)_

## What?
- #person/riz entered the wrong opt out reason for the employee
- He used ecs_disabling instead of 'customer does not want charge scheme'
- This means the correct reversal instruction wasn't created
- He says this prevented a reversal instruction being made, but that doesn't make sense to me

  ```ruby
    # app/models/charge_scheme/charge_order.rb
    def requires_payroll_reversal?
      !unenrolled_reason_car_returned? &&
        charge_scheme_payroll_instructions.reject(&:dry_run?).any? &&
        # Check if the charge order has been active for at least a year
        activated_on >= Date.current.prev_year &&
        !reversal_payroll_instruction.present? &&
        !employee.charge_scheme.active_charge_order?
    end
  ```

- It looks like only unenrolled_reason_car_returned would have caused this problem

