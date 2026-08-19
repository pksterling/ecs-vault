---
id: fix-autosubmission-dividebyzero-bug
aliases:
  - Fix autosubmission dividebyzero bug
tags:
  - #type/task
  - #domain/charge-scheme
  - #cycle/march
parent: "[[reacting-to-early-odometer-requests]]"
---

# Fix autosubmission dividebyzero bug
- When creating an autosubmission, some charge orders are returning a divide by
  zero error
- This is happening because `days_delta` in the strategy is zero
- The strategy selector is, correctly, picking up that an employee reading has
  been submitted and so selecting the odometer-based strategy
- The strategy is ignoring this reading as it doesn't count as processed until
  the end of the month
- Fixing this just requires using the latest reading (instead of latest
  processed reading) and updating the latest method to use calendar month

## Tasks
- [x] Update latest method in odometer utility file
- [x] Use latest reading in odometer strategy
  + Including updating the odo mileage variable in the predictor
- [ ] Check Send Reminder email job
