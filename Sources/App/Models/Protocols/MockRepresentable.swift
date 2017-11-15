//
//  MockRepresentable.swift
//  App
//
//  Created by Tyler Milner on 11/13/17.
//

import Foundation
import Vapor

protocol MockRepresentable {
    static var mock: Self { get }
}
