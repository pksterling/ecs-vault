---
id: posthog-hotjar-final-notes
aliases: []
tags: []
---
# posthog-hotjar-final-notes
No one, wants hotjar - everyone wants posthog - the only reason I can see to go
with hotjar is it sounds like it might be easier to setup

- ~8k employer admin users
- ~11k employer-initiated action in feb
- ~2k active employers in feb
- ~3k 24hr session in feb
- Call it 10k sessions, 1m hits

- Currently about 2k active employers
- Roughly 3k 24hr sessions
- Current usage would be free for both, if we triple our usage - we're looking at
  ~$25/month for posthog, $0 for hotjar

- User paths built to posthog, funnels added to hotjar
- Bigquery integration built in to posthog, hotjar requires third-party tool
- Posthog's Bigquery integration makes MCP querying easy and model agnostic, hotjar ai is
  stuck in hotjar
- Posthog has a/b testing, hotjar does not
- Posthog allows the passing of custom data from within the app for easy
  querying against identified employers
- Both have heatmaps, with mouse movement, clicking etc
- Posthog can record all sessions for replays, hotjar records a percentage of sessions
- Posthog would require a bit more to implement, but probably negligble in the
  long run

- In discussions with producty people, there is strong interest in using claude,
  tracking user paths, and session replays. As well as some interest in a/b
  testing, and tracking mouse movement/clicking. Posthog wins for all of this.
  To begin with, the cost is the same, and the difference is small even if we
  track tens of thousands of sessions. Bearing in mind that hotjar doesn't track
  all sessions.
- Speaking to #person/oleg and #person/marketing/dan
  + Hotjar is not currently used but should be/will be
  + Whatever we use needs attribution as a feature
    * Hotjar stores the referrer once per session
    * Posthog can store utm_source and referrer for each event
    * Using this data, we can surface multi-touch attribution (diy)
  + Also needs to play nice with squarespace (both do)
  + If we are switching to posthog, now would be the perfect time due to the
    lack of use of hotjar
  + Related marketing work will commence in the short-to-mid term
  + Very interested in AB testing, which hotjar doesn't support
