//
//  Show.swift
//  App
//
//  Created by Tyler Milner on 11/11/17.
//

import Foundation
import Vapor

struct Show {
    let id: String
    let name: String
    let description: String
    let djId: String
    let broadcastInfo: BroadcastInfo
    let nextBroadcastStartTime: Date?
    let avatarURL: URL
    let soundcloudURL: URL?
    let isActive: Bool
}

struct BroadcastInfo {
    let location: String
    let dayOfWeek: String
    let startTime: String // In the format "HH:mm"
    let endTime: String // In the format "HH:mm"
}

extension Show: MockRepresentable {
    static var mock: Show {
        return Show(id: "1", name: "The Greenroom", description: "A classically trained keyboardist and working musician based in Chicago, STUNNA (aka J. Cappo) has crafted his own unique sound within the fast-paced world of Drum + Bass music", djId: "1", broadcastInfo: BroadcastInfo.mock, nextBroadcastStartTime: Date(timeIntervalSince1970: 1510776000), avatarURL: URL(string: "http://bassdrive.com/img/radio_schedule_entries/image/original/stunnagreenroompromo1nufinalhalf-74.jpg")!, soundcloudURL: URL(string: "https://soundcloud.com/stunna")!, isActive: true)
    }
}

extension BroadcastInfo: MockRepresentable {
    static var mock: BroadcastInfo {
        return BroadcastInfo(location: "Chicago, IL, USA", dayOfWeek: "Wednesday", startTime: "14:00", endTime: "17:00")
    }
}

extension Show: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("description", description)
        try json.set("djId", djId)
        try json.set("broadcastInfo", broadcastInfo.makeJSON())
        try json.set("nextBroadcastStartTime", nextBroadcastStartTime?.timeIntervalSince1970)
        try json.set("avatarURL", avatarURL.absoluteString)
        try json.set("soundCloudURL", soundcloudURL?.absoluteString)
        try json.set("isActive", isActive)
        return json
    }
}

extension BroadcastInfo: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("location", location)
        try json.set("dayOfWeek", dayOfWeek)
        try json.set("startTime", startTime)
        try json.set("endTime", endTime)
        return json
    }
}

extension Show: ResponseRepresentable { }

extension BroadcastInfo: ResponseRepresentable { }
