import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    #if DEBUG
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    #endif
    
    let djController = DJController()
    try router.register(collection: djController)
    
    let showController = ShowController()
    try router.register(collection: showController)
}
