import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Vapor.Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    // Configure a PostgreSQL database
    let databaseHostname = Environment.get("POSTGRES_HOSTNAME") ?? "localhost"
    let databasePort = Environment.get("POSTGRES_PORT").flatMap { Int($0) } ?? 5432
    let databaseUsername = Environment.get("POSTGRES_USER") ?? "postgres"
    let databaseDatabase = Environment.get("POSTGRES_DATABASE") ?? "postgres"
    let databasePassword = Environment.get("POSTGRES_PASSWORD") ?? "postgres"
    
    let databaseConfig = PostgreSQLDatabaseConfig(hostname: databaseHostname, port: databasePort, username: databaseUsername, database: databaseDatabase, password: databasePassword)
    services.register(databaseConfig)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: DJ.self, database: .psql)
    migrations.add(model: Show.self, database: .psql)
    services.register(migrations)
}
