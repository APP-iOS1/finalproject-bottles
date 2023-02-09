//
//  ShopNotice.swift
//  Bottles_V2
//
//  Created by Jero on 2023/02/09.
//

import Foundation

struct ShopNotice : Codable, Identifiable, Hashable {
    var id : String
    var category : String
    var shopName : String
    var date : Date
    var title : String
    var body: String
}
