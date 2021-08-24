#!/bin/bash

set -e

copilot app init flood-xws-contact
copilot env init --app flood-xws-contact --name test --profile "$AWS_PROFILE" --default-config

copilot svc init --app flood-xws-contact --name xws-db --svc-type "Backend Service" --dockerfile ../flood-xws-db/Dockerfile
copilot svc deploy --app flood-xws-contact --env test --name xws-db

copilot svc init --app flood-xws-contact --name xws-contact-api --svc-type "Backend Service" --image postgrest/postgrest
copilot svc deploy --app flood-xws-contact --env test --name xws-contact-api

copilot svc init --app flood-xws-contact --name xws-area-api --svc-type "Backend Service" --dockerfile ../flood-xws-area-api/Dockerfile
copilot svc deploy --app flood-xws-contact --env test --name xws-area-api

copilot svc init --app flood-xws-contact --name xws-subscription-api --svc-type "Backend Service" --dockerfile ../flood-xws-subscription-api/Dockerfile
copilot svc deploy --app flood-xws-contact --env test --name xws-subscription-api

copilot svc init --app flood-xws-contact --name xws-contact-web --svc-type "Load Balanced Web Service" --dockerfile ../flood-xws-contact-web/Dockerfile --port 80
copilot svc deploy --app flood-xws-contact --env test --name xws-contact-web

