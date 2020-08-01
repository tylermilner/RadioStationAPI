import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateStationConfig())
    
    // Create a StationConfig and add it to the database if one doesn't exist
    // TODO: Need to find some way to only run this code after the "migrate" command has been run. Maybe I should just store the config in a JSON file inside of the "Public" directory...
//    let existingStationConfig = try StationConfig.query(on: app.db).first().wait()
//    if existingStationConfig == nil {
//        // TODO: Get station config values from the environment
//        let stationConfig = StationConfig(stationWebsiteURL: "https://github.com/tylermilner/RadioStationAPI")
//        try stationConfig.save(on: app.db).wait()
//    }

    // register routes
    try routes(app)
}
