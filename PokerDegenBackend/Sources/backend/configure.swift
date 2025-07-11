import Vapor

public func configure(_ app: Application) async throws {
    loadEnvFile()
    
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.middleware.use(AuthMiddleware())
    try routes(app)
}
