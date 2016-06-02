//
//  Game.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Vapor

class ApplicationController {
    let application: Application
    let dataController: DataController
    
    static var applicationController: ApplicationController!
    
    init(_ application: Application, _ dataController: DataController) {
        self.application = application
        self.dataController = dataController
    }
}