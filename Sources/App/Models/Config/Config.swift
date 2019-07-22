//
//  Config.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import Vapor

struct Config {
    var id: Int?
    
    let streamConfigs: [StreamConfig]
    let stationWebsiteURL: URL
}
