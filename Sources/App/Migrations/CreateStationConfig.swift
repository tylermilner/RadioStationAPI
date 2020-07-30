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
            .field("station_website_url", .string, .required) // TODO: Find better way to manage "stringly" typed nature of database field keys
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(StationConfig.schema).delete()
    }
}
