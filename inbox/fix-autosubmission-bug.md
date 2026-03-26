---
id: fix-autosubmission-bug
aliases:
  - 1774346907-OXSA
tags: []
---

# Fix autosubmission bug

## #person/stefan says...
- There's something wrong with your change to create autosubmissions for people
who submitted early.
- The email ran and assumed the folks would have an autosubmission but didn't.
- [Example](https://app.electriccarscheme.com/admin/charge_scheme/charge_orders/10d23792-8a05-471b-8365-344eccce4f75)

- PRIORITY
- Understood by midday, fixed today
- Reach out if not moving by 11

## Exploration
- The example shows the guy manually submitted on the 2nd March
- Therefore, there should be an autosubmission for the 31st (created on the 3rd)

### Is this because he submitted before the change went live?
- I need to find a working autosubmission
- As I'm looking through, it appears that autosubmission has worked for those
  who haven't submitted this month, but not those who have submitted early -
  the same as before
- **Has the job actually updated?**
- [Autosubmission from this morning](https://app.electriccarscheme.com/admin/events?eventType=odometer_reading_submitted)
- Struggling to find the job in admin

## Pairing with #person/stefan
- Take the example order we know isn't working
- Run it through the process:
  - Is it selected by the query that gathers the charge order ids? Yes
  - That ID is then passed through to the background job
  - The background job has an early return from `skip_execution?`
  - That method skips if there is a submission from this month (a duplication
    of the old query logic that I replaced)
- FIX: Changed to only skip admin submitted this month
- QUESTION: Why skip any? Let this job do it's thing and only pass it
  already-filtered orders?

## Action
- [x] Write specs
  - skips if admin reading this month
  - doesn't skip if employee this month
- [x] FIX: Changed to only skip admin submitted this month
- [x] Push PR
- [ ] Check with Leighton about the autosubmission (why does the predictor
  allow autosubmissions (probably because it needs to use last month's
  autosubmission))
- [ ] How could I have prevented this (checked further down the pipeline
  (maybe an integration test for the cron))
- [ ] How could I have caught this (checked the job once pushed to prod)

## Lessons
_Extracted into [[lessons-from-ecs-autosubmission-job-bug|Lessons from ECS autosubmission job bug]]_

### Prevention
- **Check production**
  - In this instance, a job was not behaving as it should be, and should have
    been. In fact, it was another job, that I hadn't checked, breaking that led
    to the discovery of this bug.
  - Should have waited for the job to run and checked the results
- **Follow the change end-to-end**
  - The code I changed, behaved exactly as expected, however it doesn't exist in
    a vacuum - it interacts with other parts of the application to create the
    end result.
  - I should have followed my code through to the end result to check the code
    would behave as expected.

### Debugging
- **Take the broken example and follow its journey**
  - I began by trying to figure out the problem, instead of following the
    process to find out exactly where the unexpected behaviour begins.
  - In this example: I began exploring the code to see what could be preventing
    the expected behaviour. Instead, what worked was taking the broken example,
    and running through each step in the code to see the interaction - here, the
    job I changed was fine, but the job I passed to _also_ needed changing.
