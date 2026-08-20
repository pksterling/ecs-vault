---
id: nzhs-quote-homeowner-status
aliases: []
tags:
  - #type/task
  - #domain/nzhs
parent: "[[multi-product-qualification-question-flow]]"
---
# nzhs-quote-homeowner-status

## Running notes
- Includes the three property values:
  + Tenancy
  + Type
  + Description
- Running Claude code-review now

## How to set the correct quote stage?
- "Service" in the general sense of the word (not event service)
- Input quote request, return the current (or I guess next stage)
- Don't put it in services, put it in app/models
- I'm thinking `GetQuoteRequestStage`
- Claude says no need
