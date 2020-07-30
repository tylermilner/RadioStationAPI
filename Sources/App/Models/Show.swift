//
//  Show.swift
//  
//
//  Created by Tyler Milner on 7/26/20.
//

import Fluent
import Vapor

// MARK: - Fluent

final class Show: Model {
    static let schema = "shows"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "facebook_url")
    var facebookURL: String?
    
    @Field(key: "twitter_url")
    var twitterURL: String?
    
    @Field(key: "website_url")
    var websiteURL: String?
    
    @Field(key: "image_url")
    var imageURL: String
    
    @Field(key: "hosts")
    var hosts: String
    
    @Field(key: "location")
    var location: String
    
    @Field(key: "show_time")
    var showTime: String
    
    @Field(key: "start_time")
    var startTime: String
    
    @Field(key: "end_time")
    var endTime: String
    
    @Field(key: "summary")
    var summary: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, facebookURL: String? = nil, twitterURL: String? = nil, websiteURL: String? = nil, imageURL: String, hosts: String, location: String, showTime: String, startTime: String, endTime: String, summary: String) {
        self.id = id
        self.name = name
        self.facebookURL = facebookURL
        self.twitterURL = twitterURL
        self.websiteURL = websiteURL
        self.imageURL = imageURL
        self.hosts = hosts
        self.location = location
        self.showTime = showTime
        self.startTime = startTime
        self.endTime = endTime
        self.summary = summary
    }
}

// MARK: - DTO

// TODO: We could namespace these as something like `Show.Request` and `Show.Response` (see https://theswiftdev.com/a-generic-crud-solution-for-vapor-4/)

struct GetShow: Content {
    let id: UUID
    let name: String
    let facebookURL: String?
    let twitterURL: String?
    let websiteURL: String?
    let imageURL: String
    let hosts: String
    let location: String
    let showTime: String
    let startTime: String
    let endTime: String
    let summary: String
}

struct CreateShow: Content {
    let name: String
    let facebookURL: String?
    let twitterURL: String?
    let websiteURL: String?
    let imageURL: String
    let hosts: String
    let location: String
    let showTime: String
    let startTime: String
    let endTime: String
    let summary: String
}
