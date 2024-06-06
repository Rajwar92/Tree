# Editions dialog

We use editions dialog in 2 cases:
1. During authentication:
If it's the first active device, or new user, then the editions dialog will appear for user to select their edition to start using BW.
2. Triggered from "More" menu:
When user want to change their edition to different one, they can trigger "Change Edition" option from "More" menu, and select a new edition.

=> Although there are quite a few common sub-components, there is different logic in both types of editions dialog, so it's better to separate them to avoid confusion. We can also extract those sub-components to re-use in both types.

## Comparison diagrams
There are diagrams comparing both types to make the difference easier to understand and spot:

### Diagrams for finding the initial edition
![Dialog Editions pre-select logic.drawio.png](/.attachments/Dialog%20Editions%20pre-select%20logic.drawio-0e062c8f-c6bd-4eb5-9b58-1d473c91acbf.png)

### Diagrams for the dialog components layout
![Dialog Editions Layout.drawio.png](/.attachments/Dialog%20Editions%20Layout.drawio-ea25ae47-d55d-4a7d-889f-de65339e6f2e.png)

## Common diagrams
Apart from differences, in editions dialog, user can or cannot change edition based on whether user is student, or whether the organization allows them to change edition. This logic is the same for both types.

### Diagram for user permission to change edition
![Dialog Editions CanUserChangeEdition.drawio.png](/.attachments/Dialog%20Editions%20CanUserChangeEdition.drawio-bf85cdd1-3bb3-419e-8b93-ea00a303d332.png)




