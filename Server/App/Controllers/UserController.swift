import Vapor

class UserController {
    weak var dataController: DataController!
    
    func auth(_ request: Request) throws -> ResponseRepresentable {
        return JSON([
            "controller": "UserController.index"
        ])
    }
    
    func user(_ request: Request) throws -> ResponseRepresentable {
        return JSON([
                        "controller": "UserController.index"
            ])
    }
}
