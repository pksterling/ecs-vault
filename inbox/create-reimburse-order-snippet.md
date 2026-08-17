---
id: create-reimburse-order-snippet
aliases: []
tags:
  - #snippet
  - #rails
---
# create-reimburse-order-snippet

```ruby
employee = Employers::Employee.find_by!(email: 'EMAIL@EXAMPLE.COM')

# Car id from his ECS (non-TCS) order — sanity check you get exactly one live order
orders = employee.orders.not_cancelled.includes(quote: :car)
orders.map { [_1.id, _1.quote.car&.id, _1.quote.car&.model_description] } # eyeball this
car = orders.sole.quote.car

# His last processed odometer reading from the off-boarded charge order, if you want it as the starting point
charge_order = employee.charge_orders.order(:created_at).last
last_reading = charge_order&.odometer&.last_processed
last_reading&.then { [_1.day, _1.mileage] } # => [date, mileage] — eyeball this too

service = ReimburseScheme::CreateReimburseOrder.from_system_action(
  key: employee.id,
  event_data: {
    employee_id: employee.id,
    car_id: car.id,
    strategy: 'AER_actual',
    vehicle_ownership: 'company',
    fuel_type: 'electric',
    engine_size_band: nil,
    car_registration_number: 'KS26PLU',
    activated_on: Date.current,             # or last_reading.day to backdate to his last TCS reading
    business_mileage_in_first_year: nil,
    initial_odometer_reading: last_reading&.mileage # or set manually if nil
  }
)

service.valid?  # check before calling
service.errors  # if not
service.call
```

---

## Related
- [[draft-issue-bulk-reimburse-order-creation]]
