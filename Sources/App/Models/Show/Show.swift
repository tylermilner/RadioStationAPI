//
//  Show.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentSQLite
import Vapor

struct Show: SQLiteModel {
    var id: Int?
    
    let name: String
    let description: String
    let djId: DJ.ID // TODO: Add support for a Show to have multiple DJs
    let broadcastInfo: BroadcastInfo
    let nextBroadcastStartTime: Date?
    let avatarURL: URL
    let soundcloudURL: URL?
    let isActive: Bool
}

extension Show {
    var dj: Parent<Show, DJ> {
        return parent(\.djId)
    }
}

extension Show: Migration { }
extension Show: Content { }
extension Show: Parameter { }
