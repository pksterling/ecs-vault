---
id: product-selection-qualification-claude-plan
aliases: []
tags:
  - #type/planning
  - #domain/nzhs
  - #cycle/july
parent: "[[product-selection-qualification-flow]]"
---
# product-selection-qualification-claude-plan

## Context

Two separate quote tools (heat pumps and solar+battery) being merged into a single
multi-product flow. Employee picks product(s), answers qualification questions, sees a
filtered list of eligible Suppliers.

**Scope boundary:** this project ends *before* the final quote page. I build the **Lead**
(product selection + answers) and the question flow. **Leighton owns** deriving the Quotes
from the Leads (`Quote → Product → Supplier`), the **Supplier config/data model**, and the
**qualification logic** (answers → eligible Suppliers). I hand the Lead off.

Existing code to point at:
- Solar steps/forms: `app/javascript/employee/forms/solar/`, `components/solar/quote/`
- Heat pump steps/forms: `app/javascript/employee/forms/heat_pump/`
- Wizard pattern: Formik per step, Yup + `dry-validation`, save-per-step (see `solar/quote/Show.tsx`)
- Pipedrive deal handler: `app/services/net_zero_perks/solar/event_handlers/CreatePipedriveDealHandler`
- Admin pages: `app/javascript/admin/net_zero_home_scheme/*/quotes/`
- Only Installio configured as a Supplier so far (no Make My House Green yet)

## Decisions (from Lucas / Leighton check-ins)

- **Product selection = 3 options**: Battery, Solar (auto-selects battery), Heat pump.
  Built for adding more products later. (Not the 4-option wireframe.)
- **Data model:** my half is only the `Lead`. Leighton owns `Quote → Product → Supplier`,
  derived downstream from the Lead.
- **Create the Lead only** on product selection — the Lead is the thing that creates the
  Pipedrive deal. No quote/product records created here (we don't know the quote until the
  final page).
- Answers stored as hard-coded columns on `leads` (all flows, one table). No configurables table.
- Ineligible Suppliers **fully hidden** on the final list.
- Multi-product = separate Supplier results, shown together (Leighton's side).
- Can cut the heat+solar+battery combined flow if needed. Can cut admin smushing if needed.
- **Leighton's, not mine:** Supplier config (`accepts_flat_roof`, `accepts_conservation_area`,
  `accepts_listed_building`, products supported) and the qualification logic.

---

## Route

```
/employees/net-zero-home            → <ProductSelection />   pick product(s)
/employees/net-zero-home/lead/new   → <LeadCreate />         creates Lead, redirects
/employees/net-zero-home/lead/:id   → <LeadShow />           wizard (?step=…)
```

Backend (lead-centric, no quotes):
```
POST  /api/public/net_zero/leads              create Lead + Pipedrive deal
GET   /api/public/net_zero/leads/:id
PATCH .../leads/:id/details property roof energy space home
```

## Wizard (existing components to point at)

- Formik per step, Yup + `dry-validation`, save-per-step. Solar/heat-pump step components
  already exist.
- Shared step controller — step routing currently lives in each `Show.tsx`, driven by
  selected product(s):
  - Solar:     details → property → roof → energy
  - Heat pump: details → property → space → home
  - Combined:  union, dedup shared steps (address, property type)
- All answers persist onto the `Lead`.
- Mid-flow disqualification shows inline message (`AlertIneligible` exists).

## Data model (my half only)

```ruby
class Lead
  belongs_to :employee
  # product selection + all question answers
end
```

`Quote → Product → Supplier` = Leighton's engine, downstream. I hand off, I don't create them.

## Services

- `CreateLead` — creates Lead + fires Pipedrive-deal handler (bg job), stage `net_zero_home_new_in`.
- Per-step `UpdateLead…` services storing answers.
- Admin Show page surfaces the Lead's answers (roof, tenure, conservation, space, spend),
  relevant fields per product.
- _(Leighton: Supplier config + `QualificationService` — answers → eligible Suppliers.)_

## Flow

```
/net-zero-home ──pick product(s)──▶ create Lead (+ Pipedrive deal, bg job)
      ▼
  /lead/:id → shared step controller (solar or heat-pump question set)
      ▼
  answers saved to Lead
      ▼
  ══ hand off Lead to Leighton's quote engine ══
      ▼  (Leighton: qualification → Quote → Product → Supplier, final comparison page)
```

## Open questions

- If ALL Suppliers disqualified for a product → dead-end / waitlist / NZHS handoff?
  (Leighton's qualification branch, but a product decision either way.)
- Confirm conservation/listed columns with Lucas (Leighton's Supplier config).

---

## Related
- [[product-selection-qualification-meeting-leighton]]
