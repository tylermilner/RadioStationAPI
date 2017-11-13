import FluentProvider

// TODO: Had to change this from "extension Config" to "extension Vapor.Config" in order to fix namespace collision build failure when I had my own type called "Config".
//  Create Vapor pull request to fix this.
extension Vapor.Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [Row.self, JSON.self, Node.self]

        try setupProviders()
        try setupPreparations()
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(FluentProvider.Provider.self)
    }
    
    /// Add all models that should have their
    /// schemas prepared before the app boots
    private func setupPreparations() throws {
        // TODO: Prepare other model schemas
        preparations.append(Post.self)
    }
}
