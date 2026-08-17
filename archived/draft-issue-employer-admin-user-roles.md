---
id: draft-issue-employer-admin-user-roles
aliases: []
tags:
  - draft-issue
parent: "[[role-based-employer-access]]"
---
# Draft Issue: Employer admin user role model

_Project: Reimburse. - Employer Approvals_
_Planning note: [[role-based-employer-access]]_

---

## User Stories

As an employer admin user (full access), I can:
* Access the entire employer portal
* Invite a new portal user and select their role
* See the role of each user in the administrators list
* Remove a user regardless of their role

## Considerations

* `BaseController` should return 403 for reimburse-only users attempting non-reimburse routes
* There will likely be a need for a user to have multiple roles in the future
* Roles should be removable
* A zero-trust approach would be safest
