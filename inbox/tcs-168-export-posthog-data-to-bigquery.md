---
id: tcs-168-export-posthog-data-to-bigquery
aliases: []
tags:
  - #cycle/june
---
# Export Posthog data to BigQuery
_[Linear issue](https://linear.app/electriccarscheme/issue/TCS-168/export-posthog-data-to-bigquery)_

## Goals

- As a metabase user, I can query posthog from metabase
- As an ECS claude user I can query posthog data to answer questions such as "Which employers have >10 cars on Charge Scheme and have visited the mileage area"

## Tech Considerations

More info on main ticket

## Claude Summary

Medium-priority. Duplicate PostHog data into the data warehouse so it can be joined with existing ECS data (e.g. fleet size) in Metabase and queried by Claude — the kind of cross-source question PostHog alone can't answer.

Stefan flagged PostHog supports native [BigQuery batch exports](https://posthog.com/docs/cdp/batch-exports/bigquery) on higher paid tiers, with the caveat that keeping the tables in sync may be an issue. Only worth doing if in-PostHog reporting ([[tcs-176-query-ph-data-on-ph]]) can't answer the warehouse-join questions.
