//
//  CreateDefaultUser.swift
//  
//
//  Created by Tyler Milner on 9/14/20.
//

import Fluent
import Vapor

struct CreateDefaultUser: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let defaultUsername = Environment.get("DEFAULT_USERNAME") ?? "admin" // TODO: Crash if no defaults are provided in a production scenario
        let defaultPassword = Environment.get("DEFAULT_PASSWORD") ?? "default" // TODO: Crash if no defaults are provided in a production scenario
        
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
