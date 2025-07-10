import Vapor

struct AuthMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: any Responder) -> EventLoopFuture<Response> {
        guard let authHeader = request.headers["Authorization"].first,
              authHeader == "Bearer pokerdegen" else {
            let response = Response(status: .unauthorized)
            response.body = .init(string: "Unauthorized")
            return request.eventLoop.makeSucceededFuture(response)
        }

        return next.respond(to: request)
    }
}
