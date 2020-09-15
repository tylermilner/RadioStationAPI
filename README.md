# RadioStationAPI

A simple API for an internet radio station, built using the server-side Swift framework, Vapor.

## Getting Started

For a barebones development environment setup, you will need the ability to compile & run Swift code as well as spin up Docker containers. Realistically though, you will probably also want the ability to use Xcode as your IDE to develop the app. The following is an example of a recommended development environment setup for Mac:

* macOS 10.15.x
* Xcode 11.x
* Docker (via [Docker Desktop app](https://hub.docker.com/editions/community/docker-ce-desktop-mac))

### Developing in Xcode

Open the `Package.swift` in Xcode to have it automatically start pulling in the project dependencies (Vapor and other related Swift packages).

#### Starting the PostgreSQL Database

Before building and running, we need to start up a PostgreSQL database that the app can use. You could, of course, install Postgres to your development machine, but that gets kind of messy in my opinion. A better way is to utilize Docker to run Postgres inside of a container that you can start and stop at will. This more closely mirrors how the production deployment setup will work using Docker and helps to avoid problems you might encounter when working on multiple apps at a time.

Use the `docker run` command to start up a Docker container, using the [`postgres` docker image](https://hub.docker.com/_/postgres):

```bash
docker run --name radiostationapi-postgres -e POSTGRES_USER=vapor_username -e POSTGRES_PASSWORD=vapor_password -e POSTGRES_DB=vapor_database -d -p 5432:5432 postgres
```

A quick rundown on the flags in the above command, in case you're new to Docker (like me):

* `--name`
    * The name that you want to assign to the container, in this case "radiostationapi-postgres"
* `-e`
    * Environment variables passed into the container, in this case we're providing environment variables that match up to the default values used in `configure.swift`
* `-d`
    * Start the container in detached mode
*  `-p`
    * Maps port `5432` inside of the container to port `5432` on your local/host machine, which allows your Vapor app to connect to the database

Verify the container is running using the `docker ps` command:

```bash
docker ps
```

You should see the Postgres container running.

You can stop the container using the `docker stop` command:

```bash
docker stop radiostationapi-postgres
```

Instead of executing the above `docker run` command again (which will result in an error), you can restart the container using the `docker start` command:

```bash
docker start radiostationapi-postgres
```

You can also view a list of all started & stopped docker containers using the `-a` flag on the `docker ps` command:

```bash
docker ps -a
```

If you want a fresh start, you can also remove the container using the `docker rm` command:

```bash
docker rm radiostationapi-postgres
```

This will remove the container and all data stored within its database from your system. You will then need to start up the container again using the `docker run` command.

Once your Postgres docker container is up and running, you should be able to connect to it using a PostgreSQL client like [Postico](https://eggerapps.at/postico/).

#### Running the Vapor App

With your PostgreSQL database running via Docker, you should now be able to build & run your app from within Xcode.

## Deploying Using Docker

Deployment can be managed using `docker-compose`, which will use the `Dockerfile` to create an image of the application and the `docker-compose.yml` to bring the application and database containers to life.

### Deploying Using `docker-compose`

The steps in the [Vapor documentation on Docker](https://docs.vapor.codes/4.0/deploy/docker/) can be followed to bring the containers up using `docker-compose`.

Even though the `docker-compose.yml` defines the `db` container as a dependency to the `app` container, the database container will need a little more time to start up before the migrations can be run. Start up the `db` container first:

```bash
docker-compose up db
```

Then you can start the `migrate` and `app` containers together:

```bash
docker-compose up migrate app
```

Bringing the containers down:

```bash
docker-compose down
```

If you make changes, you can rebuild the image before running the `docker-compose up` commands again:

```bash
docker-compose build
```

### Additional Docker Tips

List Docker images:

```bash
docker images
```

If you need to free up some disk space or want to completely reset Docker to a fresh state (remove images, containers, build cache, etc.), you can use the `docker system prune` command to free up space:

```bash
docker system prune -a
```

You can also clean things up manually. List all Docker volumes:

```bash
docker volume ls
```

Prune Docker volumes:

```
docker volume prune
```

Docker will only prune volumes that are not currently in use by running or stopped containers. Use `docker container ls` to see all running containers. You can use `docker container ls -a` to see stopped containers as well.

## References

References that have helped me on my server-side Swift journey:

* [Vapor documentation](https://docs.vapor.codes/4.0/)
* [A generic CRUD solution for Vapor 4](https://theswiftdev.com/a-generic-crud-solution-for-vapor-4/)
* [Get started with the Fluent ORM framework in Vapor 4](https://theswiftdev.com/get-started-with-the-fluent-orm-framework-in-vapor-4/)
* [Server side Swift projects inside Docker using Vapor 4](https://theswiftdev.com/server-side-swift-projects-inside-docker-using-vapor-4/)
* [How to Build a To-Do List Back End With Vapor 4 and Swift](https://medium.com/better-programming/vapor-4-todo-backend-5035c9d7e295)
* [How to do integration testing on a Vapor server](https://losingfight.com/blog/2018/12/16/how-to-do-integration-testing-on-a-vapor-server/)
* [Vapor 4 Authentication: Getting Started](https://www.raywenderlich.com/9191035-vapor-4-authentication-getting-started)
* [All about authentication in Vapor 4](https://theswiftdev.com/all-about-authentication-in-vapor-4/)
