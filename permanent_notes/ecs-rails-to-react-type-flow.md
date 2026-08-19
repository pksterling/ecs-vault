---
id: ecs-rails-to-react-type-flow
aliases: []
tags:
  - #type/reference
  - #tech/react
---
# ECS Rails to React type flow

## Adding attributes
- Edited view model
- Edited openapi ruby file
- Ran type api script
- Pulled the types into tsx file
  - e.g. `GetChargeSchemeOrderT['response']['reversalPayrollInstruction'];`

## Adding routes
- Add route to config/routes/api_public.rb
- Add controller
- Add openapi ruby file
- Run openapi script
