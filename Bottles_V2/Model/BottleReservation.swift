//
//  BottleReservation.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/02/08.
//

import Foundation
import Firebase

struct ReservationModel : Codable, Identifiable {
    var id : String
    var shopId : String
    var userId : String      // 이메일 형식으로 들어옴
    var reservedTime : Date
    var pickUpTime : String
    var state : String
    var reservedBottles : [ReservedBottles]
}

struct ReservedBottles : Codable, Identifiable {
    var id : String
    var BottleId : String
    var itemCount : Int
}

// 예약 상품 샘플 구조체
struct BottleReservation: Hashable {
    var id: String
    var image: String
    var title: String
    var price: Int
    var count: Int
    var shop: String
}
