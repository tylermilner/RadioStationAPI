import Vapor

// TODO: Extract route names into a common structure to remove string literal duplication.

extension Droplet {
    func setupRoutes() throws {
        // JSON Example:
//        get("hello") { req in
//            var json = JSON()
//            try json.set("hello", "world")
//            return json
//        }
        
        // Plaintext Example:
//        get("plaintext") { req in
//            return "Hello, world!"
//        }
        
        // Resource Controller Example:
//        try resource("posts", PostController.self)
        
        get("config") { request in
            return try Config.mock.makeJSON()
        }
        
        post("login") { request in
            return try AccessToken.mock.makeJSON()
        }
        
        // TODO: Create a "Controller" for nowPlaying endpoint
        get("nowPlaying") { request in
            return try NowPlayingInfo.mock.makeJSON()
        }
        
        // TODO: Should probably be PATCH (need to update docs)
        put("nowPlaying") { request in
            return try NowPlayingInfo.mock.makeJSON()
        }
        
        // TODO: Create a "Controller" for shows endpoint
        get("shows") { request in
            let show = try Show.mock.makeJSON()
            
            var json = JSON()
            try json.set("shows", [show])
            return json
        }
        
        post("shows") { request in
            return try Show.mock.makeJSON()
        }
        
        // TODO: GET/PATCH/DELETE for shows/{id} endpoint (do when creating 'ShowsController')
        
        // TODO: Create a "Controller" for djs endpoint
        get("djs") { request in
            let dj = try DJ.mock.makeJSON()
            
            var json = JSON()
            try json.set("djs", [dj])
            return json
        }
        
        post("djs") { request in
            return try DJ.mock.makeJSON()
        }
        
        // TODO: GET/PATCH/DELETE for djs/{id} endpoint (do when creating 'DJsController')
    }
}
