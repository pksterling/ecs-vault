---
id: tcs-139f-claim-filtering
aliases: []
tags: []
---
# tcs-139f-claim-filtering

## What's the vibes?
- Looks good, not working

app/view_models/public/employers/mileage_claims_view_model.rb:68:in 'Enumerable#map'
rescue_from handled ActiveModel::MissingAttributeError (missing attribute 'reimburse_order_id' for ReimburseScheme::MileageClaim) - /Users/peyton.sterling/.local/share/mise/installs/ruby/3.4.9/lib/ruby/gems/3.4.0/gems/activemodel-8.1.3/lib/active_model/attribute.rb:259:in 'ActiveModel::Attribute::Uninitialized#value'
ActiveModel::MissingAttributeError: missing attribute 'reimburse_order_id' for ReimburseScheme::MileageClaim

- Leaving this for now
- Moving on to audit log
