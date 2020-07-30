//
//  StationConfig.swift
//  
//
//  Created by Tyler Milner on 7/26/20.
//

import Fluent
import Vapor

// MARK: - Fluent

final class StationConfig: Model {
    static let schema = "station_configs"
    
    @ID(key: .id)
    var id: UUID?
    
    // TODO: Setup relationship for StationConfig <--> StationStream
//    var streams: [StationStream]
    
    @Field(key: "station_website_url")
    var stationWebsiteURL: String
    
    init() { }
    
    init(id: UUID? = nil, stationWebsiteURL: String) {
        self.id = id
        self.stationWebsiteURL = stationWebsiteURL
    }
}

final class StationStream: Model {
    static let schema = "station_stream"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "type")
    var type: String
    
    @Field(key: "bitrate")
    var bitrate: Int
    
    @Field(key: "url")
    var url: String
    
    @Field(key: "quality_score")
    var qualityScore: Int
}

// MARK: - PATCH

extension StationConfig {
    
    func patch(with patch: PatchStationConfig) {
        // TODO: Implement 'streams' property once relationships are setup
        stationWebsiteURL = patch.stationWebsiteURL ?? stationWebsiteURL
    }
}

// MARK: - DTO

struct GetStationConfig: Content {
    let streams: [GetStationStream]
    let stationWebsiteURL: String
}

struct GetStationStream: Content {
    let name: String
    let type: String
    let bitrate: Int
    let url: String
    let qualityScore: Int
}

struct PatchStationConfig: Content {
    // TODO: Implement PATCH for 'streams' property
    let stationWebsiteURL: String?
}

extension StationConfig {
    
    var responseDTO: GetStationConfig {
        // TODO: Implement 'streams' property once relationships are setup
        return GetStationConfig(streams: [], stationWebsiteURL: stationWebsiteURL)
    }
}
