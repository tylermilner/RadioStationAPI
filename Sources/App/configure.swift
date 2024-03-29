import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    try setupDatabase(app)
//    try setupMiddleware(app)
    try setupMigrations(app)
    
    try registerRoutes(app)
}

private func setupDatabase(_ app: Application) throws {
    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
        // Certificate verification must be disabled when connecting to Heroku's Postgres database
        postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
        
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else {
        // Database parameters are provided individually when running locally or via Docker
        app.databases.use(.postgres(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
            password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
            database: Environment.get("DATABASE_NAME") ?? "vapor_database"
            ), as: .psql)
    }
}

//private func setupMiddleware(_ app: Application) throws {
//    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
//}

private func setupMigrations(_ app: Application) throws {
    // Create tables
    app.migrations.add(CreateStationConfig())
    app.migrations.add(CreateShow())
    app.migrations.add(CreateUser())
    app.migrations.add(CreateToken())
    
    // Seed with default data
    app.migrations.add(SeedDefaultUser(app: app))
    
    // Auto-migrate if we're running locally during development
    if app.environment == .development {
        try app.autoMigrate().wait()
    }
}

private func registerRoutes(_ app: Application) throws {
    // register routes
    try routes(app)
}
