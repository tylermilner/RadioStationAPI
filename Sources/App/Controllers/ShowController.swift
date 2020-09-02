//
//  ShowController.swift
//  
//
//  Created by Tyler Milner on 8/21/20.
//

import Fluent
import Vapor

struct ShowController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        // TODO: Implmeent authentication for appropriate endpoints
        
        routes.group("shows") { shows in
            shows.get(use: indexAll)
            shows.post(use: create)
            
            shows.group(":id") { show in
                show.get(use: index)
                show.patch(use: update)
                show.delete(use: delete)
            }
        }
    }
    
    func indexAll(req: Request) throws -> EventLoopFuture<[Show.Get]> {
        return Show.query(on: req.db).all().mapEach { $0.responseDTO }
    }
    
    func index(req: Request) throws -> EventLoopFuture<Show.Get> {
        return Show.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { $0.responseDTO }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Show.Get> {
        let input = try req.content.decode(Show.Create.self)
        let show = Show(input: input)
        return show.save(on: req.db).map { show.responseDTO }
    }
    
    func update(req: Request) throws -> EventLoopFuture<Show.Get> {
        let patch = try req.content.decode(Show.Update.self)
        
        return Show.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { show in
                show.patch(with: patch)
                return show.update(on: req.db)
                    .map { show.responseDTO }
        }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Show.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .noContent)
    }
}
