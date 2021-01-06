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
