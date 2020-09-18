import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    setupDatabase(app)
//    try setupMiddleware(app)
    try setupMigrations(app)
    
    try registerRoutes(app)
}

private func setupDatabase(_ app: Application) {
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tlsConfiguration: .forClient(certificateVerification: .none)
    ), as: .psql)
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
    app.migrations.add(CreateDefaultUser())
    
    // Auto-migrate if we're running locally during development
    if app.environment == .development {
        try app.autoMigrate().wait()
    }
}

private func registerRoutes(_ app: Application) throws {
    // register routes
    try routes(app)
}
