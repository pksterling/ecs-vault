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
