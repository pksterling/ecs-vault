---
id: director-service-agreement
aliases: []
tags:
  - #type/debugging
  - #domain/batman
---
# Director service agreement
- Looks like the document was signed and amended at the same time or something
- I'm going to log in as an employer and see what happens
  + There is a button that says about signing the agreement, it says it's been
    emailed to tstewart
- The button is part of the onboarding actions in
  `app/models/actions/employer.rb`
  ```ruby
    def add_services_agreement_action
      docusign = ::DocusignEnvelope.find_by(id: employer.services_agreement_docusign_envelope_id)

      @actions << Action.new(
        type: 'services_agreement',
        title: 'Services Agreement',
        description: 'Please sign the services agreement before going any further.',
        completed: (docusign && docusign.completed?) || (!docusign && employer.scheme_live_at?) || false,
        group_type: 'services_agreement'
      )
    end
  ```
- The completed logic means that the docusign needs to be completed
- It was completed by one director, however at the same time, the signer was
  changed to another director so the status was changed to "corrected"
- I need to check with the BD whether the new signer needs to sign the document
  or whether the old signature is good
- I checked on pipedrive, the BD is #person/ellie-ridley
- I've sent ellie a message, waiting on a response
- Ellie said the original document is fine

## Result
- Marked the docusign as completed
```ruby
docusign.update(latest_event: "envelope-completed")
```
- Marked the issue as solved
