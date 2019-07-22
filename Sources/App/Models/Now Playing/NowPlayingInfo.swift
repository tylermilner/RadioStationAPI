//
//  NowPlayingInfo.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentPostgreSQL
import Vapor

struct NowPlayingInfo: Codable {
    var id: Int?
    
    let djName: String?
    let showName: String?
    let trackTitle: String?
    let trackArtist: String?
}

extension NowPlayingInfo: PostgreSQLModel { }
extension NowPlayingInfo: Migration { }
extension NowPlayingInfo: Content { }
