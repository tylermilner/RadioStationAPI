//
//  DJ.swift
//  App
//
//  Created by Tyler Milner on 11/21/18.
//

import FluentSQLite
import Vapor

struct DJ: SQLiteModel {
    var id: Int?
    
    let handle: String
    let firstName: String
    let lastName: String
    let showId: String
    let isActive: Bool
}

extension DJ: Migration { }
extension DJ: Content { }
extension DJ: Parameter { }
