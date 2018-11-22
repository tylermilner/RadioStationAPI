//
//  NowPlayingInfo.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentSQLite
import Vapor

struct NowPlayingInfo: SQLiteModel {
    var id: Int?
    
    let djName: String?
    let showName: String?
    let trackTitle: String?
    let trackArtist: String?
}

extension NowPlayingInfo: Migration { }
extension NowPlayingInfo: Content { }
