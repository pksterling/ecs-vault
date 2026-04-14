---
id: reimburse-employer-approvals-planning
aliases: []
tags:
  - #planning
  - #cycle/april
---
# Reimburse - Employer Approvals

- [[Reimburse Employer Approvals Linear Summary]]
- [[reimburse-brainstorming-session|Reimburse Brainstorming Session]]
- [[Reimburse Employer Approvals Super Lean Scenario]]

## Prioritisation
### Super lean
#### Scenario
- Approver logs in - only has access to reimburse.
- Approver sees list of pending claims from company
- Approver can view claim
  + Lists all trips within claim
  + Are there multiple claims per user?
- Approver can:
  + Reject
  + Approve
- Employee can view status
- Employee can edit unprocessed claim - add/remove trips
- Admin has approver-access
- Admin can view audit log
- Admin can export audit log (per reimburse intstruction?) (to csv?)
- Admin can add/remove approvers
- Month end (or whenever processed) claim is processed - trips are marked as
  processed

#### What does this require?
- Approver
  + Needs access to employer portal
  + Use `EmployerAdminUser`? _I really wanna rename it `EmployerUser`_
    * Now have at least two authorisation levels in employer portal
      - Admin, approver, and (maybe) reimburse admin
- Roles
  + If implementing role-based authorisation, I'd choose a joins table, but
    that's a question for the team
  + It would be incredibly easy to implement, and undo, auth with a single
    column on `EmployerAdminUser`


- Can we forgo employees belonging to specific approvers for MVP?
- What time cutoff do we have, if any, for trips? We could even leave it open
  and approvers can reject it if it doesn't fit their policy
- Can employees add 'historic' trips (from a previous period)? This should
  easily fit into MVP from a technical perspective
- Can we block historic trips that breach the odometer reading? If not, can we
  do it as MVP?
- Do all TCS users require trips?
- Do we eventually allow employees to assign particular plugsurfing sessions to
  business mileage? Can we leave that out of MVP?
- Can approvers/admins add trips on behalf of an employee?
- We currently have an employer admin user. We will need to add an approver. Do
  we also need a reimburse admin user that can manage reimburse (but without
  full access to ecs/tcs)?

- Does the audit log include every action for a trip, or just the most recent status (w/
  actor and timestamp)?
  + Just the most recent
- What happens if an employee adds trips after a claim has been approved, but
  before it has been processed?
  + All unprocessed trips are unapproved and resubmitted with the additional trips
