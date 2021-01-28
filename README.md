# XWS Development

Contains docker-compose resources to allow the XWS services to be run locally.
It assumes the repository is checked out to sibling directory of the service repositories.

# Prerequisites

Node v12+

# Environment variables

As per [12 Factor principles](https://12factor.net/config) application config is stored in environment variables (env vars). For ease of local development each service should have a `.env` file in its root folder. Starter `.env` files for local development for each service are held in the [https://github.com/NeXt-Warning-System/config]() repository.

Notes:
* The specific env vars required for each service are defined in the readme for that service
* Env var values defined in the docker-compose service override those defined in the `.env` file. See the override of the DB env var as an example.
* `.env` files should not be committed to the service repository.
* `.env` files should not be used in production.

# Running the services

`docker-compose up --build`

Each of the services will then be available at http://localhost:{port} (see docker-compose for which port corresponds to which service)

Note: the `--build` option can be omitted if the service repos have not changed.

# Stopping the services

`docker-compose down --volumes`

Note: the `--volumes` option can be omitted to preserve the data between `down` commands

# Running with node debugging enabled

This is an example for how to run with debugging enabled for the notification-api service. The 2nd docker-compose file overrides the values in the first (and so on for subsequent docker-compose files). The debug file starts node using the `--inspect-brk` flag and exposes the debugging port.

To debug any of the other services then create and use an equivilent service specific file. Note that if you need to run debugging for more than one sevice the port mapping will need to use a different external port in the mapping.

`docker-compose -f docker-compose.yml -f docker-compose-notification-api-debug.yml up`

For more details on hooking various debugging clients to the debugging session see [https://nodejs.org/en/docs/guides/debugging-getting-started/]()
