//
//  Data.swift
//  Bottles_V2
//
//  Created by eunno on 2023/02/08.
//
import Foundation
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
