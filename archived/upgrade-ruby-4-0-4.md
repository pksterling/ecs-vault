---
id: upgrade-ruby-4-0-4
aliases: []
tags:
  - #task
  - #cycle/april
---
# upgrade-ruby-4-0-4

## Why?
- Vulnerability scan is failing and blocking PRs
- Ruby default gems includes vulnerable version of erb
- That's now the second or third gem doing this
- Upgrading ruby to hopefully fix it

## AAAAAAAH
- Ruby repo hasn't updated imap to 6.4 yet (other than in master)
- Hacking through it instead
