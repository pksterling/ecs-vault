---
id: nzhs-quote-step-service
aliases: []
tags:
  - #type/task
  - #domain/nzhs
parent: "[[multi-product-qualification-question-flow]]"
---

# nzhs-quote-step-service

## What am I doing?
Writing a PORO that accepts a quote request and spits out the next step

```ruby
ALL_STEPS = %i[ your_details property roof energy space home quote ].freeze
STEP_SOLUTIONS = {
  solar: %i[your_details property roof energy quote ],
  heat_pump: %i[ your_details property space home quote ]
  battery_only: %i[ your_details property energy quote] 
}.freeze
```

## New approach
Use enummer to store completed steps

## Stefan's review
- #person/stefan pushed back on having so much logic in the frontend
- Suggested creating a struct to handle the step business
- Also wants a `QuoteRequest` module

- Guarded against drifting of ordered steps and enummer steps pushed
- Now need to create a quote request step view model, then set it up to send completed?
  current? slug and label
