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
    
    // TODO: Setup relationship for StationConfig <--> StationStream
//    var streams: [StationStream]
    
    @Field(key: FieldKeys.stationWebsiteURL)
    var stationWebsiteURL: String
    
    init() { }
    
    init(id: UUID? = nil, stationWebsiteURL: String) {
        self.id = id
        self.stationWebsiteURL = stationWebsiteURL
    }
}

// MARK: - FieldKeys

extension StationConfig {
    
    enum FieldKeys {
        static let stationWebsiteURL: FieldKey = "station_website_url"
    }
}

// MARK: - Extensions

extension StationConfig {
    
    func patch(with patch: StationConfig.Update) {
        // TODO: Implement 'streams' property once relationships are setup
        stationWebsiteURL = patch.stationWebsiteURL ?? stationWebsiteURL
    }
}

// MARK: - DTO

extension StationConfig {
    
    struct Create: Content {
        let stationWebsiteURL: String
        // TODO: Implement 'streams' property once relationships are setup
    }
    
    struct Get: Content {
        // TODO: Implement 'streams' property once relationships are setup
        var stationWebsiteURL: String
    }
    
    struct Update: Content {
        // TODO: Implement 'streams' property once relationships are setup
        let stationWebsiteURL: String?
    }
    
    convenience init(input: Create) {
        self.init()
        
        // TODO: Implement 'streams' property once relationships are setup
        self.stationWebsiteURL = input.stationWebsiteURL
    }
    
    var responseDTO: Get {
        // TODO: Implement 'streams' property once relationships are setup
        return Get(stationWebsiteURL: stationWebsiteURL)
    }
}
