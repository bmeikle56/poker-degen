import Vapor

struct AuthMiddleware: Middleware {
    private let authToken = Environment.get("AUTH_TOKEN")!

    func respond(to request: Request, chainingTo next: any Responder) -> EventLoopFuture<Response> {
        print("authToken \(authToken)")
        guard let authHeader = request.headers["Authorization"].first,
              authHeader == "Bearer \(authToken)" else {
            let response = Response(status: .unauthorized)
            response.body = .init(string: "Unauthorized")
            return request.eventLoop.makeSucceededFuture(response)
        }

        return next.respond(to: request)
    }
}
