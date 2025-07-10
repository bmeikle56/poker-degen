import Vapor

struct LoginRequest: Content {
    let username: String
    let password: String
}

func loginController(_ request: Request) async throws -> String {
    let loginRequest = try request.content.decode(LoginRequest.self)
    return try await login(username: loginRequest.username, password: loginRequest.password)
}
