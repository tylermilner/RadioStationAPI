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
    let djId: String
    let broadcastInfo: BroadcastInfo
    let nextBroadcastStartTime: Date?
    let avatarURL: URL
    let soundcloudURL: URL?
    let isActive: Bool
}

extension Show: Migration { }
extension Show: Content { }
extension Show: Parameter { }
