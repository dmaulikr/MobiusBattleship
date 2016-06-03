//
//  GameController.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Vapor
import Foundation

class GameController {
    weak var dataController: DataController!
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func start(_ request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["token"].string, let checkSum = request.data["checkSum"].string else {
            throw Abort.badRequest
        }
        
        guard let session = dataController.session(token: token), let user = dataController.users.get(id: session.userId) else {
            throw Abort.badRequest
        }
        
        guard let newGame = dataController.createGame(user: user, checkSum: checkSum) else {
            throw Abort.badRequest
        }
        
        return JSON([
                    "gameId": newGame.id,
                    "checkSum": newGame.checkSum
                ])
    }
    
    func userStep(_ request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["token"].string else {
            throw Abort.badRequest
        }
        
        guard let x = request.data["x"].int, let y = request.data["y"].int
            where x >= 0 && x < 10 && y >= 0 && y < 10 else {
                throw Abort.badRequest
        }
        
        guard let gameId = request.data["gameId"].string else {
            throw Abort.badRequest
        }
        
        guard let session = dataController.session(token: token), let user = dataController.users.get(id: session.userId) else {
            throw Abort.badRequest
        }
        
        guard let game = dataController.games(user: user).filter({ $0.id == gameId }).first else {
            throw Abort.badRequest
        }
        
        let result = game.userStep(x: x, y: y)
        
        return JSON([
                    "status": result.rawValue
                    ])
    }
    
    func serverStep(_ request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["token"].string else {
            throw Abort.badRequest
        }
        
        guard let gameId = request.data["gameId"].string else {
            throw Abort.badRequest
        }
        
        guard let session = dataController.session(token: token), let user = dataController.users.get(id: session.userId) else {
            throw Abort.badRequest
        }
        
        guard let game = dataController.games(user: user).filter({ $0.id == gameId }).first else {
            throw Abort.badRequest
        }
        
        let result = game.serverStep()
        guard let x = result.1, let y = result.2 else {
            return JSON([
                    "status": result.0.rawValue
                    ])
        }
        
        return JSON([
                    "status": result.0.rawValue,
                    "x": x,
                    "y": y
                    ])
    }
    
    func serverAnswer(_ request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["token"].string,
            let strStatus = request.data["token"].string, let status = GameStatus(rawValue: strStatus) else {
            throw Abort.badRequest
        }
        
        guard let gameId = request.data["gameId"].string else {
            throw Abort.badRequest
        }
        
        guard let session = dataController.session(token: token), let user = dataController.users.get(id: session.userId) else {
            throw Abort.badRequest
        }
        
        guard let game = dataController.games(user: user).filter({ $0.id == gameId }).first else {
            throw Abort.badRequest
        }
        
        let result = game.answer(status: status)
        return JSON([
                    "status": result.rawValue
                    ])
    }
    
    func validateGameResult(_ request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["token"].string else {
                throw Abort.badRequest
        }
    
        guard let gameId = request.data["gameId"].string else {
            throw Abort.badRequest
        }
        
        guard let session = dataController.session(token: token), let user = dataController.users.get(id: session.userId) else {
            throw Abort.badRequest
        }
        
        guard let game = dataController.games(user: user).filter({ $0.id == gameId }).first else {
            throw Abort.badRequest
        }
        
        
        guard let data = request.jsonBody, let json = try? NSJSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            throw Abort.badRequest
        }
        guard let jsonBoard = json?["board"] as? [[UInt8]] else {
            throw Abort.badRequest
        }
    

        return JSON([
                        "controller": "UserController.index"
            ])
    }
}