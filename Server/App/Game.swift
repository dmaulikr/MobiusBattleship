//
//  Game.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation

class Game: Saveable {
    let id: String
    var userId: String!
    let board = Board()
    
    init() {
        id = NSUUID().uuidString
    }
}