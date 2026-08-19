---
id: draft-issue-reimburse-only-portal
aliases: []
tags:
  - #type/draft-issue
  - #domain/reimburse
  - draft-issue
parent: "[[role-based-employer-access]]"
---
# Draft Issue: Reimburse-approver employer portal experience

_Project: Reimburse. - Employer Approvals_
_Planning note: [[role-based-employer-access]]_

---

## User Stories

As a reimburse approver user, I can:
* Log in and see only reimburse-relevant navigation (mileage claims, audit log, trips)
* Not see nav items or pages for orders, invoices, documents, direct debit, employees, signatories, or contract hub

As an employer admin user (full access), I can:
* Add the reimburse-approver role to an existing user
* Add the reimburse-approver role to a new user

## Considerations

* `Dashboard.tsx` already conditionally renders routes and nav items
* Reimburse approvers should be able to view their own account
