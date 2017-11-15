//
//  AccessToken.swift
//  App
//
//  Created by Tyler Milner on 11/11/17.
//

import Foundation
import Vapor

struct AccessToken {
    let token: String
}

extension AccessToken: MockRepresentable {
    static var mock: AccessToken {
        return AccessToken(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY290Y2guaW8iLCJleHAiOjEzMDA4MTkzODAsIm5hbWUiOiJDaHJpcyBTZXZpbGxlamEiLCJhZG1pbiI6dHJ1ZX0.03f329983b86f7d9a9f5fef85305880101d5e302afafa20154d094b229f75773")
    }
}

extension AccessToken: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("token", token)
        return json
    }
}

extension AccessToken: ResponseRepresentable { }
