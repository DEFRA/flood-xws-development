# XWS Development

Contains docker-compose resources to allow the XWS services to be run locally.
It assumes the repository is checked out to sibling directory of the service repositories.

# Prerequisites

Node v12+

# Running the services

`docker-compose up --build`

Note: the `--build` option can be ommited if the service repos have not changed.

# Stopping the services

`docker-compose down --volumes`

Note: the `--volumes` option can be ommited to preserve the data between `down` commands
