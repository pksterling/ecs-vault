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

- Admin can view a list of pending claims
- Admin can view a claim
- Admin can reject a claim with a comment
- Admin can approve a claim
- Employee can view a claim
- 
- Employee can

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
