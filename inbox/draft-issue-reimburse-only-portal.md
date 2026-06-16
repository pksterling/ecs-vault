---
id: draft-issue-reimburse-only-portal
aliases: []
tags:
  - draft-issue
---
# Draft Issue: Reimburse-only employer portal experience

_Project: Reimburse. - Employer Approvals_
_Planning note: [[role-based-employer-access]]_

---

## User Stories

As a reimburse approver user, I can:

* Log in and see only reimburse-relevant navigation (mileage claims, audit log, trips)
* Not see nav items or pages for orders, invoices, documents, direct debit, employees, signatories, or contract hub

As an employer admin user (full access), I can:

* See a role indicator next to each administrator in the administrators list
* See a role selector when inviting a new administrator

## Considerations

* `Dashboard.tsx` conditionally renders routes and nav items based on `productConfig` and feature flags today — extend this pattern to also gate on administrator role from the profile response
* The administrator profile API response needs to expose the role
* The "Administrators" page itself should remain accessible to reimburse-only users (so they can see their own account) but the "invite" action should be full-access only
