import Vapor

class UserController {
    weak var dataController: DataController!
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func auth(_ request: Request) throws -> ResponseRepresentable {
        guard let name = request.data["name"]?.string else {
            throw Abort.badRequest
        }
        guard let password = request.data["password"]?.string else {
            throw Abort.badRequest
        }
        
        let user = dataController.user(name: name, password: password)
        let session = dataController.session(user: user)
        return JSON([
                        "token": session.id
                    ])
    }
    
    func user(_ request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["token"]?.string else {
            throw Abort.badRequest
        }
        
        guard let session = dataController.session(token: token), let user = dataController.users.get(id: session.userId) else {
            throw Abort.badRequest
        }
        
        return JSON([
                        "name": user.name
                    ])
    }
    
    func users(_ request: Request) throws -> ResponseRepresentable {
        return JSON(dataController.users.items.map{ item in return item })
    }
}
