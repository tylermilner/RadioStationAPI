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

// MARK: - PATCH

extension Show {
    
    func patch(with patch: Show.Update) {
        name = patch.name ?? name
        facebookURL = patch.facebookURL ?? facebookURL
        twitterURL = patch.twitterURL ?? twitterURL
        websiteURL = patch.websiteURL ?? websiteURL
        imageURL = patch.imageURL ?? imageURL
        hosts = patch.hosts ?? hosts
        location = patch.location ?? location
        showTime = patch.showTime ?? showTime
        startTime = patch.startTime ?? startTime
        endTime = patch.endTime ?? endTime
        summary = patch.summary ?? summary
    }
}

// MARK: - DTO

extension Show {
    
    struct Create: Content {
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
    
    struct Get: Content {
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
    
    struct Update: Content {
        let name: String?
        let facebookURL: String?
        let twitterURL: String?
        let websiteURL: String?
        let imageURL: String?
        let hosts: String?
        let location: String?
        let showTime: String?
        let startTime: String?
        let endTime: String?
        let summary: String?
    }
    
    convenience init(input: Create) {
        self.init()
        
        self.name = input.name
        self.facebookURL = input.facebookURL
        self.twitterURL = input.twitterURL
        self.websiteURL = input.websiteURL
        self.imageURL = input.imageURL
        self.hosts = input.hosts
        self.location = input.location
        self.showTime = input.showTime
        self.startTime = input.startTime
        self.endTime = input.endTime
        self.summary = input.summary
    }
    
    var responseDTO: Get {
        return Get(id: id!, name: name, facebookURL: facebookURL, twitterURL: twitterURL, websiteURL: websiteURL, imageURL: imageURL, hosts: hosts, location: location, showTime: showTime, startTime: startTime, endTime: endTime, summary: summary)
    }
}
