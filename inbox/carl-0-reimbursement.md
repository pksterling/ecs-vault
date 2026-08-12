---
id: carl-0-reimbursement
aliases: []
tags: []
---
# carl-0-reimbursement

## What is going on?
- Reimbursement for Carl is showing as zero
- No mileage method on nil (initial reading is nil) found in the odometer
anomaly page - a charge scheme handler
- Can't find anything matching in appsignal
- Problem
  + The claim was submitted on 23rd, so `pending_status_at` was during the 23rd
  + The trip date was 24th
  + Driving period is set to cover only _upto_ the mileage claim pending status at
  + Any trip on a date after the mileage claim submission date will be ignored
- Quickfix
  + Set `pending_status_at` to the trip date
- Longfix
  + Prevent future trip dates being submitted


