---
id: discussing-posthog-vs-hotjar
aliases: []
tags:
  - #type/meeting
  - #domain/reimburse
  - #cycle/june
---
# discussing-posthog-vs-hotjar
- #person/trent
  + Posthog AB testing was used successfully in the past (though traffic
    limitations kept its usefulness to the early funnel points)
  + We're currently using the free tier of both, however maybe not a good idea
    to invest resources (time/money) into both
  + For analysis, we _can_ use big query to link hotjar to our data
- #person/leighton
  + Let's not have two dependencies to worry about
  + AB testing is of limited use with the traffic we have
  + Posthog has all the stuff we need from hotjar (like heatmaps)
- #person/luis
  + AB testing would be really useful
  + Posthog is so much cheaper and has the features we need - we'd basically be
    paying a lot more for hotjar, just for better UX
  + The level of heatmaps that Posthog has is sufficient, the full mouse
    tracking of all users' cursors isn't that useful
  + Setting up probes and seeing heatmaps of where people clicked and where they
    clicked after that is great - that combined with the session tracking is
    more than enough

---

## Related
- [[posthog-hotjar-final-notes]]
