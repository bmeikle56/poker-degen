import Vapor

struct LoginRequest: Content {
    let username: String
    let password: String
}

func login(_ request: Request) async throws -> String {
    let loginRequest = try request.content.decode(LoginRequest.self)
    if loginRequest.username == "braeden" && loginRequest.password == "pokerdegen" {
        return "Login successful!"
    }
    return "Unauthorized!"
}
