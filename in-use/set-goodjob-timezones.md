---
id: set-goodjob-timezones
aliases: []
tags:
  - #task
  - #cycle/april
---
# Set goodjob timezones

## What
- Goodjob runs at a different time depending on daylight savings time
- Let's run on the current timezone
- But make sure we don't run into problems doing it

## Go
- Set claude off to look through and check if any of the jobs will be affected
- Claude returned with a bunch of potentials
  + Jobs that interact with external systems
  + Jobs that use time/date related stuff
- Claude reckons all the internal stuff is safe so I'm getting it to do that and
  put it in a commit
- The rest: I'll need help with
- #person/fiona
  > The MMS ones are for us to periodically check the updates
  > that MMS are sending us, so they should be during business hours (extended
  > in case some people are working flexible hours)
  > Same for the Arval used catalogue polling
- Spoke to #person/dushan and he said fuck it
  + Just bunged the rest into the PR
- Reverting a few that are hourly or close to midnight - #person/alex-blair
- Up in a PR
