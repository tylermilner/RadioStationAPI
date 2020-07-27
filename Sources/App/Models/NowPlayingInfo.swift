//
//  NowPlayingInfo.swift
//  
//
//  Created by Tyler Milner on 7/26/20.
//

import Fluent
import Vapor

// MARK: - Fluent

final class NowPlayingInfo: Model {
    static let schema = "now_playing_infos"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "show_name")
    var showName: String?
    
    @Field(key: "track_title")
    var trackTitle: String?
    
    @Field(key: "track_artist")
    var trackArtist: String?
    
    init() { }
    
    init(id: UUID? = nil, showName: String? = nil, trackTitle: String? = nil, trackArtist: String? = nil) {
        self.id = id
        self.showName = showName
        self.trackTitle = trackTitle
        self.trackArtist = trackArtist
    }
}

// MARK: - DTO

struct GetNowPlayingInfo {
    let showName: String?
    let trackTitle: String?
    let trackArtist: String?
}
