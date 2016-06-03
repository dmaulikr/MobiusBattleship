//
//  DataController.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation

protocol Saveable: Equatable {
    var id: String { get }
}


func ==<T: Saveable>(left: T, right: T) -> Bool {
    return left.id == right.id
}

class ItemController<T: Saveable> {
    var items: [T] = []
    
    func get(id: String) -> T? {
        return items.filter({ id == $0.id }).first
    }

    func delete(id: String?) -> Bool {
        guard let item = items.filter({ id == $0.id }).first else {
            return false
        }
        
        if let index = items.index(of: item) {
            items.remove(at: index)
            return true
        }
        
        return false
    }
    
    func put(item: T) {
        items.append(item)
    }
}

class DataController {
    var sessions = ItemController<Session>()
    var users = ItemController<User>()
    var games = ItemController<Game>()
    
    func user(name: String, password: String) -> User {
        for user in users.items {
            if user.name == name && user.password == password {
                return user
            }
        }
        let newUser = User(name, password)
        users.put(item: newUser)
        return newUser
    }
    
    func session(token: String) -> Session? {
        return sessions.get(id: token)
    }
    
    func createGame(user: User, checkSum: String) -> Game? {
        // TODO: exit if count of games > 100
        let newGame = Game(userId: user.id, checkSum: checkSum)
        games.put(item: newGame)
        return newGame
    }
    
    func games(user: User) -> [Game] {
        var result = [Game]()
        for game in games.items {
            if game.userId == user.id {
                result.append(game)
            }
        }
        return result
    }
    
    func session(user: User) -> Session {
        for session in sessions.items {
            if session.userId == user.id {
                return session
            }
        }
        
        let newSession = Session()
        newSession.userId = user.id
        sessions.put(item: newSession)
        return newSession
    }
    
}
