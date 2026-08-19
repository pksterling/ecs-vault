---
id: reimburse-employer-approvals-plan
aliases: []
tags:
  - #type/planning
  - #domain/reimburse
  - #cycle/april
parent: "[[reimburse-employer-approvals]]"
---
# Reimburse Employer Approvals Plan

```ruby
class Claim
  has_many :trips
  enum status: %i[unsubmitted, submitted, rejected, approved, processed]
  validates :rejection_reason, presence: true, if: :rejected?
end
```

## Scenarios
### Claim Approval
- Admin visits mileage claim approvals page
  + Admin views a list of claims ("pending", "rejected", "approved")
  + Admin views a claim
    * Admin views a list of trips
    * Admin approves the claim
- Employee sees claim with status "approved"

### Claim Rejection
- Admin visits mileage claim approvals page
  + Admin views a list of claims ("pending", "rejected", "approved")
  + Admin views a claim
    * Admin views a list of trips
    * Admin rejects the claim
    * Admin provides a rejection reason
- Employee sees claim with status "rejected" alongside the rejection reason
- Employee can now edit the claim

### Audit Log
- Admin views audit log
  + Table of all claims with the following columns:
    * Timestamp
    * Employee
    * Rate
    * Action ("Submitted", "Rejected", "Approved")
    * Actor
    * Comment
- Admin can export audit log CSV

## Rough issues planning
### Claim model
### Employer approvals front-end
#### Claims table
#### View claim modal
#### Claims table filter
### Employee claim response
### Audit log
#### Claims table
#### Claims table filter
#### Export to CSV
### Approvers
#### Role-based authorisation for employer portal
#### Mileage approver
#### Approver management front-end
### Approver heirarchy
#### Add employees to approvers
#### Approver teams management front-end

