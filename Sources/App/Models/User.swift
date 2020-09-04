//
//  User.swift
//  
//
//  Created by Tyler Milner on 8/25/20.
//

import Vapor
import Fluent

final class User: Model {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: FieldKeys.username)
    var username: String
    
    @Field(key: FieldKeys.passwordHash)
    var passwordHash: String
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, username: String, passwordHash: String) {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
    }
}

extension User {
    
    enum FieldKeys {
        static let username: FieldKey = "username"
        static let passwordHash: FieldKey = "password_hash"
        static let createdAt: FieldKey = "created_at"
        static let updatedAt: FieldKey = "updated_at"
    }
}

extension User {
    
    convenience init(username: String, password: String) throws {
        // TODO: It would probably be better to salt the hash too using something like PBKDF2
        let passwordHash = try Bcrypt.hash(password)
        self.init(username: username, passwordHash: passwordHash)
    }
    
    func createToken() throws -> Token {
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        
        let expiration = calendar.date(byAdding: .month, value: 1, to: now)
        let value = [UInt8].random(count: 16).base64
        let userId = try requireID()
        
        return Token(userId: userId, value: value, expiresAt: expiration)
    }
}

// MARK: - DTO

extension User {
    
    struct Get: Content {
        let username: String
        let id: UUID
        let createdAt: Date?
        let updatedAt: Date?
    }
    
    func responseDTO() throws -> Get {
        let id = try requireID()
        return Get(username: username, id: id, createdAt: createdAt, updatedAt: updatedAt)
    }
}

// MARK: - ModelAuthenticatable

extension User: ModelAuthenticatable {
    
    static let usernameKey = \User.$username
    static let passwordHashKey = \User.$passwordHash
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: passwordHash)
    }
}
