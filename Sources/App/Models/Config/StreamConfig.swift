//
//  StreamConfig.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentSQLite
import Vapor

struct StreamConfig: SQLiteModel {
    var id: Int?
    
    let name: String
    let `extension`: String
    let bitrate: Int
    let url: URL
    let qualityScore: Int
}

extension StreamConfig: Migration { }
extension StreamConfig: Content { }
