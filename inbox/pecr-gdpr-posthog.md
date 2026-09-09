---
id: pecr-gdpr-posthog
aliases: []
tags:
  - "#type/"
parent: "[[planning-week-september-2026]]"
---

# pecr-gdpr-posthog
Re-exploring pecr + gdpr

## Data Use and Access Act 2025
[This act](https://www.gov.uk/government/publications/data-use-and-access-act-2025-factsheets/data-use-and-access-act-factsheet-pec-regulations) makes an important change to cookie compliance.
> New exceptions include using cookies or similar technologies to collect statistical
> information about how an organisation’s online services are used with the aim of
> improving the service.

This seems to mean that we don't need to use opt-in to use Posthog. 

## No consent required
- Aggregated tracking with Posthog doesn't breach GDPR and, due to the DUAA, doesn't
  require consent for cookie storage
- We just need to update our cookie policy to include posthog and the reasons we're using
  it (also probably link to it from the footer)
- Opt-outable

## Consent required
- Individualised, identifiable tracking
- Anything required for marketing

## Grey area
- Maybe could be argued that we don't need consent for session replay
- If it is completely anonymous, all inputs masked, and samples sessions - with a short
  retention period
- Then it is only being used for session analysis - we would need to make sure this is
  written into the privacy policy

## Related
- [[posthog-consent-gdpr-notes]]
- [[posthog-hotjar-final-notes]]
- [[employer-tracking-consent-tiers]]
- [[discussing-posthog-vs-hotjar]]
- [[reimburse-tracking-convo-blair-stefan]]
- [[employer-tracking-gdpr]]
- [[employer-portal-tracking-reporting]]
- [[track-employer-portal-usage]]
- [[more-gdpr-notes]]
- [[nzhs-employee-metrics]]
- [[employer-portal-tracking-options-comparison]]
