# Alert subsystem

The [Alert subsystem](/alert/readme.md) is set of components that together allow for the creating and publishing alerts.

Responsible for:

- Manage the Drafting, Approving and Publishing of Alerts to a *feed*
- Managing *Alert Templates* and CAP related data (sender, sources etc.)

Users

- Internal EA / Defra Staff

Dependencies
- Target subsystem (for the Targets/Distributions)

Components

- [alert-web](/alert/web/readme.md) An internal web interface based on the GDS Design System


Test

DATABASE_URL=postgresql://postgres:xwspostgres@xws-contact-db-ds.cezam6iy9y1a.eu-west-1.rds.amazonaws.com node alert/db/test/test.js