---
id: reimburse-brainstorming-session
aliases: []
tags:
  - #type/meeting
  - #domain/reimburse
  - #cycle/april
---
# Reimburse Brainstorming Session

#person/stefan and I had a brainstorming session yesterday, after a chat with
#person/alison - here's my attempt at creating a coherent summary of our
thoughts and questions:
- The timeframe in which expenses are allowed to be claimed will vary across
  companies - it could be as long as 3 months; having short, hard deadlines to
  input trips is too much friction
- Employees may forget to input trips, eventually submitting them after a claim
  has been processed
- Adding a trip, after a month's mileage has been processed, could lead to a
  scenario where the calculated mileage is more than the odometer reading
  + Feb 28th odo reading: 1000mi
  + Mar 5th odo reading: 1100mi
  + Mar 5th: Employee adds business trip from feb of 500mi
  + Adding that trip would require an odo reading of at least 1500mi to make sense
- What if someone exclusively home charges but then goes on a business trip
  requiring the use of a public charger? They'll want reimbursing at public
  charging rate
- Employees, especially those inputting a lot of trips, would want/need the
  ability to easily input from their phone

- As trips are added, out of date odometer readings become more of a problem. We
  could allow the _saving_ of trips, but prevent submitting (sending to
  approver) without an odometer reading
- Trips could have a status: unsubmitted, pending approval, rejected, approved,
  processed
- When reimburse instructions are created, it includes all trips with the status
  "approved", then changes their status to "processed". This makes it easy to
  process trips that have been forgetten and added to a previous month.
- The issue of a 'historic' trip breaching the odometer reading is easily
  prevented by blocking a submission that would cause this. This might not work
  for some users but would be okay for mvp

- Employees could select which plugsurfing sessions are for business mileage so
  they are reimbursed correctly. Not MVP
- To allow employees to submit trips from their phone, the whatsapp flow could
  be updated. Not MVP
