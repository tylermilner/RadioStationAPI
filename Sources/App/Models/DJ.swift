//
//  DJ.swift
//  App
//
//  Created by Tyler Milner on 11/11/17.
//

import Foundation

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
