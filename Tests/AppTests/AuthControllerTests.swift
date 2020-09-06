//
//  AuthControllerTests.swift
//  
//
//  Created by Tyler Milner on 9/5/20.
//

@testable import App
import XCTVapor

class AuthControllerTests: AppXCTestCase {
    
    // MARK: - Properties
    
    private let authenticate = "authenticate"
    private let usersMe = "users/me"
    
    // MARK: - Tests
    
    func test_postAuthenticate_authenticationSuccess() throws {
        // Arrange
        let username = "test"
        let password = "test"
        
        let seed = try User(username: username, password: password)
        try seed.save(on: app.db).wait()
        
        // Act
        try app.test(.POST, authenticate, beforeRequest: { req in
            req.headers.basicAuthorization = BasicAuthorization(username: username, password: password)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            try XCTAssertContent(Token.Get.self, res, { token in
                
                let userId = try seed.requireID()
                let databaseTokens = try Token.query(on: app.db).all().wait()
                
                let userTokens = databaseTokens.filter { $0.$user.id == userId }
                XCTAssertEqual(userTokens.count, 1)
                
                let userToken = try XCTUnwrap(userTokens.first).responseDTO()
                XCTAssertEqual(token, userToken)
            })
        })
    }
    
    func test_postAuthenticate_authenticationFailure() throws {
        // Arrange
        let username = "test"
        let password = "test"
        
        let seed = try User(username: username, password: password)
        try seed.save(on: app.db).wait()
        
        // Act
        try app.test(.POST, authenticate, beforeRequest: { req in
            req.headers.basicAuthorization = BasicAuthorization(username: username, password: password + "invalid")
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .unauthorized)
        })
    }
    
    func test_getUsersMe_returnsUser() throws {
        // Arrange
        let username = "test"
        let password = "test"
        
        let seed = try User(username: username, password: password)
        try seed.save(on: app.db).wait()
        
        let token = try seed.createToken()
        try token.save(on: app.db).wait()
        
        // Act
        try app.test(.GET, usersMe, beforeRequest: { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token.value)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            try XCTAssertContent(User.Get.self, res, { user in
                let seedUser = try seed.responseDTO()
                XCTAssertEqual(user, seedUser)
            })
        })
    }
    
    func test_getUsersMe_authenticationFailure() throws {
        // Arrange
        let seed = try User(username: "test", password: "test")
        try seed.save(on: app.db).wait()
        
        // Act
        try app.test(.GET, usersMe, beforeRequest: { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: "token")
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .unauthorized)
        })
    }
}

extension Token.Get: Equatable {
    
    public static func ==(lhs: Token.Get, rhs: Token.Get) -> Bool {
        return lhs.token == rhs.token &&
            Calendar.current.isDate(lhs.expiresAt, equalTo: rhs.expiresAt, toGranularity: .nanosecond)
    }
}

extension User.Get: Equatable {
    
    public static func ==(lhs: User.Get, rhs: User.Get) -> Bool {
        return lhs.username == rhs.username &&
            lhs.id == rhs.id &&
            Calendar.current.isDate(lhs.createdAt ?? Date(), equalTo: rhs.createdAt ?? Date(), toGranularity: .nanosecond) &&
            Calendar.current.isDate(lhs.updatedAt ?? Date(), equalTo: rhs.updatedAt ?? Date(), toGranularity: .nanosecond)
    }
}
