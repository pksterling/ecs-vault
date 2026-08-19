---
id: services-handlers-events
aliases: []
tags:
  - #type/reference
  - #tech/rails
---
# services-handlers-events

## Handlers
- Sleekest code when called from an event
- Cannot be independently called (e.g. from the console, or in a spec)

## Services as a handler
- More clunky to be called from an event
- Freedom to be used wherever

## Event Services
- Default way of creating a service
- Only shows inputted information, output is not stored

## Services as an event
- Useful if you want to store the output of an event (or any custom data)

---

## Related
- [[recalculate-mileage-claim-totals-when-employee-updates-a-trip]]
