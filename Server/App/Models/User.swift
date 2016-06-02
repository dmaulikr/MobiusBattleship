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
/**
	This allows instances of User to be 
	passed into Json arrays and dictionaries
	as if it were a native JSON type.
*/
extension User: JSONRepresentable {
    func makeJson() -> JSON {
        return JSON([
            "name": ""
        ])
    }
}

/**
	If a data structure is StringInitializable, 
	it's Type can be passed into type-safe routing handlers.
*/
extension User: StringInitializable {
    convenience init?(from string: String) throws {
        self.init()
//        self.init(name: string)
    }
}