import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    setupDatabase(app)
    try setupMigrations(app)
    try createAdminUserIfNecessary(app)
    
    try registerRoutes(app)
}

private func setupDatabase(_ app: Application) {
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)
}

private func setupMigrations(_ app: Application) throws {
    app.migrations.add(CreateStationConfig())
    app.migrations.add(CreateShow())
    app.migrations.add(CreateUser())
    app.migrations.add(CreateToken())
    try app.autoMigrate().wait()
}

private func createAdminUserIfNecessary(_ app: Application) throws {
    let defaultUsername = Environment.get("DEFAULT_USERNAME") ?? "admin" // TODO: Crash if no defaults are provided in a production scenario
    let defaultPassword = Environment.get("DEFAULT_PASSWORD") ?? "default" // TODO: Crash if no defaults are provided in a production scenario

    // TODO: It might be better to check whether or not the admin needs to be created via the existence of some file on the file system or a value in some sort of "initial setup" table
    let userCount = try User.query(on: app.db).count().wait()
    if userCount == 0 {
        // TODO: It would probably be better to salt the hash too using something like PBKDF2
        let passwordHash = try Bcrypt.hash(defaultPassword)
        let defaultUser = User(username: defaultUsername, passwordHash: passwordHash)
        try defaultUser.save(on: app.db).wait()
    }
}

private func registerRoutes(_ app: Application) throws {
    // register routes
    try routes(app)
}
