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
        .field(Show.Key.name, .string, .required)
        .field(Show.Key.facebookURL, .string)
        .field(Show.Key.twitterURL, .string)
        .field(Show.Key.websiteURL, .string)
        .field(Show.Key.imageURL, .string, .required)
        .field(Show.Key.hosts, .string, .required)
        .field(Show.Key.location, .string, .required)
        .field(Show.Key.showTime, .string, .required)
        .field(Show.Key.startTime, .string, .required)
        .field(Show.Key.endTime, .string, .required)
        .field(Show.Key.summary, .string, .required)
        .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Show.schema).delete()
    }
}
