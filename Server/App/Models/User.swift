import Vapor
import Foundation

final class User: Saveable {
    let id: String
    var name: String!
    var password: String!
    
    init() {
        id = NSUUID().uuidString
    }
    
    convenience init(_ name: String, _ password: String) {
        self.init()
        self.name = name
        self.password = password
    }
}

extension User: JSONRepresentable {
    func makeJson() -> JSON {
        return JSON([
            "id": id,
            "name": name,
            "password": password
        ])
    }
}