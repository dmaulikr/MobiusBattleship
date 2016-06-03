//
//  BoardController.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation

class BoardController {
    weak var dataController: DataController!
    var board: Board!
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
}