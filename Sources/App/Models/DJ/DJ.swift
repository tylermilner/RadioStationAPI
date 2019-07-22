//
//  DJ.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentPostgreSQL
import Vapor

struct DJ: Codable {
    var id: Int?
    
    let handle: String
    let firstName: String
    let lastName: String
    let showId: Show.ID? // TODO: Add support for a DJ to belong to multiple Shows
    let isActive: Bool
}

extension DJ: PostgreSQLModel { }
extension DJ: Migration { }
extension DJ: Content { }
extension DJ: Parameter { }
