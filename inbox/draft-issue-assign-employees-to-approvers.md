---
id: draft-issue-assign-employees-to-approvers
aliases: []
tags:
  - draft-issue
---
# Draft Issue: Assign employees to approvers (Stretch goal)

_Project: Reimburse. - Employer Approvals_
_Planning note: [[approval-groups]]_

---

## User Stories

As an employer admin user (full access), I can:

* Assign one or more employees to a reimburse approver
* Reassign or unassign an employee from an approver
* See which approver(s) each employee is assigned to

As a reimburse approver user:

* I can only see mileage claims, trips, and audit log entries for employees assigned to me
* If I have no assignments, I see no claims (not all claims)

## Considerations

* Requires a join table: `employer_administrator_employee_assignments` (employer_administrator_id, employee_id)
* Mileage claims, trips, and audit log controllers should scope by `administrator.assigned_employees` when the administrator is a reimburse approver with at least one assignment
* An employee can be assigned to multiple approvers
* Delegation (reassigning temporarily for leave cover) is out of scope
* The join table should be added even if the UI ships later — scoping logic can be wired up without the assignment UI being complete
