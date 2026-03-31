---
id: missin-initial-reading-slack-bot
aliases: []
tags:
  - #task
---
# Missing initial reading slack bot

## Wut?!
- Voltric are bad at sending us their orders' initial odometer reading
- ECS are bad at chasing this up
- We have a bot that pings slack when there is an order without an odometer reading
- These get missed/forgotten

- We're adding a bot that pings slack weekly
  + Orders with missing odo readings
  + Days elapsed
  + On a Tuesday (to avoid bank holidays)

## Exploration
- Let's find the current bot
  + `#voltric-initial-mileage` slack channel - ECS Bot

    > **Delivered mileage**
    > Hi Voltric,
    > Please can you provide the odometer reading on delivery for:
    > Employee: `<employee_name>`
    > Registration: `<car_reg>`
    > @customer-care
