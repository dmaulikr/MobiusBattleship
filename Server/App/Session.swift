//
//  Session.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation


class Session: Saveable {
    let id: String
    var userId: String!
    
    init() {
        id = NSUUID().uuidString
    }
}