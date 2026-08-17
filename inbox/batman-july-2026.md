---
id: batman-july-2026
aliases: []
tags:
  - #batman
---
# batman-july-2026

## triaging
- Pipedrive API migration (#person/alex-blair)
- [Employer has invited employees](https://electriccarschemehelp.zendesk.com/agent/tickets/80484)
  + Needs some exploration

## In progress
- [Matt, Pipedrive, Bigquery](https://electriccarschemehelp.zendesk.com/agent/tickets/80462)
  + Asked for help
- [Wrong lease provider](https://electriccarschemehelp.zendesk.com/agent/tickets/80698)
  + They didn't send the admin link

<!--
## Delegated
- [I have tried to do credit applications for this company however they are not going through/sending an email to MMS with the prop!](https://electriccarschemehelp.zendesk.com/agent/tickets/80466)
  + #person/ting is dealing with this
- [issue with quote tool - accelerated and flat payment options coming up as same price](https://electriccarschemehelp.zendesk.com/agent/tickets/80356)
  + Someone else seems to be dealing with this
  + #person/james is dealing with it
- [Not able to mark delivery date (promotion thing)](https://electriccarschemehelp.zendesk.com/agent/tickets/80120)
  + Left over from last week 
- [Can we look to update the taxes, charges and costs tab on the employer portal once processed](https://electriccarschemehelp.zendesk.com/agent/tickets/80731)
- [Novuna MHA](https://electriccarschemehelp.zendesk.com/agent/tickets/80528)
  + Don't have a clue what's going on here
  + Wants to resend a Novuna Multi Hire Agreement without voiding the old one
  + Asked slack for help
  + Stefan has this one
- [Remove employees from employer portal](https://electriccarschemehelp.zendesk.com/agent/tickets/80571)
  + Try to remove and check appsignal
  + Dushan has this one
-->

## Done
- [Revert order back to version 1](https://electriccarschemehelp.zendesk.com/agent/tickets/80753)
  + Stefan said:
    ```ruby
    order = ...
    sched = order.schedules.detect { it.version_number == 2 }
    sched.update(version_number: -1)
    ``````
- [Have an issue with marking as delivered.](https://electriccarschemehelp.zendesk.com/agent/tickets/80719)
  + #person/stefan said:
    * rails console
    * find quote
    * update(ensure_net_zero_impact: true) (or correct spelling)
    * save
    * retry in admin website (requires a delivery date)
- [Incorrect early return date](https://electriccarschemehelp.zendesk.com/agent/tickets/80545)
  + I think this is just an unearly-return thing
  + I've asked #person/fiona
  + She thinks they can change it themselves but I'm not so sure
  + order page => "End Of Life" => "Mark as returned early"
- [x] [Mark order as cancelled](https://electriccarschemehelp.zendesk.com/agent/tickets/80455)
  + Need to un-early-return then they can mark it as cancelled
  + Waiting for response from Fiona
  + Pushed back on why they need this
  + Sounds good enough, fixing it
- [x] [Cannot delete employee](https://electriccarschemehelp.zendesk.com/agent/tickets/80362)
  + Delete employee is in the playbook
  + #person/dushan reckons we don't delete it
  + Messaged #person/alex-blair
  + Cannot delete employee
  + **Replace personal data with obviously fake data**
  + Claude has written a script I need to look at [[redact-personal-employee-data-script]]
  + Done
- [x] [Revert order back to 'delivered' Kelly Goodwin (ONE UTILITY BILL LIMITED)](https://electriccarschemehelp.zendesk.com/agent/tickets/80452)
  + Just marking it as delivered
  + Need to un-early-return it then I can mark it as delivered
  + Waiting for response from Fiona
  + Marked as delivered with Fiona's new script

---

## Related
- [[redact-personal-employee-data-script]]
