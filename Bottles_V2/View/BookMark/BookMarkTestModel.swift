//
//  BookMarkTestModel.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/25.
//

import Foundation

struct BookMarkBottle : Hashable {
    let bottleName: String
    let shopName: String
}

struct BookMarkShop : Hashable {
    let shopName: String
}

class BookMarkTestStore: Identifiable, ObservableObject {
    @Published var BookMarkBottles: [BookMarkBottle] = [
        BookMarkBottle(bottleName: "글렌모렌지 넥타도르", shopName: "와인앤모어 광화문점"),
        BookMarkBottle(bottleName: "글렌모렌지 스피오스", shopName: "와인앤모어 광화문점"),
        BookMarkBottle(bottleName: "글렌모렌지 오리지널 10년", shopName: "와인앤모어 논현점"),
        BookMarkBottle(bottleName: "글렌모렌지 오리지널 20년", shopName: "와인앤모어 서울숲점"),
        BookMarkBottle(bottleName: "글렌모렌지 라산타 12년", shopName: "당근슈퍼"),
        BookMarkBottle(bottleName: "샤도네이 2017", shopName: "비어포스트바"),
        BookMarkBottle(bottleName: "오스본 루비 포트 와인", shopName: "세브도르"),
        BookMarkBottle(bottleName: "밀크앤허니 에이펙스 오렌지 와인", shopName: "에일크루")
    ]
    
    @Published var BookMarkShops: [BookMarkShop] = [
        BookMarkShop(shopName: "비어셀러"),
        BookMarkShop(shopName: "와인앤모어 광화문점"),
        BookMarkShop(shopName: "와인앤모어 서울숲점"),
        BookMarkShop(shopName: "와인앤모어 다산점"),
        BookMarkShop(shopName: "당근슈퍼"),
        BookMarkShop(shopName: "퍼센트"),
        BookMarkShop(shopName: "세미스피어"),
        BookMarkShop(shopName: "와인앤비어"),
        BookMarkShop(shopName: "당근슈퍼 2호점"),
        BookMarkShop(shopName: "링커"),
        BookMarkShop(shopName: "디오니 순천점"),
        BookMarkShop(shopName: "디오니 전주 본점")
        
    ]
}

