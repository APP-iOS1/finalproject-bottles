//
//  Shop.swift
//  Bottles_V2
//
//  Created by Jero on 2023/02/09.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift   //GeoPoint 사용을 위한 프레임워크

struct ShopModel : Codable, Identifiable, Hashable {
    var id : String
    var shopName : String
    var shopOpenCloseTime : String
    var shopAddress : String
    var shopPhoneNumber : String
    var shopIntroduction : String
    var shopSNS : String
    var followerUserList : Array<String>
    var isRegister : Bool
    var location : GeoPoint
    var reservedList : Array<String>
    var shopTitleImage : String
    var shopImages : Array<String>
    var shopCurationTitle : String
    var shopCurationBody : String
    var shopCurationImage : String
    var shopCurationBottleID : Array<String>
    
    var bottleCollections : Array<String>
    var noticeCollection : Array<String>
    var reservationCollection : Array<String>
}
