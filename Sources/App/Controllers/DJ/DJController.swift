//
//  DJController.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import Vapor

/// Controls basic CRUD operations on `DJ`s.
final class DJController {
    
    /// Returns a list of all `DJ`s.
    func index(_ req: Request) throws -> Future<[DJ]> {
        return DJ.query(on: req).all()
    }
    
    /// Saves a decoded `DJ` to the database.
    func create(_ req: Request) throws -> Future<DJ> {
        return try req.content.decode(DJ.self).flatMap { dj in
            return dj.save(on: req)
        }
    }
    
    /// Deletes a parameterized `DJ`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(DJ.self).flatMap { dj in
            return dj.delete(on: req)
        }.transform(to: .ok)
    }
}