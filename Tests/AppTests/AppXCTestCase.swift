//
//  AppXCTestCase.swift
//  
//
//  Created by Tyler Milner on 8/13/20.
//

@testable import App
import Fluent
import FluentSQLiteDriver
import XCTVapor

class AppXCTestCase: XCTestCase {
    
    // MARK: - Properties
    
    var app: Application! // SUT
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = Application(.testing)
        
        // Use in-memory SQLite database for testing
        app.databases.use(.sqlite(.memory), as: .test, isDefault: true)
        
        app.migrations.add(CreateStationConfig())
        app.migrations.add(CreateStationStream())
        app.migrations.add(CreateShow())
        app.migrations.add(CreateUser())
        app.migrations.add(CreateToken())
        try app.autoMigrate().wait()
        
        try routes(app)
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
        try super.tearDownWithError()
    }
}

extension DatabaseID {
    
    static var test: Self {
        .init(string: "test")
    }
}
