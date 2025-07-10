import Vapor

func routes(_ app: Application) throws {
    app.post("login", use: loginController)
    app.post("modelWrapper", use: modelWrapperController)
}
