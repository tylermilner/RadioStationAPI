//
//  NowPlayingInfo.swift
//  App
//
//  Created by Tyler Milner on 11/11/17.
//

import Foundation

struct NowPlayingInfo {
    let id: String
    let djName: String?
    let showName: String?
    let trackTitle: String?
    let trackArtist: String?
}

extension NowPlayingInfo: MockRepresentable {
    static var mock: NowPlayingInfo {
        return NowPlayingInfo(id: "1", djName: "Stunna", showName: "The Greenroom", trackTitle: "Can't Stop", trackArtist: "Command Strange")
    }
    
    func buildJSON() throws -> JSON {
        var json = JSON()
        try json.set("djName", djName)
        try json.set("showName", showName)
        try json.set("trackTitle", trackTitle)
        try json.set("trackArtist", trackArtist)
        return json
    }
}
