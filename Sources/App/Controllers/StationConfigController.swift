//
//  StationConfigController.swift
//  
//
//  Created by Tyler Milner on 7/26/20.
//

import Fluent
import Vapor

struct StationConfigController: RouteCollection {
    
    private let config: PathComponent = "config"
    
    func boot(routes: RoutesBuilder) throws {
        // Unauthenticated routes
        routes.group(config) { config in
            config.get(use: index)
        }
        
        // Authenticated routes
        routes.group(Token.authenticator(), Token.guardMiddleware()) { tokenAuthenticated in
            tokenAuthenticated.group(config) { config in
                config.post(use: create)
                config.patch(use: update)
            }
        }
    }
    
    func index(req: Request) throws -> EventLoopFuture<StationConfig.Get> {
        return StationConfig.query(on: req.db)
            .first()
            .unwrap(or: Abort(.notFound))
            .map { $0.responseDTO }
    }
    
    func create(req: Request) throws -> EventLoopFuture<StationConfig.Get> {
        let input = try req.content.decode(StationConfig.Create.self)
        
        var stationConfig: StationConfig?
        
        return StationConfig.query(on: req.db)
            .all()
            .guard( { $0.isEmpty }, else: Abort(.badRequest))
            .flatMap { _ in
                let config = StationConfig(input: input)
                stationConfig = config
                
                return config.save(on: req.db)
            }
            .map { stationConfig?.responseDTO }
            .unwrap(or: Abort(.internalServerError))
    }
    
    func update(req: Request) throws -> EventLoopFuture<StationConfig.Get> {
        let patch = try req.content.decode(StationConfig.Update.self)
        return StationConfig.query(on: req.db)
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMap { stationConfig in
                stationConfig.patch(with: patch)
                return stationConfig.update(on: req.db)
                    .map { stationConfig.responseDTO }
            }
    }
}
