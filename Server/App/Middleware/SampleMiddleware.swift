import Vapor

class AuthMiddleware: Middleware {
    var sessionController: SessionController!
    
    func respond(to request: Request, chainingTo chain: Responder) throws -> Response {
        guard let token = request.data["token"]?.string where sessionController.isValidSession(token: token) else {
            return Response(status: .unauthorized)
        }
        return try chain.respond(to: request)
    }
}
