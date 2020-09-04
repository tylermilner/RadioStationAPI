//
//  AuthController.swift
//  
//
//  Created by Tyler Milner on 8/28/20.
//

import Fluent
import Vapor

// TODO: Write tests for this
struct AuthController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        // TODO: This uses "basic" auth, which doesn't quite match the spec
        routes.group(User.authenticator()) { passwordAuthenticated in
            passwordAuthenticated.post("authenticate", use: authenticate)
        }
        
        routes.group(Token.authenticator()) { tokenAuthenticated in
            tokenAuthenticated.group("users") { users in
                users.get("me", use: getUser)
            }
        }
    }
    
    func authenticate(req: Request) throws -> EventLoopFuture<Token.Get> {
        let user = try req.auth.require(User.self)
        let token = try user.createToken()
        
        return token.save(on: req.db).flatMapThrowing {
            try token.responseDTO()
        }
    }
    
    func getUser(req: Request) throws -> User.Get {
        try req.auth.require(User.self).responseDTO()
    }
}
