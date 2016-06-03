import Vapor
import Foundation

let app = Application()
let dataController = DataController()
ApplicationController.applicationController = ApplicationController(app, dataController)

let userController = UserController(dataController: dataController)
let gameController = GameController(dataController: dataController)

app.hash.key = app.config["app", "key"].string ?? ""

app.grouped(middleware: [AuthMiddleware()]) { route in
    route.get("user", handler: userController.user) //
    route.get("start", handler: gameController.start)
    route.post("try", handler: gameController.userStep)
    route.get("try", handler: gameController.serverStep)
    route.post("answer", handler: gameController.serverAnswer)
    route.get("validate", handler: gameController.validateGameResult)
}
app.post("auth", handler: userController.auth)


//For Debug only
app.get("users", handler: userController.users)

let port = app.config["app", "port"].int ?? 80

// Print what link to visit for default port
print("Visit http://\(app.config["app", "host"]!.string):\(port)")
app.start()
