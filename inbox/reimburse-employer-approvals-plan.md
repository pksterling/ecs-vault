---
id: reimburse-employer-approvals-plan
aliases: []
tags:
  - #planning
  - #cycle/april
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

## BRRRAAAAAAINSSS!!
### What happens if a claim cannot be resubmitted after rejection?
- Employee will need to submit a new claim
- Where do they see the rejection reason?
- Do they see multiple rejection reasons or just the last one?
- Are the trips removed from the rejected claim?
- Maybe:
  + Admin rejects claim with a reason
  + Employee sees trips, now marked as rejected, with the reason

### What happens if a claim can be resubmitted after rejection?
