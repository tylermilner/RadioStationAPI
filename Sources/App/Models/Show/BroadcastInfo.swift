//
//  BroadcastInfo.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import Foundation

struct BroadcastInfo: Codable {
    let location: String
    let dayOfWeek: String
    let startTime: String // In the format "HH:mm" (military time)
    let endTime: String // In the format "HH:mm" (military time)
}
