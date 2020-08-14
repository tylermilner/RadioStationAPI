//
//  StationConfigControllerTests.swift
//  
//
//  Created by Tyler Milner on 8/13/20.
//

@testable import App
import XCTVapor

class StationConfigControllerTests: AppXCTestCase {
    
    // MARK: - Properties
    
    private let configPath = "config"
    
    // MARK: - Tests
    
    func test_getStationConfig_returnsConfig() throws {
        // Arrange
        let seedConfig = StationConfig(stationWebsiteURL: "https://test.com")
        try seedConfig.save(on: app.db).wait()
        
        // Act
        try app.test(.GET, configPath) { res in
            
            // Assert
            XCTAssertContent(StationConfig.Get.self, res) { config in
                XCTAssertEqual(config.stationWebsiteURL, seedConfig.stationWebsiteURL)
            }
        }
    }
    
    func test_postStationConfig_createsConfig() throws {
        // Arrange
        let configBody = StationConfig.Create(stationWebsiteURL: "https://test.com")
        
        // Act
        try app.test(.POST, configPath, beforeRequest: { req in
            try req.content.encode(configBody)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertContent(StationConfig.Get.self, res) { config in
                XCTAssertEqual(config.stationWebsiteURL, configBody.stationWebsiteURL)
            }
        })
    }
    
    func test_postStationConfig_abortsIfConfigAlreadyExists() throws {
        // Arrange
        let seedConfig = StationConfig(stationWebsiteURL: "https://test.com")
        try seedConfig.save(on: app.db).wait()
        
        let configBody = StationConfig.Create(stationWebsiteURL: "https://test.com")
        
        // Act
        try app.test(.POST, configPath, beforeRequest: { req in
            try req.content.encode(configBody)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .badRequest)
            
            let databaseConfigs = try StationConfig.query(on: app.db).all().wait()
            XCTAssertEqual(databaseConfigs.count, 1)
            
            let config = try XCTUnwrap(databaseConfigs.first)
            XCTAssertEqual(config.stationWebsiteURL, seedConfig.stationWebsiteURL)
        })
    }
    
    func test_patchStationConfig_updatesConfig() throws {
        // Arrange
        let seedConfig = StationConfig(stationWebsiteURL: "https://test.com")
        try seedConfig.save(on: app.db).wait()
        
        let configBody = StationConfig.Update(stationWebsiteURL: "https://update.test.com")
        
        // Act
        try app.test(.PATCH, configPath, beforeRequest: { req in
            try req.content.encode(configBody)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertContent(StationConfig.Get.self, res) { config in
                XCTAssertEqual(config.stationWebsiteURL, configBody.stationWebsiteURL)
            }
        })
    }
}
