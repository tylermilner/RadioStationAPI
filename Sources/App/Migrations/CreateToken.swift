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
            // TODO: Should "user_id" be required (also maybe "expires_at")? See https://docs.vapor.codes/4.0/authentication/#user-token
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
