---
id: product-selection-qualification-flow-planning
aliases: []
tags:
  - #planning
  - #cycle/july
---
# Product Selection & Qualification Flow — Draft Issues
_[Linear project](https://linear.app/electriccarscheme/project/product-selection-and-qualification-flow-39d153b31e42/overview)_

## Context

Two separate quote tools (heat pumps and solar+battery) being merged into a single multi-product flow. Employee picks product(s), answers qualification questions, sees filtered list of eligible installers.

Existing code:
- Heat pump questions: `app/javascript/employee/forms/heat_pump/`
- Solar questions: `app/javascript/employee/forms/solar/`
- Pipedrive stage mapping already on `NetZeroPerks::HeatPump::Quote` and `NetZeroPerks::Solar::Quote`
- Admin pages: `app/javascript/admin/net_zero_home_scheme/*/quotes/`
- Only Installio configured as installer so far (no Make My House Green or Sunsave yet)

---

## Draft Issues

### Installer qualification config — 3pts (~2 days)

Requirements:
- Define installer config: name, products supported (`solar_panels`, `battery`, `heat_pump`), qualification rules (`accepts_flat_roof`, `accepts_conservation_area`, `accepts_listed_building`)
- Seed initial installers: Make My House Green (solar+battery, accepts all roof/conservation), Installio (heat pump, standard restrictions)
- Config in DB or YAML — adding a new installer must not require code changes

---

### Product selection screen — 2pts (~1.5 days)

Requirements:
- New route at `/employees/net-zero-home`
- 4 options: Solar + battery, Battery only, Heat pump only, Heat pump + solar + battery — matching approved wireframe
- Respects existing `solar.appEnabled` / `heatPump.appEnabled` feature flags
- On selection → quote creation + question flow

---

### Create quote on product selection — 3pts (~2 days)

Requirements:
- On product selection, create relevant quote(s) in DB (reuse/extend `CreateHeatPumpQuote` / `CreateSolarQuote`)
- Create Pipedrive deal in "Net Zero Home Scheme" pipeline at stage `net_zero_home_new_in`
- Combined selections create both quote records linked to same deal
- Run Pipedrive creation in background job

---

### Multi-product qualification question flow — 5pts (~3 days)

Requirements:
- Product selection determines which question sets load
- Solar path: details → property → roof → energy
- Heat pump path: details → property → space → home
- Combined: both sets, deduping shared questions (address, property type)
- Answers stored on quote as submitted
- Mid-flow disqualification (e.g. tenant → ineligible for heat pump) shows message
- Reuse existing forms — don't rewrite
- Extract step routing from each `Show.tsx` to shared step controller

---

### Installer qualification logic — 3pts (~2 days)

Requirements:
- Service: answers + product selection → eligible installers per product
- Rules read from installer config
- Example: flat roof → remove Installio from solar; conservation area → keep Make My House Green only
- Ineligible installers fully hidden
- If ALL installers disqualified for a product → needs product decision on dead-end/waitlist before implementing

---

### Qualification answers visible in admin — 2pts (~1.5 days)

Requirements:
- Extend admin Show pages for both products (`app/javascript/admin/net_zero_home_scheme/*/quotes/Show.tsx`)
- Fields: roof type, tenure, conservation area, outdoor/indoor space, annual energy spend
- Only show fields relevant to the product

---

## Total: ~18 points (~3 weeks solo)
