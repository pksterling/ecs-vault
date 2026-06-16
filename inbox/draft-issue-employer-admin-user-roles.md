---
id: draft-issue-employer-admin-user-roles
aliases: []
tags:
  - draft-issue
---
# Draft Issue: Employer admin user role model

_Project: Reimburse. - Employer Approvals_
_Planning note: [[role-based-employer-access]]_

---

## User Stories

As an employer admin user (full access), I can:

* Invite a new portal user and select their role (full access or reimburse approver)
* See the role of each user in the administrators list
* Remove a user regardless of their role

As a reimburse approver user:

* I can access all reimburse-related portal features
* I cannot access any non-reimburse portal features (orders, invoices, documents, direct debit, contract hub, etc.)

## Considerations

* `EmployerAdministrator` currently has no role concept — add a `role` enum (e.g. `full_access`, `reimburse_approver`)
* Default to `full_access` for all existing records
* `BaseController` and the relevant charge-scheme controllers should return 403 for reimburse-only users attempting non-reimburse routes
* The role enum should be designed to accommodate a third value (e.g. heat pump only) without schema changes
* Invite API (`/employers/dashboard/administrators/new`) needs to accept and persist the role
