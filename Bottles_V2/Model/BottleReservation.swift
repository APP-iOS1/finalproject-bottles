//
//  BottleReservation.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/02/08.
//

import Foundation

// 예약 상품 샘플 구조체
struct BottleReservation: Hashable {
    var image: String
    var title: String
    var price: Int
    var count: Int
    var shop: String
}
