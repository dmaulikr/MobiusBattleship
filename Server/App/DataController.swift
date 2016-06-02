//
//  DataController.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation

protocol SavedItem {
    var id: String { get }
}

class ItemController<T: SavedItem> {
    var items: [T] = []
    
    func get(id: String) -> T? {
        return items.filter({ id == $0.id }).first
    }

    func delete(id: String?) -> Bool {
        guard let item = items.filter({ id == $0.id }).first else {
            return true
        }
        return false
        
//        
//        if let index = items.indexOf(item) {
//            
//        }
    }
}

class DataController {
    var sessions = [Session]()
    var user = [User]()
    var games = [Game]()
    
    func user(name: String, password: String) -> User? {
        return nil
    }
    
    func session(token: String) -> Session? {
        return nil
    }
    
    func game(id: String) -> Game? {
        return nil
    }
    
    
    
}
