---
id: tcs-139d-claim-rejection
aliases: []
tags:
  - #task
  - #cycle/april
parent: "[[tcs-139-employer-approvals]]"
---
# tcs-139d-claim-rejection

_Note: Rejecting a claim duplicates the trips, leaving the original trips as
rejected, and marking the duplicated trips as previously rejected (with a link
to the rejected claim)_

#person/stefan suggested a separate status, however I like the idea of a
rejected_claim column

_ the above is actually in a different task [[tcs-139e-employee-resubmission]]

## #person/stefan PR comments
- [x] Add a validation that ensures rejection reason is only populated when the
  status is rejected
- [x] adding "other statuses" to the api spec
- [x] use matchers for service spec
- [x] Use formik for the rejection response
- [x] Use rejection status to conditionalise the rendering of the rejection response
- [-] Rename defaultRejecting
- [x] Remove persistence of rejcetion reason
