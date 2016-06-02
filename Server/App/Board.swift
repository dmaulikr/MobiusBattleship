//
//  Board.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation

enum BoardCell: Int {
    case Empty = 0
    case Missed
}

class Board {
    var cells: [[BoardCell]] = []
}