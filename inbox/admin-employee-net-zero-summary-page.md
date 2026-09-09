---
id: admin-employee-net-zero-summary-page
aliases: []
tags:
  - "#type/project"
  - "#domain/nzhs"
parent: "[[projects]]"
status: active
---

# admin-employee-net-zero-summary-page
_[Linear project](url)_
Adding a page in the admin portal, summarising an employee's net zero home scheme quotes.
Also includes easy reporting and a link to mailchimp

## Planning
### #person/leighton
- Pipedrive needs a link to the admin employee net zero summary page (ee-nz-sumamry)
- ee-nz-summary has two columns
  + Left: employee information
  + Right: each solution
    * Furthest quote (furthest: quote_request.step => referral.status)
      - If multiple quotes are at the same stage, show all of those
        + e.g. multiple provisionals from the same quote request
      - Shows solutions that were selected in that quote
      - Has a link to the booking page
      - Contains all the cash stuff, a link the employee quote request page
      - Solar also contains monthly spend, monthly bill, plus a button for a roof view modal
### #person/guarav - Mailchimp
- Which tags would be useful?
- #solution__stage
  + solution = [solar heat_pump battery_only charge_point]
  + stage = [new_in quote booked ordered installed]
- Leighton pushed back and says we only need to know if they've booked a call

### #person/lucas - Reporting
- Speak to Lucas
## Build

## Notes
