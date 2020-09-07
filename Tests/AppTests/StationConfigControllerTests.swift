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
    
    private let config = "config"
    
    // MARK: - Tests
    
    func test_getStationConfig_returnsConfig() throws {
        // Arrange
        let seed = StationConfig(stationWebsiteURL: "https://test.com", streams: [StationConfig.Stream(name: "test", url: "https://stream.test.com", qualityScore: 1)])
        try seed.save(on: app.db).wait()
        
        // Act
        try app.test(.GET, config) { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            XCTAssertContent(StationConfig.Get.self, res) { config in
                XCTAssertEqual(config, seed.responseDTO)
            }
        }
    }
    
    func test_postStationConfig_createsConfig() throws {
        // Arrange
        let user = try User(username: "test", password: "test")
        try user.save(on: app.db).wait()
        
        let userId = try user.requireID()
        let token = Token(userId: userId, value: "test", expiresAt: Date.distantFuture)
        try token.save(on: app.db).wait()
        
        let create = StationConfig.Create(stationWebsiteURL: "https://test.com", streams: [StationConfig.Stream(name: "test", url: "https://stream.test.com", qualityScore: 1)])
        
        // Act
        try app.test(.POST, config, beforeRequest: { req in
            try req.content.encode(create)
            req.headers.bearerAuthorization = BearerAuthorization(token: token.value)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            try XCTAssertContent(StationConfig.Get.self, res) { config in
                XCTAssertEqual(config.createRepresentation, create)
                
                let databaseConfigs = try StationConfig.query(on: app.db).all().wait()
                XCTAssertEqual(databaseConfigs.count, 1)
                
                let databaseConfig = try XCTUnwrap(databaseConfigs.first)
                XCTAssertEqual(databaseConfig.responseDTO, config)
            }
        })
    }
    
    func test_postStationConfig_abortsIfConfigAlreadyExists() throws {
        // Arrange
        let user = try User(username: "test", password: "test")
        try user.save(on: app.db).wait()
        
        let userId = try user.requireID()
        let token = Token(userId: userId, value: "test", expiresAt: Date.distantFuture)
        try token.save(on: app.db).wait()
        
        let seed = StationConfig(stationWebsiteURL: "https://test.com", streams: [StationConfig.Stream(name: "test", url: "https://stream.test.com", qualityScore: 1)])
        try seed.save(on: app.db).wait()
        
        let create = StationConfig.Create(stationWebsiteURL: "https://new.test.com", streams: [StationConfig.Stream(name: "new-test", url: "https://new-stream.test.com", qualityScore: 2)])
        
        // Act
        try app.test(.POST, config, beforeRequest: { req in
            try req.content.encode(create)
            req.headers.bearerAuthorization = BearerAuthorization(token: token.value)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .forbidden)
            
            let databaseConfigs = try StationConfig.query(on: app.db).all().wait()
            XCTAssertEqual(databaseConfigs.count, 1)
            
            let databaseConfig = try XCTUnwrap(databaseConfigs.first)
            XCTAssertEqual(databaseConfig.responseDTO, seed.responseDTO)
        })
    }
    
    func test_patchStationConfig_updatesConfig() throws {
        // Arrange
        let user = try User(username: "test", password: "test")
        try user.save(on: app.db).wait()
        
        let userId = try user.requireID()
        let token = Token(userId: userId, value: "test", expiresAt: Date.distantFuture)
        try token.save(on: app.db).wait()
        
        let seed = StationConfig(stationWebsiteURL: "https://test.com", streams: [StationConfig.Stream(name: "test", url: "https://stream.test.com", qualityScore: 1)])
        try seed.save(on: app.db).wait()
        let seedId = try XCTUnwrap(seed.id)
        
        let patch = StationConfig.Update(stationWebsiteURL: "https://update.test.com", streams: [StationConfig.Stream(name: "update-test", url: "https://update-stream.test.com", qualityScore: 2)])
        
        // Act
        try app.test(.PATCH, config, beforeRequest: { req in
            try req.content.encode(patch)
            req.headers.bearerAuthorization = BearerAuthorization(token: token.value)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            try XCTAssertContent(StationConfig.Get.self, res) { config in
                XCTAssertEqual(config.updateRepresentation, patch)
                
                let databaseConfig = try StationConfig.find(seedId, on: app.db).wait()
                XCTAssertEqual(databaseConfig?.responseDTO.updateRepresentation, patch)
            }
        })
    }
}

extension StationConfig.Get {
    
    var createRepresentation: StationConfig.Create {
        return StationConfig.Create(stationWebsiteURL: stationWebsiteURL, streams: streams)
    }
    
    var updateRepresentation: StationConfig.Update {
        return StationConfig.Update(stationWebsiteURL: stationWebsiteURL, streams: streams)
    }
}
