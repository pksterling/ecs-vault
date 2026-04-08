---
id: missin-initial-reading-slack-bot
aliases: []
tags:
  - #task
  - #cycle/march
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

- I've found wherer that bot is triggered
  `app/services/charge_scheme/create_initial_odometer_slack_notification.rb`
- It uses a slack client `Dependencies['clients.slack_v2']`
- I need to create a job that finds the relevant orders, triggers this bot with
  the relevant info
- *Is it only voltric orders?*

## Lost in the sauce
- Finished the notifier **BOOF**
- Now need to pass it order_ids
- I looked at the single notifier job but it collects based on whether or not
  that event has been triggered already - this won't work for this as it will
  have always been previously triggered
- Spoke to #person/dushan
  + The charge orders belong to quotes
  + Quotes have subscription configurations
  + In theory, this could be from other providers, so I must specify Voltric
  + Basically,
    `charge_orders.subscription.voltric.where.missing(:odometer_reading_initial)`
  + Write a query for prod and look for zero results

## Check check check
- Setting a reminder to check it is working on Tuesday morning
