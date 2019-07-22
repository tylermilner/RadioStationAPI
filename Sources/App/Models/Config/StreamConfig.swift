//
//  StreamConfig.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import Vapor

struct StreamConfig {
    var id: Int?
    
    let name: String
    let `extension`: String
    let bitrate: Int
    let url: URL
    let qualityScore: Int
}
