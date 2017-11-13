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
}

extension StreamConfig: MockRepresentable {
    static var mock: StreamConfig {
        return StreamConfig(name: "AAC+ high quality US", extension: "aac+", bitrate: 256, url: URL(string: "http://bassdrive.com/bassdrive3.m3u")!, qualityScore: 100)
    }
}
