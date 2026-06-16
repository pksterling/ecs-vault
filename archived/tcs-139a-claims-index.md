---
id: tcs-139a-claims-index
aliases: []
tags:
  - #cycle/april
  - #task
---
# tcs-139a-claims-index
## What does this do?
- An employer admin user should be able to view a list of claims
  + [x] Claim model
  + [x] Employer approvals route
    * Route works
    * Now checking we don't get claims from other companies
  + [x] Link to employer approvals in dashboard
  + [x] Claims table
    * Columns are already added to db table
    * [x] Create front-end cjjlaims table
    * Set claude off working
    * Looks like it's built
    * Need seeds
    DONNNNNNNNE

## PR Summary
- [x] Toggling the reimburse related links on the employer dashboard
  + `app/view_models/public/employers/employer_view_model.rb`
  + Currently using `!Rails.env.production?`
  + Instead use the reimburse scheme config
- [x] Scoping claims to the correct employer (specifically when an employee has
  claims across multiple employers)
  + `app/view_models/public/employers/approvals_view_model.rb`
    + Currently showing all of an employee's claims to their current employer
  + Currently showing none of an employee's claims to a previous employer
  + Instead show each employer the claims of their past and present employees,
    that were claimed during the employee's time with that employer
- [x] Rename `ApprovalsController` to `MileageClaimsController`
- [x] Reimburse cards should be easier to add to the dashboard
- [x] Change route from `approvals` to `mileage_claims`
- [x] Conditionalise the reimburse links on the dashboard
+ `app/javascript/employer/dashboard/Dashboard.tsx`
- [x] Render reimbursementCents asd a formatted currency
+ `app/javascript/employer/dashboard/pages/approvals/components/ApprovalsTable.tsx`
- [x] Move seed stuff to reimburse scenario file
- [x] Add pagination and optimize trip counting query
  + `app/view_models/public/employers/approvals_view_model.rb`
  + Compute trip count in SQL, or use a cache to store the count
- [x] Add screenshots of the frontend

## Re-reviewed PR
- [x] Extra line in mileage claims view model spec
- [x] Duplication in business overview
- [x] Change employer id to null false in migration
- [x] Rename serialize claim to present claim in view model (also maybe see
  about other naming convention)
- [x] Maybe add cached data to mileage claim
  + Check for a service for creating a claim and then add the cached columns to
    it

## Re-re-reviewed PR
- Team decisions: use the employment association to link to employee/employer
- Just checking with #person/alex-blair

## Did the employment association work?
- Did it fuck!
- Reversing it
