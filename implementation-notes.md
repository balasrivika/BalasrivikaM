# Implementation Notes

## Data model

- `Event__c` looks up to `Client__c` and `Venue__c`.
- `Feedback__c` looks up to `Event__c` and `Client__c`.
- `EventVendor__c` is a junction object with master-detail relationships to `Event__c` and `Vendor__c`.

## Included automation

- `Client__c.Email_Valid_Address`: rejects email addresses that do not match the basic format described in the PDF.
- `VenueStatusHelper` and `EventVenueStatusTrigger`: marks a linked venue Reserved for Confirmed events and Available for Canceled events.
- `PreventDoubleBooking`: rejects two events at the same venue on the same date.
- `BatchCompleteEvents` and `ScheduleCompleteEvents`: marks past events Completed; schedule the class in Setup after deployment.

## Salesforce Setup items still to configure

The source PDF describes these in Setup but does not provide deployable metadata definitions for them:

- Record-triggered scheduled flow: send a client reminder three days before a Confirmed event.
- Event cancellation approval process and its email templates/actions.
- Feedback lookup filter matching Feedback Client to Event Client.
- Profiles, roles, users, permission set, org-wide defaults, and sharing rule.
- Lightning app, tabs, report folder, upcoming-events report, and dashboard.

Create and test these in the target org using the PDF as the functional checklist. Example people and user names in the PDF should be replaced with your own org's users; do not publish credentials or personal data in GitHub.

## Source-document inconsistencies and assumptions

- The PDF asks for Rejected as the final rejection status in one place but says the status reverts to Confirmed in its email text. This source uses the stated picklist value `Rejected`; confirm the intended business behavior with your instructor.
- The object creation instructions do not define every field's length, requiredness, or relationship delete behavior. Salesforce defaults are used where the PDF is silent.
- Field names are represented with standard Salesforce API names based on the labels in the PDF. If the org already has objects/fields with different API names, align metadata before deployment.
- The email validator is intentionally a simple format check and does not confirm that an address exists.
