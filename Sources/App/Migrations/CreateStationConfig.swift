//
//  CreateStationConfig.swift
//  
//
//  Created by Tyler Milner on 7/29/20.
//

import Fluent

struct CreateStationConfig: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(StationConfig.schema)
            .id()
            // TODO: Implement 'streams' property once relationships are setup
            .field(StationConfig.Key.stationWebsiteURL, .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(StationConfig.schema).delete()
    }
}
