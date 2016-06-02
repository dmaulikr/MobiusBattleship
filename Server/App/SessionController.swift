//
//  SessionController.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation

class SessionController {
    weak var dataController: DataController!
    
    func isValidSession(token: String) -> Bool {
        return false
    }
    
    
    func session(token: String) -> Session? {
        return dataController.session(token: token)
    }
    
    func auth(user: User) -> Session {
        return dataController.sessions.first!
    }
}