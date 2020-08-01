# RadioStationAPI

A simple API for an internet radio station, built using the server-side Swift framework, Vapor.

## Getting Started

Assuming the following development environment:

* macOS 10.15.x
* Xcode 12.x
* Docker Desktop

### Running the App

Open the `Package.swift` in Xcode to have it automatically pull in the project dependencies (Vapor and other related Swift packages).

#### Starting the PostgreSQL Database

Before building and running, we need to start up a PostgreSQL database that the app can use. You could, of course, install PostgreSQL to your development machine, but that gets kind of messy. A better way is to utilize Docker to run PostgreSQL inside of a continer that your Vapor app can connect to.

Run the following command to start up a PostgreSQL instance inside of a Docker container, mapping port `5432` inside the container to port `5432` on your local/host machine:

```bash
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d -p 5432:5432 postgres
```

This should download and start the PostgreSQL container. Verify it's running using the following command:

```bash
docker ps
```

You should see the PostgreSQL container running.

You can stop the container using the following command:

```bash
docker stop some-postgres
```

Restart the container using the `docker start` command:

```bash
docker start some-postgres
```

You can also view a list of all started & stopped docker containers using the following command:

```bash
docker ps -a
```

**TODO**: How to avoid needing to completely remove the container in the above scenario? Is there a way we can just start up the saved container?

Once your PostgreSQL docker container is up and running, you should be able to connect to it using a PostgreSQL client like Postico.

#### Running the Vapor App

Before building and running, there's one more thing we need to take care of - setting up environment variables. Set the following environment variables in the project's scheme:

* DATABASE_HOST = localhost
* DATABASE_USERNAME = postgres
* DATABASE_PASSWORD = mysecretpassword
* DATABASE_NAME = postgres

Now you should be able to build and run the app within Xcode.

When building and running for the first time, the app will immediately crash with the following error:

```
Fatal error: Error raised at top level: server: relation "station_configs" does not exist (parserOpenTable)
```

This is because migrations need to be explicitly handled with a Vapor 4 app.

In order to perform the migration, you need to run your app with the `migrate` argument. Run the following command to build the app:

```bash
swift build
```

Then, run the migration command:

```bash
swift run Run migrate
```

That command will likely fail until you've exported your environment variables to your terminal session:

```bash
export DATABASE_HOST=localhost
export DATABASE_USERNAME=postgres
export DATABASE_PASSWORD=mysecretpassword
export DATABASE_NAME=postgres
```

Running the `migrate` command should succed this time with the following output:

```bash
Migration successful
```

Now you should be able to build & run your app from within Xcode.
