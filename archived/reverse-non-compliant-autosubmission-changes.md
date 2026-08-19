---
id: reverse-non-compliant-autosubmission-changes
aliases: []
tags:
  - #type/task
  - #domain/charge-scheme
  - #cycle/march
parent: "[[reacting-to-early-odometer-requests]]"
---
# Reverse non-compliant autosubmission changes

## #person/stefan summary of meeting

> ### What's done:
> - Customers who submitted odo readings early in the month get an email inviting them for another
> - Customers who submitted odo readings early in the month get an autosubmission
> ### Value of work :
> - (High Priority) Avoid min charges
> - (Low Priority) Bill semi-consistent amounts
> ### Concern raise by Tom E:
> - (Major) The autosubmission is not complaint with our S2 wording (check section 8 in this S2
  for example)
>   + It's a great idea, but we need the S2 to reflect that otherwise 
> - (Minor) When we perform an autosub (because their reading is too early). We should inform them
>   + Note: they would currently be informed in the end of month email - still not clear though
> - *Note: Non of the non-compliant auto-subs have been actioned. If we undo them, no harm, no foul*
> ### Next Steps:
> - Immediately
>   + @Peyton Sterling to propose how to (@Stefan Collier to support):
>     * remove the non compliant autosubmission
>     * prevent future non-complaint autosubmission
>       *hint: shouldn't be a big problem*
>   + @Stefan Collier to double/triple check the S2 cannot be re-interpretted into being compliant
>     *hint: probs won't*
>   + @Peyton Sterling + @Stefan Collier to roll out plan before Month End (we have today + 1.5
>     days next week)
> - Longer Term
>   + @Stefan Collier to plan a compliant approach
>     * where:
>       - New S2's have this wording by default
>       - Existing customers get an amendment 
>         + plan for roll out
>       - Customers are clearly informed about the autosubmission
>     * proposal to be taken to Tom and Matt by end of next week

## My next steps
- Figure out:
  + remove non-compliant submissions
    * I believe this should be any autosubmissions after march employee readings
  + prevent future non-compliant submissions
    * Revert the changes from [6573](https://github.com/The-Electric-Car-Scheme/ecs-calculator-app/pull/6573), [6557](https://github.com/The-Electric-Car-Scheme/ecs-calculator-app/pull/6557), [6349](https://github.com/The-Electric-Car-Scheme/ecs-calculator-app/pull/6349)

## Remove non-compliant submissions
```ruby
bad_autosubmissions = ChargeScheme::OdometerReading
                      .reading_type_auto_submission
                      .where(day: Date.current.all_month)
                      .joins(charge_order: :odometer_readings)
                      .where(charge_order: { odometer_readings: { day:
                      Date.current.all_month, reading_type: "employee" } })

```
## Reverting autosubmission changes
- Pushed a PR reverting everything
- #person/stefan says we don't need to lose all the work
- Just prevent the job itself autosubmitting
- I feel like this caused problems with the reminder job so I'll need to check that

- I have specs for actual job, as well as for the selector job
- I'll be reverting just the logic of the actual job
- Do I need specs for my reverting, or do we just trust that his has reverted?
- How do we document the fact that the selector job is handing over orders that
  will be blocked?
- Will this cause job errors for the email job?
