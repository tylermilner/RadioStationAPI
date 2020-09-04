//
//  ShowControllerTests.swift
//  
//
//  Created by Tyler Milner on 8/21/20.
//

@testable import App
import XCTVapor

class ShowControllerTests: AppXCTestCase {
    
    // MARK: - Properties
    
    private let shows = "shows"
    
    // MARK: - Tests
    
    func test_getShows_returnShows() throws {
        // Arrange
        let seed = Show(name: "Test", facebookURL: nil, twitterURL: nil, websiteURL: nil, imageURL: "http://test.com", hosts: "test", location: "test", showTime: "test", startTime: "test", endTime: "test", summary: "test")
        try seed.save(on: app.db).wait()
        
        // Act
        try app.test(.GET, shows) { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            XCTAssertContent([Show.Get].self, res) { shows in
                XCTAssertEqual(shows.count, 1)
                XCTAssertEqual(shows.first, seed.responseDTO)
            }
        }
    }
    
    func test_postShows_createsShow() throws {
        // Arrange
        let user = try User(username: "test", password: "test")
        try user.save(on: app.db).wait()
        
        let userId = try user.requireID()
        let token = Token(userId: userId, token: "test", expiresAt: Date.distantFuture)
        try token.save(on: app.db).wait()
        
        let create = Show.Create(name: "test", facebookURL: nil, twitterURL: nil, websiteURL: nil, imageURL: "http://test.com", hosts: "test", location: "test", showTime: "test", startTime: "test", endTime: "test", summary: "test")
        
        // Act
        try app.test(.POST, shows, beforeRequest: { req in
            try req.content.encode(create)
            req.headers.bearerAuthorization = BearerAuthorization(token: token.value)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            try XCTAssertContent(Show.Get.self, res) { show in
                XCTAssertEqual(show.createRepresentation, create)
                
                let databaseShows = try Show.query(on: app.db).all().wait()
                XCTAssertEqual(databaseShows.count, 1)
                
                let databaseShow = try XCTUnwrap(databaseShows.first)
                XCTAssertEqual(show, databaseShow.responseDTO)
            }
        })
    }
    
    func test_getShow_returnsShow() throws {
        // Arrange
        let seed = Show(name: "test", facebookURL: nil, twitterURL: nil, websiteURL: nil, imageURL: "http://test.com", hosts: "test", location: "test", showTime: "test", startTime: "test", endTime: "test", summary: "test")
        try seed.save(on: app.db).wait()
        let seedId = try XCTUnwrap(seed.id)
        
        // Act
        try app.test(.GET, "\(shows)/\(seedId)") { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            XCTAssertContent(Show.Get.self, res) { show in
                XCTAssertEqual(show, seed.responseDTO)
            }
        }
    }
    
    func test_patchShow_updatesShow() throws {
        // Arrange
        let user = try User(username: "test", password: "test")
        try user.save(on: app.db).wait()
        
        let userId = try user.requireID()
        let token = Token(userId: userId, token: "test", expiresAt: Date.distantFuture)
        try token.save(on: app.db).wait()
        
        let seed = Show(name: "test", facebookURL: nil, twitterURL: nil, websiteURL: nil, imageURL: "http://test.com", hosts: "test", location: "test", showTime: "test", startTime: "test", endTime: "test", summary: "test")
        try seed.save(on: app.db).wait()
        let seedId = try XCTUnwrap(seed.id)
        
        let patch = Show.Update(name: "new", facebookURL: "new", twitterURL: "new", websiteURL: "new", imageURL: "new", hosts: "new", location: "new", showTime: "new", startTime: "new", endTime: "new", summary: "new")
        
        // Act
        try app.test(.PATCH, "\(shows)/\(seedId)", beforeRequest: { req in
            try req.content.encode(patch)
            req.headers.bearerAuthorization = BearerAuthorization(token: token.value)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, .ok)
            
            try XCTAssertContent(Show.Get.self, res) { show in
                XCTAssertEqual(show.updateRepresentation, patch)
                
                let updatedShow = try Show.find(seedId, on: app.db).wait()
                XCTAssertEqual(updatedShow?.responseDTO.updateRepresentation, patch)
            }
        })
    }
    
    func test_deleteShow_deletesShow() throws {
        // Arrange
        let user = try User(username: "test", password: "test")
        try user.save(on: app.db).wait()
        
        let userId = try user.requireID()
        let token = Token(userId: userId, token: "test", expiresAt: Date.distantFuture)
        try token.save(on: app.db).wait()
        
        let seed = Show(name: "test", facebookURL: nil, twitterURL: nil, websiteURL: nil, imageURL: "http://test.com", hosts: "test", location: "test", showTime: "test", startTime: "test", endTime: "test", summary: "test")
        try seed.save(on: app.db).wait()
        let seedId = try XCTUnwrap(seed.id)
        
        // Act
        try app.test(.DELETE, "\(shows)/\(seedId)", beforeRequest: {req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token.value)
        }, afterResponse: { res in
            
            // Assert
            XCTAssertEqual(res.status, HTTPStatus.noContent)
            XCTAssertNil(res.content.contentType)
            
            let show = try Show.find(seedId, on: app.db).wait()
            XCTAssertNil(show)
        })
    }
}

extension Show.Get {
    
    var createRepresentation: Show.Create {
        return Show.Create(name: name, facebookURL: facebookURL, twitterURL: twitterURL, websiteURL: websiteURL, imageURL: imageURL, hosts: hosts, location: location, showTime: showTime, startTime: startTime, endTime: endTime, summary: summary)
    }
    
    var updateRepresentation: Show.Update {
        return Show.Update(name: name, facebookURL: facebookURL, twitterURL: twitterURL, websiteURL: websiteURL, imageURL: imageURL, hosts: hosts, location: location, showTime: showTime, startTime: startTime, endTime: endTime, summary: summary)
    }
}
