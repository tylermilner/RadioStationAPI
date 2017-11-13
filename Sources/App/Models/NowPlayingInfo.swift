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
}
