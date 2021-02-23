//
//  SeedDefaultUser.swift
//  
//
//  Created by Tyler Milner on 9/14/20.
//

import Fluent
import Vapor

struct SeedDefaultUser: Migration {
    
    // MARK: - Properties
    
    private let defaultUsernameVariableName = "DEFAULT_USERNAME"
    private let defaultPasswordVariableName = "DEFAULT_PASSWORD"
    let app: Application
    
    // MARK: - Migration
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let defaultUsername = Environment.get(defaultUsernameVariableName) ?? "admin"
        let defaultPassword = Environment.get(defaultPasswordVariableName) ?? {
            // If no password is provided, only allow the default password to be used if running in a development environment
            if app.environment == .development {
                return "default"
            } else {
                fatalError("Missing value for environment variable '\(defaultPasswordVariableName)'")
            }
        }()
        
        do {
            let defaultUser = try User(username: defaultUsername, password: defaultPassword)
            return defaultUser.save(on: database)
        } catch {
            fatalError("Failed to create default user: \(error)")
        }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.eventLoop.makeSucceededFuture(())
    }
}
