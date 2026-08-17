---
id: role-based-employer-access
aliases: []
tags:
  - #planning
---
# Role Based Employer Access
_[Linear issue TCS-141](https://linear.app/electriccarscheme/issue/TCS-141/approvers) — Reimburse. - Employer Approvals project_

Related: TCS-141 Approvers, [[approval-groups]]

Draft issues: [[draft-issue-employer-admin-user-roles]],
[[draft-issue-reimburse-only-portal]]

## Claude Key Findings

- `EmployerAdminUser` has **no concept of roles** — it's binary: authenticated
  or not. No role or permission field anywhere on the model.
- `EmployerAdministrator` is the associated record (`has_one
  :employer_admin_user`); it has no role field either.
- `BaseController` for the employer portal does a single `define_administrator!`
  check — no role gating on any action.
- All portal routes are currently visible to every logged-in employer admin
  user: Home, Profile, Employer, Orders, ContractHub, ChargeOrders, Mileage,
  MileageClaims, AuditLog, BusinessMileageReimbursements, Trips, Invoices,
  Administrators, etc.
- Reimburse-specific routes are: `/mileage_claims`, `/mileage_claims_audit_log`,
  `/trips` — gated today only by `reimburseScheme.schemeStatus ===
  REIMBURSE_SCHEME_STATUS_OPTED_IN` in the frontend.
- Leighton is adding a "heat pump only" role (different scheme, same underlying
  problem) — any solution should be extensible to multiple role types.
- TCS-141 is In Progress and assigned to Peyton.

## What is the business need?

Enterprise customers (e.g. Suez) need line manager / approver users who can sign
into the employer portal but only see reimburse-related tabs. Today, inviting
any additional portal user gives them full access — charge orders, invoices,
documents, everything. A "reimburse approver" role must exist that scopes the
user to only the reimburse part of the portal.

## What is the current state?

No role model exists at all. All employer admin users see the same portal. The
only scheme-level gating is boolean feature flags in the business overview
response (e.g. `isCarSchemeEnabled`, `isReimburseSchemeEnabled`) which hide
routes at the frontend — but this is product enablement, not per-user
permission.

## Is there a way I can do nothing?

No — the approval flow (TCS-139) requires a "reimburse user" type; without roles
you cannot give someone approval access without also giving them full portal
access.

## What would an SE solution look like?

Add a `role` (or `roles`) field to `EmployerAdministrator` (or a separate join
table). Two initial roles:
- `full_access` — current default, sees everything
- `reimburse_approver` — sees only reimburse tabs

Backend: `BaseController` (and specific controllers) check role before allowing
access, returning 403 for out-of-scope routes. Frontend: `Dashboard.tsx` reads
the role from the administrator profile and conditionally renders routes/nav
items.

Extensible: Leighton's heat-pump-only role would be a third value on the same
enum.

## What is the absolute bare minimum?

Add a boolean `reimburse_only` flag to `EmployerAdministrator`. Backend
restricts charge-scheme controllers to non-reimburse-only users. Frontend hides
non-reimburse nav. Ships the approval flow unblocked.

## What can be done in a week?

The boolean flag approach above, with backend enforcement on the charge-scheme
controllers and frontend nav gating. Enough to ship TCS-139 safely.

## What can be done in three weeks?

A proper `role` enum on `EmployerAdministrator`, invitation flow that lets HR
admin select a role for a new user, and extensible backend/frontend role checks.
Leighton's heat-pump role slots in without more schema changes.

## How long would the perfect solution take?

4–5 weeks: full RBAC with a join table, per-route permission matrix, admin UI to
manage roles, audit log of role changes.

## What do I think is realistic in the current time-frame?

Boolean flag in week 1 to unblock TCS-139, migrate to proper enum in the same
sprint or following one. Don't gold-plate — the role list is small and
well-understood right now.

## What questions do I need to ask?

- What's Leighton's timeline for the heat-pump role? If it's imminent, skip the
  boolean and go straight to enum.
- Should an HR/full-access admin be able to see and manage reimburse-only users
  in the Administrators list?
- Is there a third role needed now (e.g. read-only auditor), or just full-access
  + reimburse-approver?

---

## Related
- [[approval-groups]]
- [[draft-issue-employer-admin-user-roles]]
- [[draft-issue-reimburse-only-portal]]
