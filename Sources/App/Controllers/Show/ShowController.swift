//
//  ShowController.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import Vapor

/// Controls basic CRUD operations on `Show`s.
final class ShowController: RouteCollection {
    
    // MARK: - RouteCollection
    
    func boot(router: Router) throws {
        router.group("shows") { router in
            router.get(use: getAll)
            router.post(use: create)
            router.delete(Show.parameter, use: delete)
        }
    }
    
    /// Returns a list of all `Show`s.
    func getAll(_ req: Request) throws -> Future<[Show]> {
        return Show.query(on: req).all()
    }
    
    /// Saves a decoded `Show` to the database.
    func create(_ req: Request) throws -> Future<Show> {
        return try req.content.decode(Show.self).flatMap { show in
            return show.save(on: req)
        }
    }
    
    /// Deletes a parameterized `Show`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Show.self).flatMap { show in
            return show.delete(on: req)
        }.transform(to: .ok)
    }
}
