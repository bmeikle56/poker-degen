func login(username: String, password: String) async throws -> String {
    if username == "braeden" && password == "pokerdegen" {
        return "Login successful!"
    }
    return "Unauthorized!"
}
