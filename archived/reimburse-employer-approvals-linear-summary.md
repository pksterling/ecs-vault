---
id: reimburse-employer-approvals-linear-summary
aliases: []
tags:
  - #type/planning
  - #domain/reimburse
  - #cycle/april
parent: "[[reimburse-employer-approvals]]"
---

# Reimburse. Employer Approvals Linear Summary
_[Link to linear project](https://linear.app/electriccarscheme/project/reimburse-employer-approvals-2ae44f736f5b/overview)_

## Summary
- Business mileage claims must have line-manager approval

## User Story
- Line manager: review, approve/reject team's mileage claims
- Employee: view approved/rejected and why
- HR: view audit log of every approval decision

## Functional requirements
- Approval queue
  + Queue showing pending mileage claims from their team
  + Employee name, submission date, trips included, total distance, total
    reimbursement value
  + Actions:
    * Approve => payroll processing
    * Reject => return to employee with reason
    * Comment => return to employee with note
- Employee
  + View status: pending, approved, rejected
  + On rejection: shows reason, allows edited resubmission
  + Can edit claims, until approval
- Audit log
  + Logs all approval actions
  + Immutable
  + Accessible to HR
  + Exportable - filterable by employee and date range
  + Required columns: claim ID, employee, manager, action, comment, timestamp
- Manager hierarchy mapping
  + Employee has a line manager, set by HR
  + Claims are sent to assigned line manager
  + HR can update manager assignments, applies only to future claims
- Delegation
  + Approvers can delegate to another user for a defined date range
  + Log has delegation flag
  + Set by approver or admin

## Out of Scope
- Multi-level approval chains
- Auto-approval rules
- Integration with HR systems
- Mobile push notifications

## Open questions
- Do we need reminders/escalation if a claim sits unapproved for X days?
- Does rejection trigger a notification to the employee?
- Should delegation have a cap?
- Does HR need to be able to override and approve directly?

## Acceptance Criteria
- Line managers see a queue of pending claims from their direct reports
- Managers can approve/reject (with reason)/comment on claims
- Employees can view claim status - can edit and resubmit rejected claims
- All approval actions are logged immutably with actor, action, timestamp
- HR admin can export audit log per employee/date range
- HR admin can assign/update manager mappings
- Managers can delegate approval authority for a defined date range
- Claims are editable before approval and locked after
