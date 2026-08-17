---
id: reimburse-employee-onboarding-planning
aliases: []
tags:
  - #planning
parent: "[[reimburse-employee-onboarding]]"
---
# Reimburse Employee Onboarding Planning
_[Linear project](https://linear.app/electriccarscheme/project/reimburse-mvp-employee-onboarding-69121489367a/overview)_

Draft issues: [[draft-issue-bulk-reimburse-order-creation]]

## Claude Key Findings

- `reimburse_scheme_reimburse_orders` table and
  `ReimburseScheme::ReimburseOrder` model are fully built (strategy, fuel_type,
  engine_size_band, VRM, activated_on, etc.) but there is **no creation
  pathway** — no service, no admin controller, no employer portal UI
- The analogous script is `ChargeScheme::ChargeQuotes::BulkCreate` — a
  tab-delimited CSV CRAP script for charge scheme onboarding; best reference for
  a reimburse equivalent
- Vehicle lookup (CapHPI via `FindElectricCarFromVrm`) only resolves EVs — but
  CapHPI already returns fuel type + engine data for any vehicle; the gap is
  purely that nothing consumes it for non-EVs. No DVLA integration needed — a
  new service alongside `FindElectricCarFromVrm` would close this.
- Strategy assignment is fully deterministic from two inputs:
  `vehicle_ownership` (personal/company) + `fuel_type` (electric/petrol/diesel)
  — the mapping already exists in `ReimburseOrder::STRATEGY_TO_PERMITTED_CONFIG`
- AFR orders additionally require `engine_size_band`; AMAP orders require
  `business_mileage_in_first_year`
- No Linear issues have been created under this project yet

## What is the business need?

Employers need to onboard drivers onto the Reimburse scheme. Today each driver's
reimbursement strategy (AMAP / AER / AFR) must be selected manually by someone
who knows the rules, which causes errors and doesn't scale. The goal is to
automate strategy assignment from vehicle registration + ownership type.

The strategy rules are deterministic:
- **AMAP** — personal vehicle, any fuel
- **AER** (flat/dual/actual) — company vehicle, electric
- **AFR** — company vehicle, petrol or diesel (engine size band also required)

## What is the current state?

The `reimburse_scheme_reimburse_orders` table and
`ReimburseScheme::ReimburseOrder` model are complete — all fields exist
(strategy, fuel_type, engine_size_band, vehicle_ownership,
car_registration_number, activated_on, etc.) and the strategy validation logic
is in place.

However, there is **no creation pathway** at all:
- No `CreateReimburseOrder` service
- No admin controller for reimburse orders
- No employer portal UI for creating orders (only viewing trips exists)

The only analogous thing is `ChargeScheme::ChargeQuotes::BulkCreate` — a CRAP
script that creates charge scheme orders from a tab-delimited CSV.

For vehicle lookup, CapHPI (`FindElectricCarFromVrm`) can return a `cap_id` →
look up `Cars::Car` in the DB. This only works for electric cars currently.
Non-EV lookups (needed for AMAP/AFR) have no automated path.

## Is there a way I can do nothing?

Yes — continue with manual DB inserts / one-off admin scripts. Fine while
volumes are tiny, but it's error-prone and means ops involvement for every
onboarding.

## What would an SE solution look like?

1. Employer portal: CSV upload screen (employer uploads drivers), server parses
rows, looks up VRM via CapHPI for EVs (and DVLA/another API for ICE/PHEV),
assigns strategy, creates orders
2. Alternatively: per-driver form in employer portal — employer enters reg +
ownership, system auto-assigns strategy + shows it before submit
3. Admin CRAP script as a backstop for edge cases

## What is the absolute bare minimum?

A CRAP script (`ReimburseScheme::BulkCreate` modelled on
`ChargeScheme::ChargeQuotes::BulkCreate`) that takes a CSV with: employee email,
first name, last name, vehicle reg, vehicle_ownership (personal/company),
fuel_type, engine_size_band, activated_on — and creates reimburse orders. No VRM
lookup, no auto-assignment — caller specifies strategy inputs. This gets us from
"no path" to "ops can onboard a batch".

## What can be done in a week?

CRAP script as above, plus basic strategy auto-assignment from the CSV inputs
(no VRM lookup needed — `STRATEGY_TO_PERMITTED_CONFIG` mapping already exists in
the model). Also: create `ReimburseScheme::CreateReimburseOrder` service (needed
by anything downstream).

## What can be done in three weeks?

- The above CRAP script
- VRM-based strategy auto-assignment for EVs (CapHPI already integrated) —
  removes need for caller to specify fuel_type/strategy for electric cars
- A basic employer portal "add driver" form (single driver at a time) — employer
  enters reg + personal/company, sees assigned strategy, confirms
- Possibly: bulk CSV upload in the employer portal

Still a gap: non-EV VRM lookup (AMAP/AFR drivers). Would need DVLA or to expand
CapHPI usage — worth scoping separately.

## How long would the perfect solution take?

6–8 weeks:
- Full employer portal CSV import with progress feedback
- VRM lookup for all vehicle types (EV + ICE)
- Driver self-service onboarding flow (driver enters own reg)
- Rate display / confirmation step before submit
- Admin review / override tools

## What do I think is realistic in the current time-frame?

Given the project is in Backlog with no issues yet: start with the CRAP script +
`CreateReimburseOrder` service in week 1 (unblocks ops immediately), then add
the employer portal single-driver form in weeks 2–3. VRM auto-assignment for EVs
can come in the same sprint; non-EV lookup is a follow-up.

## What questions do I need to ask #person/matt?

- What volume of drivers are being onboarded right now — is a CRAP script
  actually sufficient short-term, or is ops bandwidth the bottleneck?
- Is VRM auto-assignment required for MVP, or can employers specify fuel type +
  ownership themselves?
- Do we need non-EV VRM lookup (DVLA/other) for MVP, or are the initial
  employers EV-only?
- Should the employer portal have a CSV upload or a per-driver form first?
- For AER sub-type (flat/dual/actual) — who decides which AER variant an
  employer uses, and is that employer-level or driver-level?

Employer default aer
repplicate what's on charge scheme for the aer

---

## Related
- [[draft-issue-bulk-reimburse-order-creation]]
