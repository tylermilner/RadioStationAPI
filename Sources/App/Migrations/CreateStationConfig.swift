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
            .field(StationConfig.FieldKeys.streams, .array(of: .dictionary), .required)
            .field(StationConfig.FieldKeys.stationWebsiteURL, .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(StationConfig.schema).delete()
    }
}
