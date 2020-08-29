//
//  CreateToken.swift
//  
//
//  Created by Tyler Milner on 8/28/20.
//

import Fluent

struct CreateToken: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Token.schema)
            .id()
            .field(Token.FieldKeys.userId, .uuid, .references(User.schema, .id))
            .field(Token.FieldKeys.value, .string, .required)
            .unique(on: Token.FieldKeys.value)
            .field(Token.FieldKeys.createdAt, .datetime, .required)
            .field(Token.FieldKeys.expiresAt, .datetime)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Token.schema).delete()
    }
}
