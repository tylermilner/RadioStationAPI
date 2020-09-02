//
//  CreateUser.swift
//  
//
//  Created by Tyler Milner on 8/25/20.
//

import Fluent

struct CreateUser: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(User.schema)
            .id()
            .field(User.FieldKeys.username, .string, .required)
            .unique(on: User.FieldKeys.username)
            .field(User.FieldKeys.passwordHash, .string, .required)
            .field(User.FieldKeys.createdAt, .datetime, .required)
            .field(User.FieldKeys.updatedAt, .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(User.schema).delete()
    }
}
