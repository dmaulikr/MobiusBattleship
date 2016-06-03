//
//  Board.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//
import Vapor
import Foundation

enum BoardCell: UInt8 {
    case w = 0  // Water
    case s      // Ship
    case sw     // Shot water
    case ss     // Shot ship
}

let defaultBoard: [[BoardCell]] = [
    [.w, .w, .s, .w, .s, .s, .w, .w, .w, .w],
    [.s, .s, .s, .w, .s, .s, .s, .s, .s, .s],
    [.w, .s, .s, .w, .s, .w, .w, .w, .s, .w],
    [.w, .s, .s, .s, .s, .s, .s, .s, .s, .w],
    [.w, .s, .s, .s, .s, .s, .s, .s, .s, .s],
    [.w, .s, .s, .s, .s, .w, .s, .s, .s, .w],
    [.s, .s, .s, .s, .s, .w, .s, .s, .s, .w],
    [.w, .w, .s, .s, .s, .s, .s, .s, .s, .w],
    [.s, .s, .s, .s, .s, .s, .s, .s, .s, .s],
    [.s, .s, .s, .s, .w, .w, .w, .w, .w, .w]
]

class Board {
    var id: String!
    var cells: [[BoardCell]] = []
    
    init() {
        id = NSUUID().uuidString
    }
    
    var hash: String {
        var bytes = [UInt8]()
        for i in cells {
            for j in i {
                bytes.append(j.rawValue)
            }
        }
        let data = NSData(bytes: bytes)
        return HashValue<MD5Digest>(hashValue: data).hexString
    }
}

extension Board: JSONRepresentable {
    func makeJson() -> JSON {
        return JSON([
                        "id": id
            ])
    }
}