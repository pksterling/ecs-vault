---
id: reimburse-employer-approvals-issues
aliases: []
tags:
  - #planning
  - #cycle/april
parent: "[[reimburse-employer-approvals]]"
---
# Reimburse Employer Approvals Issues
## Issues
### [[tcs-139-employer-approvals|TCS-139 - Employer approvals]]
#### User Stories
- As an employer admin user, I can:
  + See a list of claims
  + View a claim, including a list of its trips
  + Approve a claim
  + Reject a claim, with a required reason

- As an employee, I can:
  + See the status of my claim and the reason if it was rejected

- As an employer admin user, I can:
  + Filter claims by employee, status, and rate

#### Considerations
- Claims only need the latest action/actor/timestamp, not the entire history

### Audit log
#### User Stories
- As an employer admin user, I can:
  + See a list of claims, including the latest action and actor
  + Filter claims

- As an employer admin user, I can:
  + Export the list to CSV

### Approvers
#### User Stories
- As an employer admin user, I can
  + Add and remove approvers for my company
  + Access reimburse data related to all employees in my company
- As an employer reimburse user:
  + I can access all reimburse related features
  + I cannot access any other employer portal features

- As an employer admin user, I can (re/un)assign employees to employer reimburse users
- As an employer reimburse user, I only have access to reimburse data related to
  my assigned employees

#### Considerations
- Currently, there is no role/permissions functionality - an employer admin user
  has full access to the employer portal
- Delegation of employees to a secondary reimburse user is out of scope, however
  allowing employees to be assigned to multiple reimburse users could be useful
