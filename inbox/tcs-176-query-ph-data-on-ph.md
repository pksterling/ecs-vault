---
id: tcs-176-query-ph-data-on-ph
aliases: []
tags:
  - #cycle/june
---
# Query PH data (on PH)
_[Linear issue](https://linear.app/electriccarscheme/issue/TCS-176/query-ph-data-on-ph)_

## Claude Summary

Covers functional requirement #3 (reporting view) using PostHog's own analytics/dashboards rather than exporting data elsewhere. Stefan's preference is to keep the data in PostHog and build the engagement view there — which employers are engaging, how often, and what they do — before reaching for a BigQuery export.

This is the low-friction reporting option; [[tcs-168-export-posthog-data-to-bigquery]] is the heavier alternative if querying in-PostHog proves insufficient.
