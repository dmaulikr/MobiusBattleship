//
//  Session.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//
import Vapor
import Foundation


class Session: Saveable {
    let id: String
    var userId: String!
    
    init() {
        id = NSUUID().uuidString
    }
}

extension Session: JSONRepresentable {
    func makeJson() -> JSON {
        return JSON([
                        "id": id,
                        "userId": userId
            ])
    }
}