# XWS Development

XWS system overview documentation for developers

![Overview](xws-overview.jpg)

[Link to diagram](https://app.diagrams.net/#G1S5-dDxH7QjJ753tOx-tl4uQMDv3Vqmlj)

XWS is comprised of 4 main sub-systems, decoupled with a central data and event hub.

## Alert subsystem

The [Alert subsystem](/subsystems/alert/readme.md) is set of components that together allow for the creating and publishing alerts by internal EA / Defra Staff.

Components

- [alert-web](https://github.com/DEFRA/flood-xws-alert-web) An internal web interface based on the GDS Design System

## Notification subsystem

Components to let people and systems know there is alert. Informing mechanisms let people obtain information when they feel like it.

A robust set of components that broadcast the Alert through various channels with fallbacks where neccessary.

Responsible for:

- Disseminating the Alert
- Recording delivery receipts

Solutions

- Notify/SES/SNS/SQS
- Twilio (voice)
- Twitter, Facebook

## Area subsystem

An area is a place where Alerts can be issued. An area describes a geographical location to which the alert info applies.

The [Area subsystem](/subsystems/area/readme.md) is a set of components that together allow for the management and publication of the set of areas.

Responsible for:

- Managing target data including geospatial areas
- Publishing versioned datasets

Components

- [area-api](https://xws-area-api-sandbox.london.cloudapps.digital/documentation) An internal Web API providing geospatial endpoints.

## Contact subsystem

A contact is a person who is registered to receive alerts. The [Contact subsystem](/subsystems/contact/readme.md) is the set of components that facilitate contact registration and maintenance. 

Components

- [contact-web](/subsystems/contact/web/readme.md) An external public-facing web interface based on the GDS Design System


### Terminology
- Alert - An alert is the core element of the systems. Its purpose, its source and its status, as well as a unique identifier for the current alert and links to any other, related alerts. An may be used alone for acknowledgements, cancellations or other system functions. An alert is something that can be issued.

- Area - An area is somewhere an alert can be issued for

- Message - A message is an alert as it it transmitted to a subscriber (e.g. SMS, System Messages)

- Warning - A warning is a verb and is used to give notice, advice, or intimation to (a person, group, etc.) of danger or harm



Get flood warnings

https://xws-contact-web-sandbox.london.cloudapps.digital

 

For the public site, you should be able to follow the initial journey, register multiple addresses/areas, and add email/mobile and landline contact information. You should also be able to sign in again (using the link on the home page)

 

Currently, the one-time passwords are configured to be sent using GOV.UK Notify. Until we set our account live, we are limited to who we can send messages to. I have added the following for you both - please let me know if these are not correct:

 

Zane: zane.gulliford@environment-agency.gov.uk & 07775973155

Claire: claire.kemp@environment-agency.gov.uk & 07770704941

 

Claire - I think we should complete the GOV.UK Notify "Set to live" so we can share this with the wider team. (As you can see from the screenshot attached, we only have one more step to complete).

 

(Landline contact registration should also work but I haven't been able to test as I don't have a landline. I know we said we'll probably remove it for private beta though.)

 

 

Manage flood warnings

https://xws-alert-web-sandbox.london.cloudapps.digital

 

You should both be able to sign-in to this site using your Active Directory credentials. You are both set up as Administrator role.

 

Currently you can see the national overview and browse area/regions. You can also issue alerts and warnings using a very basic form that contains just the message headline, body. If it's a flood warning area, you also need to specify the type (flood warning or severe flood warning). Once you issue the alert/warning - it's live, there's no approval process.

 

Alert hosting

Live flood alerts and warnings are hosted at these URLs:

 

CAP XML Feed: https://xws-alert-sandbox-files.s3.eu-west-2.amazonaws.com/alerts/alerts.xml

 

JSON Feed: https://xws-alert-sandbox-files.s3.eu-west-2.amazonaws.com/alerts/alerts.json

 

These public URLs would be used by partners/downstream systems in a "polling" fashion. They could check every few seconds to see if they have been updated. This is common in alerting/feed systems. These URLs are backed by Amazon S3 which is ideal for this use case. It provides high SLAs and guarantees of durability (11 x "9's").

 

(For production, we would configure a "nice" short domain. Something like https://defra.floods.com/alerts/alerts.xml or https://xws.com/alerts/alerts.xml)

 

Polling & PubSub

Polling is fine for most use cases, but we can do better. We have something called PubSub (publish/subscribe). Currently this is done via Amazon SNS (Simple Notification Service) and allows consumers to "subscribe" to events and get notified (via a web service or "Web hook" call) when something happens. The something here could be anything but, in our world, it would be when an alert or warning is issued. But it wouldn't be limited to just alerts, we intend to use the same Pub Sub approach to inform downstream systems of Target Area updates and other important events within the GFW systems.

 

While both PubSub and Polling approaches are valid and necessary, this second approach is better than polling in that it provides realtime notification of system events.

 

 

 

Finally, it's worth pointing out that the two worlds are not yet joined up. Meaning if you register interest in an address/area in the citizen app, you won't yet receive an email or SMS if you issue an alert for that area in the manage app. This is because the notification subsystem (or the "send and receive warnings") isn't deployed. Like I said in this afternoon's meeting, we have a couple of options around how we will do this e.g. AWS Pinpoint vs a "DIY" approach with message queues and GOV.UK Notify. We have lots of code around these options but to stand something up in a sandbox environment will take a little more effort and will also be subject to the sandbox constraints mentioned above. It's not particularly difficult though, it's just a dumb message sending engine really. Hopefully, you can see where it will fit in though - using the same PubSub approach as I explained above. Basically, it will just be another consumer (subscriber) of the "Alert Issued" event that we raise once the alert is live on the above URLs. When it receives this event, the engine will jump into life and start disseminating the SMS/Emails to those contacts who have subscribed to the target area.

 

 

Anyway, hopefully this gives some food for thought. Any problems please get in touch.