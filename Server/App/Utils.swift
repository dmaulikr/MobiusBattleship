//
//  Utils.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/2/16.
//
//

import Foundation
import Vapor

extension Request {
    public var jsonBody: NSData? {
        switch body {
        case .buffer(let data): return NSData(bytes: data.bytes, length: data.bytes.count)
        default: return nil
        }
    }
}