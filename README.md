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

# Running all the services along with the backing services

`docker-compose up --build`

Each of the services and backing services will then be available at http://localhost:{port} (see docker-compose for which port corresponds to which service) 

Note: the `--build` option can be omitted if the service repos have not changed.

# Running a subset of the services 

`docker-compose up [service...]`

This will start the specified services and any dependant services (e.g. `docker-compose up contact-web` or `docker-compose up db message-broker`). The service names come from the docker compose file. This is not expected to be a common scenario.

# Stopping the services

`docker-compose down --volumes`

Note: the `--volumes` option can be omitted to preserve the data between `down` commands

# Running tests for a service

`docker compose run [--volumes ...] {service-name} npm test`

e.g. `docker compose run --volumes ./contact-web-reports:/usr/src/app/reports contact-web npm test`

Note: the volume mount is optional, needs to be created before running the command and makes the report
available after the test run

# Running with node debugging enabled

This is an example for how to run with debugging enabled for a number of services. The 2nd docker-compose file overrides the values in the first (and so on for subsequent docker-compose files). The debug compose file starts node using the `--inspect-brk` flag, exposes the debugging port, bind mounts the source code directory and runs the app using `nodemon` to allow code to be edited outside the container and reloaded on any change. This is to allow for a low friction development experience.

`docker-compose -f docker-compose.yml -f docker-compose-debug.yml up`

This starts a number of services with the `--inspect` option. See docker-compose-debug.yml for implementation details.

## Debugging using Chrome DevTools for Node

After running docker-compose, open a tab in Chrome with the URI `chrome://inspect` and click on 'Open dedicated DevTools for Node'. Note: the debug session for each service runs on a different port and these will need adding as a connection in the connections tab of the DevTools for Node.

## Debugging using Visual Studio Code

Add the following attach configuration to your `.vscode/launch.json` file within the service workspace (in this case the parent directory for the three services). This will attach VS Code for debugging to the container debug session for the service specified in the configuration name. Note that the ports defined for each service come from the port mapping as defined in `docker-compose-debug.yml`. As further services are added they will need their own configuration to be added. Finally, it is possible to launch more than one debug configuration at a time so, for example, it is possible to debug both contact-web and notification-api simultaneously.

```
{
    "name": "Attach: contact-web",
    "port": 9227,
    "request": "attach",
    "skipFiles": [
        "<node_internals>/**"
    ],
    "type": "node",
    "localRoot": "${workspaceFolder}/contact-web",
    "remoteRoot": "/usr/src/app"
},
{
    "name": "Attach: alert-web",
    "port": 9228,
    "request": "attach",
    "skipFiles": [
        "<node_internals>/**"
    ],
    "type": "node",
    "localRoot": "${workspaceFolder}/alert-web",
    "remoteRoot": "/usr/src/app"
},
{
    "name": "Attach: notification-api",
    "port": 9229,
    "request": "attach",
    "skipFiles": [
        "<node_internals>/**"
    ],
    "type": "node",
    "localRoot": "${workspaceFolder}/notification-api",
    "remoteRoot": "/usr/src/app"
}
```

For more details on tighter integration between node, docker and vs code see [https://code.visualstudio.com/docs/containers/overview]() 

## Debugging using other clients

For more details on hooking other debugging clients to the debugging session see [https://nodejs.org/en/docs/guides/debugging-getting-started/]().
