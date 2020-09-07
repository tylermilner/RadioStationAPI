//
//  StationStream.swift
//  
//
//  Created by Tyler Milner on 9/5/20.
//

import Fluent
import Vapor

final class StationStream: Model {
    
    static let schema = "station_streams"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: FieldKeys.name)
    var name: String
    
    @Field(key: FieldKeys.url)
    var url: String
    
    @Field(key: FieldKeys.qualityScore)
    var qualityScore: Int
    
    init() { }
    
    init(id: UUID? = nil, name: String, url: String, qualityScore: Int = 0) {
        self.id = id
        self.name = name
        self.url = url
        self.qualityScore = qualityScore
    }
}

// MARK: - FieldKeys

extension StationStream {
    
    enum FieldKeys {
        static let name: FieldKey = "name"
        static let url: FieldKey = "url"
        static let qualityScore: FieldKey = "quality_score"
    }
}

// MARK: - Extensions

extension StationStream {
    
    func patch(with patch: StationStream.Update) {
        name = patch.name ?? name
        url = patch.url ?? url
        qualityScore = patch.qualityScore ?? qualityScore
    }
}

// MARK: - DTO

extension StationStream {
    
    struct Create: Content {
        let name: String
        let url: String
        let qualityScore: Int
    }
    
    struct Get: Content {
        let id: UUID
        let name: String
        let url: String
        let qualityScore: Int
    }
    
    struct Update: Content {
        let name: String?
        let url: String?
        let qualityScore: Int?
    }
    
    convenience init(input: Create) {
        self.init()
        
        self.name = input.name
        self.url = input.url
        self.qualityScore = input.qualityScore
    }
    
    func responseDTO() throws -> Get {
        let streamId = try requireID()
        return Get(id: streamId, name: name, url: url, qualityScore: qualityScore)
    }
}
