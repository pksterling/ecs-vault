---
id: lessons-from-ecs-autosubmission-job-bug
aliases: []
tags:
  - #type/wisdom
  - #domain/charge-scheme
---

# Lessons from ECS autosbmission job bug
_Extracted from [[fix-autosubmission-bug]]_

## Prevention
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

## Debugging
- **Take the broken example and follow its journey**
  - I began by trying to figure out the problem, instead of following the
    process to find out exactly where the unexpected behaviour begins.
  - In this example: I began exploring the code to see what could be preventing
    the expected behaviour. Instead, what worked was taking the broken example,
    and running through each step in the code to see the interaction - here, the
    job I changed was fine, but the job I passed to _also_ needed changing.
