---
id: amend-incorrect-initial-odo-reading-snippet
aliases: []
tags:
  - #type/snippet
  - #domain/charge-scheme
  - #tech/rails
---
# Amend incorrect initial odo reading snippet
_[Link to zendesk ticket](https://electriccarschemehelp.zendesk.com/agent/tickets/73442?brand_id=5287733721373)_

Couldn't change on front-end due to autosubmission after the initial odo

Going to use the gist from the [playbook](https://www.notion.so/ECS-tech-playbook-15379f1dba184da483cb11a1c5264847?source=copy_link#27eb5f6a3cf0804bad3efbd8195b9606)

```ruby
charge_order = Dependencies['models.charge_orders'].find('593d2f00-fcf0-4736-94b1-cb9c3e3af208')
unit_of_work = UnitOfWork.new
current_initial = 5_233
correct_initial = 11_398
unit_of_work.run do
  charge_order.odometer_readings.where.not(reading_type: 'employee').order(:day).each do |odometer_reading|
    odometer_reading.mileage -= current_initial - correct_initial
    DocumentManualChange.log(odometer_reading, unit_of_work:)
    odometer_reading.save!
  end
end
nil
`
