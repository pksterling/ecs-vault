---
id: seed-pipedrive-users-with-matching-plugsurfing-users
aliases: []
tags:
  - #snippet
---

# Seed pipedrive users with matching plugsurfing users

```ruby
ActiveRecord::Base.transaction do
  # Pipedrive person IDs start at 1 and overlap with existing records
  pipedrive_person_id_index = PipedrivePerson.all.ids.max + 1

  5.times do |index|
    FactoryBot.create(:pipedrive_person,
                      id: pipedrive_person_id_index,
                      first_name: "pipe#{index + 1}",
                      email: Faker::Internet.email(name: "pipe#{index + 1}"))
    pipedrive_person_id_index += 1
  end

  5.times do |index|
    pipedrive_person = FactoryBot.create(:pipedrive_person,
                                         id: pipedrive_person_id_index + index,
                                         first_name: "pipesurf#{index + 1}",
                                         email: Faker::Internet.email(name: "pipesurf#{index + 1}"))
    pipedrive_person_id_index += 1
    FactoryBot.create(:plugsurfing_user,
                      :no_employee,
                      email: pipedrive_person["data"]["email"].first["value"],
                      first_name: pipedrive_person["data"]["first_name"],
                      last_name: pipedrive_person["data"]["last_name"])
  end

  p "success"
end
```
