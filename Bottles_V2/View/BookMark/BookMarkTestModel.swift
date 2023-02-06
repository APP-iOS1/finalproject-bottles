//
//  BookMarkTestModel.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/25.
//

import Foundation

// 테스트용
struct BookMarkBottle : Hashable {
    var bottleName: String
    var shopName: String
    var price: Int
    var distance: Int
    var bookMark: Bool
}

struct BookMarkShop : Hashable {
    var shopName: String
    var distance: Int
    var bookMark: Bool
}

class BookMarkTestStore: Identifiable, ObservableObject {
    @Published var BookMarkBottles: [BookMarkBottle] = [
        BookMarkBottle(bottleName: "글렌모렌지 넥타도르", shopName: "와인앤모어 광화문점", price: 10, distance: 3, bookMark: true),
        BookMarkBottle(bottleName: "글렌모렌지 스피오스", shopName: "와인앤모어 광화문점", price: 6, distance: 5, bookMark: true),
        BookMarkBottle(bottleName: "글렌모렌지 오리지널 10년", shopName: "와인앤모어 논현점", price: 7, distance: 7, bookMark: true),
        BookMarkBottle(bottleName: "글렌모렌지 오리지널 20년", shopName: "와인앤모어 서울숲점", price: 3, distance: 8, bookMark: true),
        BookMarkBottle(bottleName: "글렌모렌지 라산타 12년", shopName: "당근슈퍼", price: 2, distance: 10, bookMark: true),
        BookMarkBottle(bottleName: "샤도네이 2017", shopName: "비어포스트바", price: 8, distance: 2, bookMark: true),
        BookMarkBottle(bottleName: "오스본 루비 포트 와인", shopName: "세브도르", price: 7, distance: 5, bookMark: true),
        BookMarkBottle(bottleName: "밀크앤허니 에이펙스 오렌지 와인", shopName: "에일크루", price: 7, distance: 8, bookMark: true)
    ]
    
    @Published var BookMarkShops: [BookMarkShop] = [
        BookMarkShop(shopName: "비어셀러", distance: 5, bookMark: true),
        BookMarkShop(shopName: "와인앤모어 광화문점", distance: 5, bookMark: true),
        BookMarkShop(shopName: "와인앤모어 서울숲점", distance: 7, bookMark: true),
        BookMarkShop(shopName: "와인앤모어 다산점", distance: 2, bookMark: true),
        BookMarkShop(shopName: "당근슈퍼", distance: 3, bookMark: true),
        BookMarkShop(shopName: "퍼센트", distance: 4, bookMark: true),
        BookMarkShop(shopName: "세미스피어", distance: 8, bookMark: true),
        BookMarkShop(shopName: "와인앤비어", distance: 9, bookMark: true),
        BookMarkShop(shopName: "당근슈퍼 2호점", distance: 10, bookMark: true),
        BookMarkShop(shopName: "링커", distance: 3, bookMark: true),
        BookMarkShop(shopName: "디오니 순천점", distance: 8, bookMark: true),
        BookMarkShop(shopName: "디오니 전주 본점", distance: 5, bookMark: true)
        
    ]
}

