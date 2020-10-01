//
//  Show.swift
//  
//
//  Created by Tyler Milner on 7/26/20.
//

import Fluent
import Vapor

final class Show: Model {
    
    static let schema = "shows"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: FieldKeys.name)
    var name: String
    
    @OptionalField(key: FieldKeys.facebookURL)
    var facebookURL: String?
    
    @OptionalField(key: FieldKeys.twitterURL)
    var twitterURL: String?
    
    @OptionalField(key: FieldKeys.websiteURL)
    var websiteURL: String?
    
    @Field(key: FieldKeys.imageURL)
    var imageURL: String
    
    @Field(key: FieldKeys.hosts)
    var hosts: String
    
    @Field(key: FieldKeys.location)
    var location: String
    
    @Field(key: FieldKeys.showTime)
    var showTime: String
    
    @Field(key: FieldKeys.startTime)
    var startTime: String
    
    @Field(key: FieldKeys.endTime)
    var endTime: String
    
    @Field(key: FieldKeys.summary)
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

// MARK: - FieldKeys

extension Show {
    
    enum FieldKeys {
        static let name: FieldKey = "name"
        static let facebookURL: FieldKey = "facebook_url"
        static let twitterURL: FieldKey = "twitter_url"
        static let websiteURL: FieldKey = "website_url"
        static let imageURL: FieldKey = "image_url"
        static let hosts: FieldKey = "hosts"
        static let location: FieldKey = "location"
        static let showTime: FieldKey = "show_time"
        static let startTime: FieldKey = "start_time"
        static let endTime: FieldKey = "end_time"
        static let summary: FieldKey = "summary"
    }
}

// MARK: - Extensions

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
    
    func replace(with replace: Show.Create) {
        name = replace.name
        facebookURL = replace.facebookURL
        twitterURL = replace.twitterURL
        websiteURL = replace.websiteURL
        imageURL = replace.imageURL
        hosts = replace.hosts
        location = replace.location
        showTime = replace.showTime
        startTime = replace.startTime
        endTime = replace.endTime
        summary = replace.summary
    }
}

// MARK: - DTO

extension Show {
    
    struct Create: Content, Equatable {
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
    
    struct Get: Content, Equatable {
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
    
    struct Update: Content, Equatable {
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
