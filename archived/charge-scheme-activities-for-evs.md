---
id: charge-scheme-activities-for-evs
aliases: []
tags:
  - #type/task
  - #domain/charge-scheme
  - #cycle/march
---

# Charge scheme activities for EVS
[Link to linear project](https://linear.app/electriccarscheme/project/charge-scheme-activities-for-evs-d2d3a7a5f3eb/overviewb)

## Running notes
- I think that I need to look for some 'tasks' to do with pipedrive - something
gets sent to pipedrive
- Search `EVS Post Delivery Courtesy Call`

## Task 1
- Pipedrive automation: Scheduling EVS post delivery call
- Pass task to #person/shahrukh

## Finding Charge Scheme - Post Delivery Check In
- cron job `create_post_delivery_checkup_activities` runs monday to friday at
  8am - calls `Employers::Orders::CreatePostDeliveryCheckupActivities::BackgroundJob`
- Calls `::Events::Employers::ORDER_POST_DELIVERY_CHECKUP_ACTIVITY_REQUESTED`
  for each relevant car order
- Calls `::Employers::Orders::CreatePostDeliveryCheckupActivity`
- The pipedrive call includes the following in notes
> Post-delivery check-in for #{employee_name} at #{employer_name}.
> Vehicle was delivered on #{order.delivery_date.strftime('%d/%m/%Y')}.
> View car order details: <a href="#{admin_order_url}">Order ##{order.id}</a>
> View charge order details: <a href="#{admin_charge_order_url}">Order ##{order.charge_order&.id}</a>
- Is that the right stuff?

## Speaking to #person/riz
- Task 1
  - Should be same schedule, but with follow up next day
- Task 2
  - change to 24th instead of 6 weeks post delivery
  - Call next day on no contact
  - Add note to existing

## Clarification
- Speak to Riz
  - What exactly am I changing for both?
  - I've found task 2 - I assume I'm changing the name but not sure about the
    rest
  - Don't know where to find task 1 - it's not in the codebase
  - What does call 1 + a follow up the next day mean?
