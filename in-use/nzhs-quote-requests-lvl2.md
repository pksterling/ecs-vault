---
id: nzhs-quote-requests-lvl2
aliases:
  - "QuoteRequests Lvl 2"
tags:
  - "#type/note"
  - "#domain/nzhs"
parent: "[[nzhs-quote-flow-lead]]"
---

# nzhs-quote-requests-lvl2

Transcription of Stefan's "Lead + Employee QuoteRequests" playbook deck (12 slides).
Source: [Google Slides](https://docs.google.com/presentation/d/1DUTR8lsqey-lTtYoTAzMx6X8rDy9Eq7jnm6uF-16Dho/edit)

## The grand plan: a new middleware model

`QuoteRequester` sits between the requester and the quote request. Employee and
NZHS::Lead both point at Person; Employee points at Employer, Lead has a linked
employer. QuoteRequest hangs off `quote_owner_id`, holding products[],
employee_address, # panels, # bedrooms, space for cylinder, space for heat pump.

## Areas of change

- Models
- Event Services
- ViewModels
- Controllers
- TSX + Mutations

## Models

```ruby
module NetZeroHomeScheme
  class QuoteRequestOwner < ApplicationRecord
    belongs_to :employee, optional: true
    belongs_to :lead, optional: true

    validate :must_have_employee_or_lead

    def show_supplier? = employee_id?

    def employer
      employee&.employer || lead.linked_employer
    end
  end
end

module NetZeroHomeScheme
  class QuoteRequest < ApplicationRecord
    self.ignored_columns += %w[employee_id]

    belongs_to :quote_request_owner, class_name: 'NetZeroHomeScheme::QuoteRequesterOwner'
  end
end
```

## Models - provisional quote proposal

```ruby
module NetZeroHomeScheme
  class ProvisionalQuote < ApplicationRecord
    validate :employee_is_nil_when_quote_owner_is_lead

    belongs_to :employee, class_name: Dependencies['models.employees'].name, optional: true

    def employee
      super || Employee.new(first_name: 'redacted').tap(&:readonly?)
    end
  end
end
```

## Event Services + View Models

View Models
- key'ed off `quote_request_owner_id` instead of `employee_id`

Event Services
- still key'ed off of `quote_request_id`
- still `from_employee_user_action`
- where we use employee internally, we now use `quote_request`

## Controllers

New BaseController
- always has corresponding `quote_request_owner_id`
- offers `quote_request_id` (scoped to correct owner)

```ruby
module NetZeroHomeScheme
  module QuoteRequests
    class BaseController < ::Api::Public::Employee::BaseController
      before_action :fetch_or_create_quote_request_owner

      attr_reader :current_quote_request_owner_id

      def quote_request_id
        @quote_request_id ||= ::NetZeroHomeScheme::QuoteRequest.where(
          quote_request_owner_id: current_quote_request_owner_id,
          id: params[:quote_request_id]
        ).pick(:id) || raise(quote_request_record_not_found)
      end

      private

      def fetch_or_create_quote_request_owner
        @current_quote_request_owner_id =
          ::NetZeroHomeScheme::QuoteRequests::FetchOrCreateQuoteRequestOwnerId
          .call(employee_id: current_employee.id)
      end

      # … def quote_request_record_not_found …
    end
  end
end
```

## TSX

Add a middleware context that contains:
- relevant employee/lead data as a standardised shape
- a collection of apis

Inspired by `LeadAppConfig`.

```ts
type NzhsQuoteRequestContextT = {
  api: {
    useUpdateNetZeroQuoteRequestEnergy: () => MutationResult<UpdateNetZeroQuoteRequestEnergyType['request']>,
    // ...
  },
  quote_owner: {
    firstName: string | null,
    lastName: string | null,
    addressId: string | null
  }
}
```

### api usage

Before
```tsx
const Energy = ({ quoteRequest, handleContinue, handleBack }: EnergyProps) => {
  const { mutate, isLoading } = useUpdateNetZeroQuoteRequestEnergy({ id: quoteRequest.id });
```

After
```tsx
const Energy = ({ quoteRequest, handleContinue, handleBack }: EnergyProps) => {
  const { api } = useContext(NzhsQuoteRequestContext);
  const { mutate, isLoading } = api.useUpdateNetZeroQuoteRequestEnergy({ id: quoteRequest.id });
```

## Questions

- Some suppliers require customer details for live pricing - do we send them redacted
  details instead? e.g. redacted@electriccarscheme.com. Maybe for Leighton to decide.

## Quirks

- YourDetails - may need some thinking
  - fetching the pre-filled data from lead or employee
  - address
- Address - we'll need a separate class, service and endpoint for that
- ProvisionalQuote - connected to Employee, what to do?
  - it's used for informing the suppliers, is this the magic for hiding lead-customer
    details from suppliers?
  - proposal: decouple and then intelligently pass it through
- Emails - we will not send them to lead

## Plan Proposal

- Stefan — get initial model + controllers out
- Peyton — migrate the event services and pages to support both (only test on employee)
- Dushan + Leighton — prevent showing customers supplier data; feedback from Lucas;
  prevent sending customer data to 3rd parties
