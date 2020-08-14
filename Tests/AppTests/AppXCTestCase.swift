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
        
        app.migrations.add(CreateTodo())
        app.migrations.add(CreateStationConfig())
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
