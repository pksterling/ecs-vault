---
id: product-selection-qualification-meeting-leighton
aliases: []
tags:
  - #planning
  - #cycle/july
parent: "[[product-selection-qualification-flow]]"
---
# product-selection-qualification-meeting-leighton

- `leads` table stores the answers to questions
- `leads` table contains all questions for all flows
- Quotes engine will  use the information to filter suppliers etc.
- Leighton sorts the engine
- Not gonna need configurables table, just hard-coded columns

  ```ruby
  class Lead
    belongs_to :employee
    has_many :quotes
  end

  class Quote
    belongs_to :lead
    has_many :products
  end

  class Product
    belongs_to :quote
    has_one :supplier
  end
  ```

---

## Related
- [[product-selection-qualification-claude-plan]]
