import Vapor

func routes(_ app: Application) throws {
    app.post("login", use: login)
    app.post("modelWrapper", use: modelWrapper)
}
