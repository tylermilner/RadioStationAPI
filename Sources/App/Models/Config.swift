//
//  Config.swift
//  App
//
//  Created by Tyler Milner on 11/11/17.
//

import Foundation

struct Config {
    let id: String
    let streamConfigs: [StreamConfig]
    let stationWebsiteURL: URL
}

struct StreamConfig {
    let name: String
    let `extension`: String
    let bitrate: Int
    let url: URL
    let qualityScore: Int
}

extension Config: MockRepresentable {
    static var mock: Config {
        return Config(id: "1", streamConfigs: [StreamConfig.mock], stationWebsiteURL: URL(string: "https://bassdrive.com/")!)
    }
    
    func buildJSON() throws -> JSON {
        let configs = streamConfigs.map { try? $0.buildJSON() }
        
        var json = JSON()
        try json.set("streamConfigs", configs)
        try json.set("stationWebsiteURL", stationWebsiteURL.absoluteString)
        return json
    }
}

extension StreamConfig: MockRepresentable {
    static var mock: StreamConfig {
        return StreamConfig(name: "AAC+ high quality US", extension: "aac+", bitrate: 256, url: URL(string: "https://bassdrive.com/bassdrive3.m3u")!, qualityScore: 100)
    }
    
    func buildJSON() throws -> JSON {
        var json = JSON()
        try json.set("name", name)
        try json.set("extension", `extension`)
        try json.set("bitrate", bitrate)
        try json.set("url", url.absoluteString)
        try json.set("qualityScore", qualityScore)
        return json
    }
}
