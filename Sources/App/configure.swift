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
    
    // Create a StationConfig and add it to the database if one doesn't exist
    let existingStationConfig = try StationConfig.query(on: app.db).first().wait()
    if existingStationConfig == nil {
        // TODO: Get station config values from the environment
        let stationConfig = StationConfig(stationWebsiteURL: "https://github.com/tylermilner/RadioStationAPI")
        try stationConfig.save(on: app.db).wait()
    }

    // register routes
    try routes(app)
}
