//
//  HashValue.swift
//  VaporApp
//
//  Created by Anton Davydov1 on 6/3/16.
//
//

import Foundation

protocol Digest {
    static func hash(source: NSData) -> NSData
    static var digestLength: Int { get }
}

class MD5Digest: Digest {
    
    static var digestLength: Int {
        return Int(CC_MD5_DIGEST_LENGTH)
    }
    
    static func hash(source: NSData) -> NSData {
        
        var digest = [UInt8]() //(count: MD5Digest.digestLength, repeatedValue: 0)
        CC_MD5(source.bytes, CC_LONG(source.length), &digest)
        return NSData(bytes: digest, length: digest.count)
    }
}

class HashValue<D: Digest> {
    let hashValue: NSData!
    
    var hexString: String {
        let hex = NSMutableString()
        let bytes = UnsafePointer<UInt8>(hashValue.bytes)
        for i in 0..<hashValue.length {
            hex.appendFormat("%02x", bytes[i])
        }
        return hex as String
    }
    
    static func hashOfRawData(data: NSData) -> HashValue<D> {
        return HashValue<D>(hashValue: D.hash(source: data))
    }
    
    static func hashOfFile(fileURL: NSURL) -> HashValue<D>? {
        if let data = try? NSData(contentsOf: fileURL, options: NSDataReadingOptions.dataReadingMappedAlways) {
            return HashValue(hashValue: D.hash(source: data))
        }
        return nil
    }
    
    init(hashValue: NSData) {
        self.hashValue = hashValue
    }
    
    init?(hexString: String) {
        var digest: [UInt8] = (0..<D.digestLength).map({ _ in 0 })   //(count: D.digestLength, repeatedValue: 0)
        if hexString.characters.count < digest.count * 2 {
            hashValue = nil
            return nil
        }
        for i in 0..<digest.count {
            let start: String.Index = hexString.index(hexString.startIndex, offsetBy: i*2)
            let end: String.Index = hexString.index(start, offsetBy: 2)
            let s = hexString[Range(start..<end)]
            if let uint = UInt8(s, radix: 16) {
                digest[i] = uint
            } else {
                hashValue = nil
                return nil
            }
        }
        hashValue = NSData(bytes: digest, length: digest.count)
    }
}

typealias MD5HashValue = HashValue<MD5Digest>

func ==<D>(lv: HashValue<D>, rv: HashValue<D>) -> Bool {
    return lv.hashValue.isEqual(to: rv.hashValue)
}

func !=<D>(lv: HashValue<D>, rv: HashValue<D>) -> Bool {
    return !lv.hashValue.isEqual(to: rv.hashValue)
}