//
//  BroadcastInfo.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentSQLite
import Vapor

struct BroadcastInfo: SQLiteModel {
    var id: Int?
    
    let location: String
    let dayOfWeek: String
    let startTime: String // In the format "HH:mm"
    let endTime: String // In the format "HH:mm"
}

extension BroadcastInfo: Migration { }
extension BroadcastInfo: Content { }
