//
//  BottleReservation.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/02/08.
//

import Foundation

struct ReservationModel : Codable, Identifiable {
    var id : String
    var shopID : String
    var userID : String      // 이메일 형식으로 들어옴
    var reservedTime : String
    var state : String
    var reservedBottles : [ReservedBottles]
}

struct ReservedBottles : Codable {
    var id : String
    var BottleID : String
    var itemCount : Int
}

// 예약 상품 샘플 구조체
struct BottleReservation: Hashable {
    var image: String
    var title: String
    var price: Int
    var count: Int
    var shop: String
}
