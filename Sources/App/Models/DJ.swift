//
//  DJ.swift
//  App
//
//  Created by Tyler Milner on 11/11/17.
//

import Foundation
import Vapor

struct DJ {
    let id: String
    let handle: String
    let firstName: String
    let lastName: String
    let showId: String
    let isActive: Bool
}

extension DJ: MockRepresentable {
    static var mock: DJ {
        return DJ(id: "1", handle: "Stunna", firstName: "J.", lastName: "Cappo", showId: "1", isActive: true)
    }
}

extension DJ: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("handle", handle)
        try json.set("firstName", firstName)
        try json.set("lastName", lastName)
        try json.set("showId", showId)
        try json.set("isActive", isActive)
        return json
    }
}

extension DJ: ResponseRepresentable { }
