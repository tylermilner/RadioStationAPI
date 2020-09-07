//
//  CreateStationStream.swift
//  
//
//  Created by Tyler Milner on 9/6/20.
//

import Fluent

struct CreateStationStream: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(StationStream.schema)
            .id()
            .field(StationStream.FieldKeys.name, .string, .required)
            .field(StationStream.FieldKeys.url, .string, .required)
            .field(StationStream.FieldKeys.qualityScore, .int, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(StationStream.schema).delete()
    }
}
