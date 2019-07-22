# RadioStationAPI
A Swift Vapor project for a generic internet radio station API.

Based on the RAML API spec located [here](https://github.com/tylermilner/RadioStationAPISpec).

**🚧 This is a work in progress. 🚧**
* The general structure of the API has been defined, but is subject to change at any point.
* The endpoints have been stubbed out with static responses for now.
* A Postman collection is available in the `Postman` directory.

### Proudly hosted on [vapor.cloud](https://vapor.cloud)
**Base URL**

`https://radiostationapi-dev.vapor.cloud`

*Please note that no root route exists so don't expect to see anything if you copy/paste the base URL into your web browser.*

**Docs**

Documentation is available in `Public/docs/index.html` or can be viewed [online](https://radiostationapi-dev.vapor.cloud/docs/index.html).

### Endpoints

* GET /config
* POST /login
* GET /nowPlaying
* PUT /nowPlaying
* GET /shows
* POST /shows
* GET /djs
* POST /djs

 ## Environment

* Swift 5.x
* Vapor 3.x
* Docker

## Running the Project

The only real requirement is to have [Docker](https://www.docker.com) installed, since the container will pull in the relevant Swift/Vapor dependencies as well as the Postgres database.

To start the development container, execute the `startDockerDev.sh` script:

```bash
./startDockerDev.sh
```

You can also execute the underlying `docker-compose` command manually:

```bash
docker-compose --file docker-compose-dev.yml up --build
```

This will bring up the Postgres database and start an `api-dev` container that will house the Vapor app. The database starts automatically, but you must first attach to the `api-dev` container in order to compile and run the Vapor application:

```bash
docker attach <container_id>
```

**NOTE:** Use the `docker ps` command to obtain the container identifier for the `api-dev` container.

Once attached to the container, execute the `runVaporApp.sh` script to build and run the project:

```bash
./runVaporApp.sh
```

You can also perform the commands manually:

```bash
swift build
```

Then, start up the Vapor server:

```bash
swift run Run serve -b 0.0.0.0
```

Now you can access the API at `http://localhost:8080`.
