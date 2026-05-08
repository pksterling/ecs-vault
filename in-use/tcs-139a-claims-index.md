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
- [ ] Toggling the reimburse related links on the employer dashboard
  + `app/view_models/public/employers/employer_view_model.rb`
  + Currently using `!Rails.env.production?`
  + Instead use the reimburse scheme config
- [ ] Scoping claims to the correct employer (specifically when an employee has
  claims across multiple employers)
  + `app/view_models/public/employers/approvals_view_model.rb`
  + Currently showing all of an employee's claims to their current employer
  + Currently showing none of an employee's claims to a previous employer
  + Instead show each employer the claims of their past and present employees,
    that were claimed during the employee's time with that employer
- [ ] Add pagination and optimize trip counting query
  + `app/view_models/public/employers/approvals_view_model.rb`
  + Compute trip count in SQL, or use a cache to store the count
- [ ] Conditionalise the reimburse links on the dashboard
  + `app/javascript/employer/dashboard/Dashboard.tsx`
- [ ] Store getReimburseDashboardCards in a local variable instead of calling twice
  + `app/javascript/employer/dashboard/pages/Home.tsx`
- [ ] Render reimbursementCents asd a formatted currency
  + `app/javascript/employer/dashboard/pages/approvals/components/ApprovalsTable.tsx`
- [ ] Add screenshots of the frontend
- [ ] Rename `ApprovalsController` to `MileageClaimsController`
- [ ] Move loaders to the top of the page
  + `app/javascript/employer/dashboard/pages/approvals/components/ApprovalsTable.tsx`
- [ ] Reimburse cards should be easier to add to the dashboard
- [ ] Move seed stuff to reimburse scenario file
- [ ] Change route from `approvals` to `mileage_claims`
