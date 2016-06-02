//
//  GameController.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Vapor

class GameController {

    func start(_ request: Request) throws -> ResponseRepresentable {
        return JSON([
                        "controller": "UserController.index"
            ])
    }
    
    func userStep(_ request: Request) throws -> ResponseRepresentable {
        return JSON([
                        "controller": "UserController.index"
            ])
    }
    
    func serverStep(_ request: Request) throws -> ResponseRepresentable {
        return JSON([
                        "controller": "UserController.index"
            ])
    }
    
    func serverAnswer(_ request: Request) throws -> ResponseRepresentable {
        return JSON([
                        "controller": "UserController.index"
            ])
    }
    
    func validateGameResult(_ request: Request) throws -> ResponseRepresentable {
        return JSON([
                        "controller": "UserController.index"
            ])
    }
}