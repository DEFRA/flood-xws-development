# Notification subsystem

Components to let people and systems know there is alert information that need it — NOW.
Informing mechanisms let people obtain information when they feel like it.

A robust set of components that broadcast the Alert through various channels with fallbacks where neccessary.

Responsible for:

- Disseminating the Alert
- Recording delivery receipts

Dependencies
- Area subsystem (for the Targets/Distributions & intersectional queries)
- Contact subsystem (for the Contacts to send the alert to)

Solutions

- Notify/SES
- PG_Queue+Workers/SQS+Lambdas
- Twilio
- Twitter, Facebook, 
