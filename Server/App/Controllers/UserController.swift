import Vapor

class UserController {
    weak var dataController: DataController!
    
    func auth(_ request: Request) throws -> ResponseRepresentable {
        guard let name = request.data["name"]?.string, let password = request.data["password"]?.string else {
            throw Abort.badRequest
        }
        
        let user = dataController.user(name: name, password: password)
        let session = dataController.session(user: user)
        return JSON([
                        "token": session.id
                    ])
    }
    
    func user(_ request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["name"]?.string else {
            throw Abort.badRequest
        }
        
        guard let session = dataController.session(token: token), let user = dataController.users.get(id: session.userId) else {
            throw Abort.badRequest
        }
       
        return JSON([
                        "name": user.name
                    ])
    }
}
