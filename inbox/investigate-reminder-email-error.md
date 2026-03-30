---
id: investigate-reminder-email-error
aliases: []
tags: []
---
# Investigate reminder email error

## Backtrace
app/services/charge_scheme/send_odometer_reading_reminder_email.rb:84 merge!
app/services/charge_scheme/send_odometer_reading_reminder_email.rb:84 data
app/services/charge_scheme/send_odometer_reading_reminder_email.rb:36 send_email
app/services/charge_scheme/send_odometer_reading_reminder_email.rb:22 block in call
app/lib/unit_of_work.rb:27 block in run
app/lib/unit_of_work.rb:26 run
app/services/charge_scheme/send_odometer_reading_reminder_email.rb:20 call
app/services/charge_scheme/send_odometer_reading_reminder_email.rb:9 perform
app/jobs/application_job.rb:20 block in <class:ApplicationJob>

## Parameters
[
  "7a0dc12e-9886-4e0c-9d75-7bca38196880",
  "follow_up"
]

## Sample exploration
- charge order: 7a0dc12e-9886-4e0c-9d75-7bca38196880
  + No readings, just two min fee corrections
- charge-order/30f3b0dc-dfe5-4988-b7f4-8f9023f2cec1
  + one initial reading from today

Error `no implicit conversion of nil into Hash`

```ruby
# app/services/charge_scheme/send_odometer_reading_reminder_email.rb:84 merge!
    def data
      # ...
      data.merge!(data_auto_submission) if charge_order.auto_odometer_submit_status_opted_in?
      # ...
    end

    def data_auto_submission # rubocop:disable Metrics/AbcSize
      return unless last_processed_non_auto_odometer_reading
```
`last_processed_non_auto_odometer_reading` is falsey so `data_auto_submission`
is nil which is causing the error
