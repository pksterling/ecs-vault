---
id: product-selection-qualification-planning-linear-draft
aliases: []
tags:
  - #type/draft-issue
  - #domain/nzhs
  - #cycle/july
parent: "[[product-selection-qualification-flow]]"
---
# Product Selection & Qualification Flow — Linear issue draft

- _[Linear project](https://linear.app/electriccarscheme/project/product-selection-and-qualification-flow-39d153b31e42/overview)_
- Plan: [[product-selection-qualification-claude-plan]]

Draft issues in my own style (User Stories / Tech Considerations / Acceptance Criteria,
time-based sizing via labels). Lead-only scope.

**Leighton's, not in this list:** Supplier config/data model, and the qualification logic
(answers → eligible Suppliers). I build the Lead + the question flow and hand off.

**Sequence:** 1 → 2 → 3 → 4. Total ≈ 2.5 weeks.

Open before creating in Linear:
- Point estimates as well as time-labels, or time-labels only?
- Priority: keep "No priority" (my usual) or set High to match the project?

---

## 1. Product selection screen · `label: 0.5 weeks` · [NZB-102](https://linear.app/electriccarscheme/issue/NZB-102/product-selection-screen)

**User Stories**
- As an employee, I can pick what I want a quote for — Battery, Solar (auto-adds battery),
  or Heat pump — as the first step.

**Tech Considerations**
- The solar entry route/component pattern already exists (`Employee.tsx`,
  `config/routes/api_public.rb`).
- Feature flags `solar.appEnabled` / `heatPump.appEnabled` already exist.
- 3 options, not the 4-option wireframe — confirmed w/ Lucas. Built to extend.

**Acceptance Criteria**
- [ ] Selection determines which question set loads
- [ ] Disabled products hidden by feature flag

## 2. Create lead + Pipedrive deal on selection · `label: 0.5 weeks` · [NZB-103](https://linear.app/electriccarscheme/issue/NZB-103/create-lead-pipedrive-deal-on-selection)

**User Stories**
- As the NZHS team, I get a lead in admin and a deal in Pipedrive the moment an employee
  selects a product.

**Tech Considerations**
- `EventServiceV2` pattern and the existing `CreateQuote` service are there as a reference.
  `Lead belongs_to :employee`, records the product selection.
- Pipedrive deal creation already exists via
  `app/services/net_zero_perks/solar/event_handlers/CreatePipedriveDealHandler` — pipeline
  "Net Zero Home Scheme", stage `net_zero_home_new_in`, run in a background job.
- Leighton derives Quotes/Products/Suppliers from the Lead downstream — no quote records here.

**Acceptance Criteria**
- [ ] Lead created on selection
- [ ] Pipedrive deal created in NZH pipeline @ `net_zero_home_new_in`
- [ ] Runs off the request cycle (bg job)

## 3. Multi-product qualification question flow · `label: 1 week` · [NZB-104](https://linear.app/electriccarscheme/issue/NZB-104/multi-product-qualification-question-flow)

**User Stories**
- As an employee, I only answer questions relevant to the product(s) I picked, and shared
  questions aren't asked twice.

**Tech Considerations**
- The solar and heat-pump step forms already exist (`forms/solar/`, `forms/heat_pump/`);
  step routing currently lives in each `Show.tsx`.
- Solar path: details → property → roof → energy. Heat pump: details → property → space →
  home. Shared questions: address, property type.
- Save-per-step pattern (Formik + Yup + `dry-validation`) as in the solar flow; answers land
  on the Lead.
- `AlertIneligible` component exists for mid-flow disqualification.

**Acceptance Criteria**
- [ ] Each path asks only relevant questions
- [ ] Combined path dedupes shared questions
- [ ] Answers stored on the Lead as submitted

## 4. Qualification answers visible in admin · `label: 1 day` · [NZB-105](https://linear.app/electriccarscheme/issue/NZB-105/qualification-answers-visible-in-admin)

**User Stories**
- As the NZHS team, I can see an employee's answers on the lead in admin.

**Tech Considerations**
- Admin Show pages exist at `app/javascript/admin/net_zero_home_scheme/*/quotes/Show.tsx`.
- Answer fields: roof type, tenure, conservation area, indoor/outdoor space, annual spend.

**Acceptance Criteria**
- [ ] Answers visible on the lead in admin
- [ ] Only product-relevant fields shown
