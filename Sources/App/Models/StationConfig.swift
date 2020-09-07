//
//  StationConfig.swift
//  
//
//  Created by Tyler Milner on 7/26/20.
//

import Fluent
import Vapor

final class StationConfig: Model {
    
    static let schema = "station_configs"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: FieldKeys.stationWebsiteURL)
    var stationWebsiteURL: String
    
    @Field(key: FieldKeys.streams)
    var streams: [Stream]
    
    init() { }
    
    init(id: UUID? = nil, stationWebsiteURL: String, streams: [Stream]) {
        self.id = id
        self.streams = streams
        self.stationWebsiteURL = stationWebsiteURL
    }
}

// MARK: - FieldKeys

extension StationConfig {
    
    enum FieldKeys {
        static let stationWebsiteURL: FieldKey = "station_website_url"
        static let streams: FieldKey = "streams"
    }
}

// MARK: - Extensions

extension StationConfig {
    
    struct Stream: Content, Equatable {
        let name: String
        let url: String
        let qualityScore: Int
    }
}

extension StationConfig {
    
    func patch(with patch: StationConfig.Update) {
        stationWebsiteURL = patch.stationWebsiteURL ?? stationWebsiteURL
        streams = patch.streams ?? streams
    }
}

// MARK: - DTO

extension StationConfig {
    
    struct Create: Content, Equatable {
        let stationWebsiteURL: String
        let streams: [Stream]
    }
    
    struct Get: Content, Equatable {
        let stationWebsiteURL: String
        let streams: [Stream]
    }
    
    struct Update: Content, Equatable {
        let stationWebsiteURL: String?
        let streams: [Stream]?
    }
    
    convenience init(input: Create) {
        self.init()
        
        self.stationWebsiteURL = input.stationWebsiteURL
        self.streams = input.streams
    }
    
    var responseDTO: Get {
        return Get(stationWebsiteURL: stationWebsiteURL, streams: streams)
    }
}
