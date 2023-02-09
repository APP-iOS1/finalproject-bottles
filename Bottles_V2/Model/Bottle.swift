//
//  Bottle.swift
//  Bottles_V2
//
//  Created by Jero on 2023/02/09.
//

import Foundation

struct BottleModel : Codable, Identifiable, Hashable {
    var id : String
    var shopID : String
    var shopName : String
    var itemVarities : Array<String>
    var itemType : String
    var itemTaste : String
    var itemTag : Array<String>
    var itemProducer : String
    var itemPrice : Int
    var itemPairing : String
    var itemNation : String
    var itemName : String
    var itemML : Int
    var itemImage : String
    var itemFinish : String
    var itemDegree : Float
    var itemAroma : String
    var itemAdv : Float
    
    var stringItemDegree: String {
        return String(format: "%.1f", itemDegree)
    }
}
