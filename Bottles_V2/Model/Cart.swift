//
//  Cart.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/02/06.
//

import Foundation

struct Cart: Identifiable {
    var id: String
    var bottleId: String
    var eachPrice: Int
    var itemCount: Int
    var shopId: String
    var shopName: String
}
