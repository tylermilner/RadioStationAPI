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
            return Config.mock
        }
        
        post("login") { request in
            return AccessToken.mock
        }
        
        // TODO: Create a "Controller" for nowPlaying endpoint
        get("nowPlaying") { request in
            return NowPlayingInfo.mock
        }
        
        // TODO: Should probably be PATCH (need to update docs)
        put("nowPlaying") { request in
            return NowPlayingInfo.mock
        }
        
        // TODO: Create a "Controller" for shows endpoint
        get("shows") { request in
            var json = JSON()
            try json.set("shows", [Show.mock])
            return json
        }
        
        post("shows") { request in
            return Show.mock
        }
        
        // TODO: GET/PATCH/DELETE for shows/{id} endpoint (do when creating 'ShowsController')
        
        // TODO: Create a "Controller" for djs endpoint
        get("djs") { request in
            var json = JSON()
            try json.set("djs", [DJ.mock])
            return json
        }
        
        post("djs") { request in
            return DJ.mock
        }
        
        // TODO: GET/PATCH/DELETE for djs/{id} endpoint (do when creating 'DJsController')
    }
}
