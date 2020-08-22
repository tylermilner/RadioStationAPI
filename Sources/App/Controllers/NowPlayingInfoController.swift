//
//  NowPlayingInfoController.swift
//  
//
//  Created by Tyler Milner on 8/21/20.
//

import Fluent
import Vapor

struct NowPlayingInfoController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.group("now-playing") { config in
            
        }
    }
    
//    func index(req: Request) throws -> EventLoopFuture<NowPlayingInfo.Get> {
//        
//    }
}
