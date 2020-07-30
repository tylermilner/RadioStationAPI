//
//  StationConfigController.swift
//  
//
//  Created by Tyler Milner on 7/26/20.
//

import Fluent
import Vapor

// TODO: Create controllers for remaining models

struct StationConfigController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        // TODO: Test these routes to make sure they actually work...
        routes.group("config") { config in
            config.get(use: index)
            config.patch(use: update)
        }
    }
    
    func index(req: Request) throws -> EventLoopFuture<GetStationConfig> {
        return StationConfig.query(on: req.db)
            .first()
            .unwrap(or: Abort(.internalServerError))
            .map { $0.responseDTO }
    }
    
    func update(req: Request) throws -> EventLoopFuture<GetStationConfig> {
        let patch = try req.content.decode(PatchStationConfig.self)
        return StationConfig.query(on: req.db)
            .first()
            .unwrap(or: Abort(.internalServerError))
            .flatMap { stationConfig in
                stationConfig.patch(with: patch)
                return stationConfig.update(on: req.db)
                    .map { stationConfig.responseDTO }
            }
    }
}
