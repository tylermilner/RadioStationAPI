//
//  Config.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentSQLite
import Vapor

struct Config: SQLiteModel {
    var id: Int?
    
    let streamConfigs: [StreamConfig]
    let stationWebsiteURL: URL
}

extension Config: Migration { }
extension Config: Content { }
