---
id: redact-personal-employee-data-script
aliases: []
tags:
  - #snippet
  - #rails
---
# redact-personal-employee-data-script
```ruby
# frozen_string_literal: true

# Redact all personal data for a given employee (GDPR right to erasure).
# Run via Rails console:
#
#   employee_id = 'YOUR-UUID-HERE'
#   load Rails.root.join('script/redact_employee_data.rb').to_s
#
# Uses update_columns throughout to bypass callbacks/validations and avoid
# triggering Pipedrive, Mailchimp, or other side-effects.

raise 'Set employee_id before loading this script' unless defined?(employee_id)

employee = Employers::Employee
  .includes(
    :person,
    :insurance_quote_configuration,
    :charge_card_delivery_address,
    person: %i[email_addresses phone_numbers],
    addresses: :address
  )
  .find(employee_id)

puts "Redacting personal data for employee #{employee_id}..."

# Person: name, DOB, NI number, job title
employee.person.update_columns(
  first_name: '[REDACTED]',
  last_name: '[REDACTED]',
  middle_names: nil,
  date_of_birth: nil,
  national_insurance_number: nil,
  job_title: nil
)
puts '  ✓ Person (name, DOB, NI)'

# Email addresses — must remain syntactically valid; use a unique placeholder
employee.person.email_addresses.each do |email|
  email.update_columns(value: "redacted-#{email.id}@redacted.invalid")
end
puts "  ✓ Email addresses (#{employee.person.email_addresses.size})"

# Phone numbers
employee.person.phone_numbers.each do |phone|
  phone.update_columns(value: '[REDACTED]')
end
puts "  ✓ Phone numbers (#{employee.person.phone_numbers.size})"

# Employee addresses (home address etc.)
employee.addresses.each do |ea|
  next unless ea.address

  ea.address.update_columns(
    address_line_1: '[REDACTED]',
    address_line_2: nil,
    address_line_3: nil,
    city: '[REDACTED]',
    postcode: '[REDACTED]',
    uprn: nil,
    latitude: nil,
    longitude: nil
  )
end
puts "  ✓ Addresses (#{employee.addresses.size})"

# Charge card delivery address (separate Address record, not an EmployeeAddress)
if employee.charge_card_delivery_address
  employee.charge_card_delivery_address.update_columns(
    address_line_1: '[REDACTED]',
    address_line_2: nil,
    address_line_3: nil,
    city: '[REDACTED]',
    postcode: '[REDACTED]',
    uprn: nil,
    latitude: nil,
    longitude: nil
  )
  puts '  ✓ Charge card delivery address'
end

# Employee table: salary, gender, payroll number, free-text fields
employee.update_columns(
  salary_cents: nil,
  gender: nil,
  payroll_number: nil,
  help_description: nil,
  how_did_you_hear_about_us: nil
)
puts '  ✓ Employee fields (salary, gender, payroll number)'

# Insurance quote configuration: driver names and DOBs
if employee.insurance_quote_configuration
  employee.insurance_quote_configuration.update_columns(
    main_driver_date_of_birth: nil,
    additional_driver_1_first_name: nil,
    additional_driver_1_last_name: nil,
    additional_driver_1_date_of_birth: nil,
    additional_driver_2_first_name: nil,
    additional_driver_2_last_name: nil,
    additional_driver_2_date_of_birth: nil,
    provisional_postcode: nil
  )
  puts '  ✓ Insurance quote configuration'
end

# DocuSign envelopes: signer name and email stored per-envelope.
# Query both ways: signer_id = employee.id (charge scheme), and via order_id (car scheme).
order_ids = Employers::Order.where(employee_id: employee_id).pluck(:id)
DocusignEnvelope
  .where(signer_id: employee_id)
  .or(DocusignEnvelope.where(order_id: order_ids))
  .update_all(
    signer_name: '[REDACTED]',
    signer_email: "redacted-#{employee_id}@redacted.invalid"
  )
puts '  ✓ DocuSign envelopes'

# External fields (e.g. SAML/SSO attributes that may include personal data)
ExternalField.where(entity_type: 'Employers::Employee', entity_id: employee_id).each do |field|
  field.update_columns(field_value: '[REDACTED]')
end
puts '  ✓ External fields'

puts "\nDone. All personal data for employee #{employee_id} has been redacted."
```
