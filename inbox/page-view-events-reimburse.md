---
id: page-view-events-reimburse
aliases: []
tags: []
---
# page-view-events-reimburse

## Running notes
- Manually testing contracts, CSV, and trips
---
- In order to audit the use of the employer portal, and ensure the frontend is
  receiving the correct data, we will be adding a page visit event to our events
  types
- From the employer portal top-level react file, send a request to the api,
  logging an event with the following params:
  + url
  + action (download file, visit page, etc)
  + person: id, name, email
  + employer: id, name, active schemes (ecs, tcs, reimburse, etc)
- Events are then queryable from the events page
- Further: send these events to the reporting DB in a human-readable format

## Plan
- Create page visit event
- Call from controller action
- Hit controller action from top-level employer portal react file
