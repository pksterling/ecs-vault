---
marp: true
theme: default
paginate: true
---

# Sprint Demo
### Peyton Sterling — May 2026

---

## Fix: Autosubmission Divide-by-Zero
**PR #6573 · Merged 26 Mar**

**Context**
We create end-of-month odometer autosubmissions for customers who haven't submitted. The strategy calculates mileage by comparing the latest reading against the initial one.

**Problem**
When a customer submitted an early reading, it wouldn't be "processed" until next month. The strategy ignored it — so for first-time submitters, it was comparing the initial reading to itself, triggering a divide-by-zero error.

**What changed**
Updated the strategy to use the latest reading, not just the latest *processed* reading.

**Result**
Autosubmissions no longer crash for customers with early or first-time submissions.

---

## Fix: Non-Compliant Autosubmissions Reverted
**PR #6588 · Merged 30 Mar**

**Context**
We had built logic to auto-submit readings for customers who submitted early in the month — to help avoid minimum charges.

**Problem**
Tom E raised that this behaviour wasn't compliant with the wording in our S2 agreement (section 8). Some autosubmissions had already been created this month.

**What changed**
Reverted the early-submission autosubmission logic. Deleted the non-compliant autosubmissions that had been generated. Went back to the original behaviour: only autosubmit for customers who haven't submitted at all this month.

**Result**
Back to compliant behaviour before month end. No harm done — none of the bad autosubmissions had been actioned. Stefan is planning a compliant long-term approach.

---

## Fix: Reminder Email Crashing on Voltric Orders
**PRs #6589 & #6607 · Merged 30–31 Mar**

**Context**
Voltric occasionally deliver cars without providing the initial odometer reading. These orders end up in our system in an incomplete state.

**Problem**
AppSignal surfaced a recurring error in the odometer reminder email job: `no implicit conversion of nil into Hash`. The job was trying to build autosubmission email data for orders that had no initial reading — crashing each time.

**What changed**
Added a guard at the start of the job to skip any charge order without a valid initial reading.

**Result**
Error resolved. The reminder job now handles incomplete Voltric orders cleanly instead of crashing.

---

## New: Weekly Slack Alert for Missing Initial Readings
**PR #6652 · Merged 8 Apr**

**Context**
When Voltric fails to provide an initial odometer reading, a one-off Slack message is sent to `#voltric-initial-mileage`. These messages were getting buried and forgotten.

**Problem**
Missing readings were slipping through, creating downstream issues. Nobody was reliably following them up.

**What changed**
Added a weekly background job that:
- Finds all Voltric orders still missing an initial reading
- Posts a summary to Slack including the employee name, registration, and how many days have elapsed
- Runs on Tuesdays to avoid bank holidays

**Result**
Customer care now gets a consistent weekly nudge. Missing readings are much less likely to be forgotten.

---

## Fix: Consistent Job Scheduling Across BST/GMT
**PR #6896 · Merged 6 May**

**Context**
Our background jobs (reminders, billing runs, etc.) are scheduled via GoodJob using UTC times. This means they run an hour earlier or later when the clocks change — twice a year.

**Problem**
Jobs were effectively drifting: a job meant to run at 9am was running at 8am in summer. This affected customer-facing emails and internal processing.

**What changed**
Added `Europe/London` timezone to all GoodJob cron schedules. Jobs that interact with external partners (MMS, Arval, Benify, Lloyd Latchford, payroll) were left in UTC pending SLA checks.

**Result**
All internal jobs now fire at the correct London clock time year-round, regardless of daylight saving.

---

## In Progress: Employer Approvals — Claims Index (TCS-139a)
**PR #6921 · In Review**

**Context**
We're building out employer approvals as part of the Reimburse project. Employers need to be able to see, approve, and reject mileage claims submitted by their employees — currently there's no interface for this at all.

**Problem**
Employers have no visibility into employee mileage claims. The whole approval workflow is missing.

**What changed**
First sub-task: added a mileage claims index page to the employer portal. Employers can now see a list of claims from their past and current employees, including employee name, submission period, trip count, submission date, and approval status — with colour-coded status badges. Also added a dashboard card to surface the page from the main employer dashboard.

**Result**
PR in review. First piece of the approvals flow is ready. Next up: viewing individual claims (TCS-139b), then approve/reject actions.
