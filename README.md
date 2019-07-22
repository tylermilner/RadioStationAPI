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

## Developing in Xcode

Starting up and attaching to a Docker container is good to do in order to check and make sure everything will work properly when deployed, but it's not a very convenient mechanism for day-to-day development. Ideally, you will want to open the repo, do a `swift package generate-xcodeproj` to generate the Xcode project (or `vapor xcode -y`), and then build and run in Xcode to test things out as you build features.

Since the `startDockerDev.sh` script uses the `docker-compose-dev.yml` to start up both the database and vapor app containers at once, it makes it impossible for you to use Xcode to connect to database container (since the database container's port `5432` is already assigned to the `api-dev` container). Instead, we need a way to start up just the PostgreSQL database container without starting the Vapor app's container. Execute the `startDockerDev_db-only.sh` script to do just that:

```bash
./startDockerDev_db-only.sh
```

Or, you can start just the database container manually using `docker-compose`:

```bash
docker-compose --file docker-compose-dev.yml up -d db
```

Now only the PostgreSQL database container will be started, which will allow you to build and run from Xcode.

### A Quick Note About Environment Variables

If you look at `configure.swift`, you'll see that `Environment.get()` is used to get parameters used to setup the PostgreSQL database. In case the environment variables are not present, we provide default values to fall back on. This allows us to build and run inside of Xcode very easily, since we can use the default values rather than worrying about setting up environment variables in Xcode.

When running the app inside our development Docker container, we provide the necessary environment variables in `docker-compose-dev.yml`. This allows the app to connect to the `"db"` hostname exposed by Docker when run from _inside_ of the Docker container, but fall back to the`"localhost"` hostname when run from _outside_ of the container (via Xcode). This way, we can easily do day-to-day development inside of Xcode, only using Docker to spin up the PostgreSQL database, and still have a convenient way to periodically make sure the app works properly in a Docker/Linux environment that we will eventually deploy to.
