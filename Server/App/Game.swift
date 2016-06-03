//
//  Game.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//
import Vapor
import Foundation

enum GameStatus: String {
    case win
    case lose
    
    case kill
    case shot
    case miss
    
    case not_user_step
    case ok
}

class Game: Saveable {
    let id: String
    var userId: String!
    var userCheckSum: String!
    
    var checkSum: String {
        return startBoard.hash
    }
    let startBoard: Board
    
    var board: Board
    
    init(userId: String, checkSum: String) {
        id = NSUUID().uuidString
        startBoard = Game.generate()
        board = startBoard
        self.userId = userId
        userCheckSum = checkSum
    }
    
    func userStep(x: Int, y: Int) -> GameStatus {
        //
        return .kill
    }
    
    func serverStep() -> (GameStatus, Int?, Int?) { // status, x, y
        return (.ok, 1, 5)
    }
    
    func answer(status: GameStatus) -> GameStatus {
        return .ok
    }
    
    static func generate() -> Board {
        let result = Board()
        result.cells = defaultBoard
        return result
    }
}

extension Game: JSONRepresentable {
    func makeJson() -> JSON {
        return JSON([
                        "id": id,
                        "userId": userId
            ])
    }
}