---
id: approval-groups
aliases: []
tags: []
---
# Approval Groups
_[Linear issue TCS-143](https://linear.app/electriccarscheme/issue/TCS-143/assign-employees-to-approvers-stretch-goal) — Reimburse. - Employer Approvals project_

Related: [[tcs-141-approvers|TCS-141 Approvers]], [[role-based-employer-access]]

Draft issues: [[draft-issue-assign-employees-to-approvers]]

## Claude Key Findings

- TCS-143 is a **stretch goal** in Backlog — not in the current sprint.
- Without groups, a `reimburse_approver` user sees ALL employees at their company. For large employers (e.g. Suez) this is unacceptable — line managers should only see their direct reports.
- No assignment/group model exists today. `EmployerAdministrator` has_and_belongs_to_many employers (multi-company support) but no link to specific employees.
- `ReimburseScheme::MileageClaim` belongs_to `reimburse_order` → `employee` → `employer` — so filtering claims by approver group means filtering on the employee association.
- The employer approvals controllers (`mileage_claims_controller`, `trips_controller`) currently scope by employer only — no further restriction.
- TCS-143 mentions: employees can be assigned to multiple reimburse users; delegation out of scope for now.
- The audit log (`mileage_claims_audit_log_controller`) would also need scoping if groups are implemented.

## What is the business need?

Large employers need line managers to approve only their own team's mileage claims. Without this, a "reimburse approver" user either sees nothing (useless) or sees 500 employees' claims (overwhelming and a data exposure risk). Assignment groups map approvers to the subset of employees they're responsible for.

## What is the current state?

No assignment model exists. All employer-scoped reimburse data (mileage claims, trips, audit log) is currently accessible to any authenticated employer admin user with no employee-level restriction.

## Is there a way I can do nothing?

For the initial launch yes — if the first employers onboarding the approval flow are small enough that one approver handles all employees, groups aren't needed. Stretch goal for a reason.

## What would an SE solution look like?

A join table: `employer_administrator_employee_assignments` (employer_administrator_id, employee_id). The reimburse controllers add a `.where(employee: administrator.assigned_employees)` scope. If an administrator has no assignments, they see all employees (backward-compatible default for full-access admins).

Frontend: HR admin can go to the administrators list, open a reimburse-only user, and assign/unassign employees. Possibly a bulk CSV assign.

## What is the absolute bare minimum?

The join table + a scoped query in the mileage claims controller. No UI — assignments made via Rails console / CRAP script initially.

## What can be done in a week?

Join table + backend scoping. Possibly a basic admin UI to assign employees to an approver (list with checkboxes).

## What can be done in three weeks?

Full assignment UI, bulk assign/unassign, CSV import of assignments. Clear UX showing each employee who their approver is.

## How long would the perfect solution take?

3–4 weeks for a polished self-service flow including bulk operations, conflict resolution (employee assigned to multiple approvers), and audit trail of assignment changes.

## What do I think is realistic in the current time-frame?

This is a stretch goal and shouldn't block the core approval flow. Build the join table early (cheap to add now, expensive to retrofit) but defer the UI until a customer explicitly needs it.

## What questions do I need to ask?

- Do we have an employer signed up that needs groups before launch, or is this purely speculative capacity?
- Should unassigned employees default to visible to all approvers, or only to full-access admins?
- Can employees be assigned to multiple approvers, or is it 1:1? (TCS-143 says multiple is "could be useful" — is that confirmed?)
- Does the audit log need to be scoped by group too, or is it HR/full-access only?
