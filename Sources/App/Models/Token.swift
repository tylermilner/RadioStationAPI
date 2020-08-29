//
//  Token.swift
//  
//
//  Created by Tyler Milner on 8/28/20.
//

import Fluent
import Vapor

final class Token: Model {
    static let schema = "tokens"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: FieldKeys.userId)
    var user: User
    
    @Field(key: FieldKeys.value)
    var value: String
    
    @Field(key: FieldKeys.expiresAt)
    var expiresAt: Date?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, userId: User.IDValue, token: String, expiresAt: Date?) {
        self.id = id
        self.$user.id = userId
        self.value = token
        self.expiresAt = expiresAt
    }
}

extension Token {
    
    enum FieldKeys {
        static let userId: FieldKey = "user_id"
        static let value: FieldKey = "value"
        static let expiresAt: FieldKey = "expires_at"
        static let createdAt: FieldKey = "created_at"
    }
}
