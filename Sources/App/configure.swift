import Fluent
import FluentPostgresDriver
import Vapor

enum ConfigurationError: Error {
    case noDatabaseHostname
    case noDatabasePassword
}

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
    // Parse the parameters out of Heroku's environment variable so that we can manually set the TLS configuration
    if let databaseURL = Environment.get("DATABASE_URL"), let postgresConfig = PostgresConfiguration(url: databaseURL) {
        let socketAddress = try postgresConfig.address()
        
        guard let hostname = socketAddress.hostname else { throw ConfigurationError.noDatabaseHostname }
        guard let password = postgresConfig.password else { throw ConfigurationError.noDatabasePassword }
        
        app.databases.use(.postgres(
            hostname: hostname,
            username: postgresConfig.username,
            password: password,
            database: postgresConfig.database,
            tlsConfiguration: .forClient(certificateVerification: .none) // Certificate verification must be disabled when connecting to Heroku's Postgres database
            ), as: .psql)
    // Database parameters are provided individually when running locally or via Docker
    } else {
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
    app.migrations.add(CreateDefaultUser(app: app))
    
    // Auto-migrate if we're running locally during development
    if app.environment == .development {
        try app.autoMigrate().wait()
    }
}

private func registerRoutes(_ app: Application) throws {
    // register routes
    try routes(app)
}
