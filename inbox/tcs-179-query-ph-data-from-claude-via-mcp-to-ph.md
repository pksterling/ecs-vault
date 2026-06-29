---
id: tcs-179-query-ph-data-from-claude-via-mcp-to-ph
aliases: []
tags:
  - #cycle/june
---
# Query PH data from claude (via MCP to PH)
_[Linear issue](https://linear.app/electriccarscheme/issue/TCS-179/query-ph-data-from-claude-via-mcp-to-ph)_

## Claude Summary

Medium-priority enabler: wire up a PostHog MCP so Claude can query portal engagement data directly in natural language (e.g. "which employers visited the mileage area this week"). 

Complements [[tcs-176-query-ph-data-on-ph]] (human-facing PostHog dashboards) by giving an ad-hoc, conversational query path. If data lands in BigQuery via [[tcs-168-export-posthog-data-to-bigquery]], that's an alternative query surface; this keeps the source in PostHog.
