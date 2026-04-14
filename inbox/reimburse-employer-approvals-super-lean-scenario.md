---
id: reimburse-employer-approvals-super-lean-scenario
aliases: []
tags: []
---
# Reimburse Employer Approvals Super Lean Scenario
## Scenario
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

## What does this require?
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


