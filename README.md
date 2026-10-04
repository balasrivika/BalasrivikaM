# EventForce Management System

Salesforce DX source starter assembled from the college implementation PDF. It contains the core custom-object data model, the email validation rule, Apex automation, and tests. Salesforce flows, approval processes, profiles, sharing, app navigation, reports, and dashboards are declarative setup items; the guide below records these rather than claiming they are deployable metadata.

## Contents

- `force-app/main/default/objects`: Event, Client, Vendor, Venue, Feedback, and Event Vendor objects and fields.
- `force-app/main/default/classes`: venue status helper, past-event batch/scheduler, and tests.
- `force-app/main/default/triggers`: venue status and double-booking triggers.
- `force-app/main/default/validationRules`: Client email format validation.
- `manifest/package.xml`: metadata manifest.
- `docs/implementation-notes.md`: configuration checklist and assumptions from the source PDF.

## Deploy to a Salesforce org

1. Install Salesforce CLI and VS Code with the Salesforce Extension Pack, then sign in to a Salesforce Developer Edition org.
2. Open this project folder in VS Code.
3. In the terminal, run `sf project deploy start --source-dir force-app --target-org YOUR_ORG_ALIAS`.
4. Review deployment errors and configure the remaining declarative items using `docs/implementation-notes.md`.

This repository is source code and metadata; it does not create a Salesforce account or include any student/org credentials or business records. Test in a scratch or Developer org before using it elsewhere.

## Upload to GitHub in the browser

1. Sign in to GitHub and choose **New repository**.
2. Name it `EventForce-Salesforce` and create the empty repository.
3. Choose **Add file → Upload files** and upload the contents of this folder (not the ZIP file if you want GitHub to show the files directly).
4. Add a commit message such as `Add EventForce Salesforce project` and click **Commit changes**.

The included ZIP is convenient for download/extraction. To upload directly from GitHub, extract it first and select the project files.
