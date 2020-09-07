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
    
    @Timestamp(key: FieldKeys.expiresAt, on: .none)
    var expiresAt: Date?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, userId: User.IDValue, value: String, expiresAt: Date?) {
        self.id = id
        self.$user.id = userId
        self.value = value
        self.expiresAt = expiresAt
    }
}

// MARK: - FieldKeys

extension Token {
    
    enum FieldKeys {
        static let userId: FieldKey = "user_id"
        static let value: FieldKey = "value"
        static let expiresAt: FieldKey = "expires_at"
        static let createdAt: FieldKey = "created_at"
    }
}

// MARK: - DTO

extension Token {
    
    enum DTOError: Error {
        case missingExpiration
    }
    
    struct Get: Content {
        let token: String
        let expiresAt: Date
    }
    
    func responseDTO() throws -> Get {
        guard let expiresAt = expiresAt else { throw DTOError.missingExpiration }
        return Get(token: value, expiresAt: expiresAt)
    }
}

// MARK: - ModelTokenAuthenticatable

extension Token: ModelTokenAuthenticatable {
    
    static let valueKey = \Token.$value
    static let userKey = \Token.$user
    
    var isValid: Bool {
        guard let expiresAt = expiresAt else { return false }
        let now = Date()
        return now < expiresAt
    }
}
