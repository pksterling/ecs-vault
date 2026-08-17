---
id: posthog-consent-gdpr-notes
aliases: []
tags:
  - #cycle/june
  - #gdpr
parent: "[[employer-tracking-gdpr]]"
---
# posthog consent / cookies / gdpr
## Claude Summary
### opt-in/out + cookies
- posthog opt-in/opt-out = the **consent gate**, normally wired to a cookie
  banner
- lead + employee: `opt_out_capturing_by_default: true` and **never opt in** →
  capturing nothing, totally silent rn
- `opt_out` does **not** stop cookies dropping — only `cookieless_mode:
  'on_reject'` does (we're on posthog-js 1.382, too old)
- current state = worst of both: cookies drop, zero data captured

### two regimes - don't conflate
- **GDPR** = lawful basis to *process* personal data. consent is only 1 of 6 —
  legit interest / contract usually right
- **PECR / ePrivacy** = separate, needs **opt-in consent before non-essential
  cookies** (the banner). this is what bites posthog

### internal audit events (initiator_user_id)
- is personal data — id → email/name, + some payloads store email/name/phone
  *directly*
- **no consent needed** — legit interest (audit/security/accountability).
  consent would be the *wrong* basis, can't be withdrawable
- real gaps = kept **forever**, PII in payloads, not deleted/anon'd when admin
  removed, copied to reporting db
  + → retention + erasure problem, NOT a consent problem

### posthog tracking = more consent-sensitive
- 3 stacked issues:
  + cookies on device → **PECR consent** (no banner anywhere)
  + third party + transfer → needs **DPA** w/ posthog, no ref in repo
  + analytics harder to justify on legit interest than audit logging
- no cookie banner exists anywhere. **hotjar + GTM already fire unconsented** →
  gap predates posthog, bigger than tcs-167
- `consent_to_information_sharing` is unrelated — brokers/funders for finance

### email in posthog?
- for "understand usage / fix the right bits" → **email not needed**, fails data
  minimisation
- pseudonymous **distinct_id = admin id** + `employer_id`/`employer_name` props
  does the job
- behaviour tells you *what* to fix; email tells you *who* — different question

### pseudonymise → bigquery → resolve in-house
- good pattern = **pseudonymisation** (safeguard, art 25/32). posthog only ever
  sees id + cohort props
- but:
  + still **personal data**, still in gdpr scope — not anonymisation
  + cookie / PECR issue **untouched** by this
  + bigquery (our gcp) = in-house, fine. **claude / external llm = another
    processor** — keep re-id inside our env
  + re-id must be **access-controlled + purpose-limited**; erasure now spans
    posthog + export

### the line - reimburse-scheme outreach
- using re-id'd email to find users for reimburse = **different purpose** =
  **purpose limitation** breach / function creep
- emailing about another scheme = **direct marketing** → PECR → needs
  **consent** (or narrow soft opt-in, DPO call)
- pseudonymisation does **not** launder it — if intent is re-id-and-contact, the
  join *is* the processing needing a basis
- not covered by anything today; users never told at collection
- keep as **2 separate tracks**:
  + tcs-167 analytics: pseudonymous, no email, re-id for support/debug only —
    buildable now
  + reimburse outreach: separate initiative, **needs DPO + own lawful basis**
    before building

### todo
- [ ] loop in DPO / privacy on cookie-consent — covers hotjar + GTM too, not
  just posthog
- [ ] confirm privacy notice actually describes audit logging + analytics
- [ ] DPA w/ posthog + data residency (us vs eu)
- [ ] decide consent approach for employer portal before wiring opt_in

## Summary

### Current Posthog usage in employee and lead portals
- It's not being used for much, if anything
- `opt_out_capturing_by_default: true` means we're not capturing anything
- It may still be using cookies, which may require us to add the cookieless_mode

### Events
- I was concerned about gathering data, in the events, linked to personal
  details; however, legitmate interest covers this
- We may however have a problem with the data retention and erasure (personal
  details may still remain in event payloads after erasing a user)

### Consent
- We

---

## Related
- [[employer-tracking-consent-tiers]]
- [[tcs-167-posthog-identity-tracking]]
