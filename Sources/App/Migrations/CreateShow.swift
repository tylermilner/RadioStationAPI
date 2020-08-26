//
//  CreateShow.swift
//  
//
//  Created by Tyler Milner on 8/22/20.
//

import Fluent

struct CreateShow: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Show.schema)
        .id()
        .field(Show.FieldKeys.name, .string, .required)
        .field(Show.FieldKeys.facebookURL, .string)
        .field(Show.FieldKeys.twitterURL, .string)
        .field(Show.FieldKeys.websiteURL, .string)
        .field(Show.FieldKeys.imageURL, .string, .required)
        .field(Show.FieldKeys.hosts, .string, .required)
        .field(Show.FieldKeys.location, .string, .required)
        .field(Show.FieldKeys.showTime, .string, .required)
        .field(Show.FieldKeys.startTime, .string, .required)
        .field(Show.FieldKeys.endTime, .string, .required)
        .field(Show.FieldKeys.summary, .string, .required)
        .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Show.schema).delete()
    }
}
