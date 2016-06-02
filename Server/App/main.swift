import Vapor
import Foundation

let app = Application()
let dataController = DataController()
ApplicationController.applicationController = ApplicationController(app, dataController)

app.hash.key = app.config["app", "key"].string ?? ""

app.grouped(middleware: [AuthMiddleware()]) { route in
    route.get("user", handler: UserController().user)
    route.get("start", handler: GameController().start)
    route.post("try", handler: GameController().userStep)
    route.get("try", handler: GameController().serverStep)
    route.post("answer", handler: GameController().serverAnswer)
    route.get("validate", handler: GameController().validateGameResult)
}
app.post("auth", handler: UserController().auth)

let port = app.config["app", "port"].int ?? 80

// Print what link to visit for default port
print("Visit http://localhost:\(port)")
app.start()
