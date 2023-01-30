//
//  BookMarkTestModel.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/25.
//

import Foundation

struct BookMarkBottle : Hashable {
    let BottleName: String
    let ShopName: String
}

struct BookMarkShop : Hashable {
    let ShopName: String
}

class BookMarkTestStore: Identifiable, ObservableObject {
    @Published var BookMarkBottles: [BookMarkBottle] = [
        BookMarkBottle(BottleName: "글렌모렌지 넥타도르", ShopName: "와인앤모어 광화문점"),
        BookMarkBottle(BottleName: "글렌모렌지 스피오스", ShopName: "와인앤모어 광화문점"),
        BookMarkBottle(BottleName: "글렌모렌지 오리지널 10년", ShopName: "와인앤모어 논현점"),
        BookMarkBottle(BottleName: "글렌모렌지 오리지널 20년", ShopName: "와인앤모어 서울숲점"),
        BookMarkBottle(BottleName: "글렌모렌지 라산타 12년", ShopName: "당근슈퍼"),
        BookMarkBottle(BottleName: "샤도네이 2017", ShopName: "비어포스트바"),
        BookMarkBottle(BottleName: "오스본 루비 포트 와인", ShopName: "세브도르"),
        BookMarkBottle(BottleName: "밀크앤허니 에이펙스 오렌지 와인", ShopName: "에일크루")
    ]
    
    @Published var BookMarkShops: [BookMarkShop] = [
        BookMarkShop(ShopName: "비어셀러"),
        BookMarkShop(ShopName: "와인앤모어 광화문점"),
        BookMarkShop(ShopName: "와인앤모어 서울숲점"),
        BookMarkShop(ShopName: "와인앤모어 다산점"),
        BookMarkShop(ShopName: "당근슈퍼"),
        BookMarkShop(ShopName: "퍼센트"),
        BookMarkShop(ShopName: "세미스피어"),
        BookMarkShop(ShopName: "와인앤비어"),
        BookMarkShop(ShopName: "당근슈퍼 2호점"),
        BookMarkShop(ShopName: "링커"),
        BookMarkShop(ShopName: "디오니 순천점"),
        BookMarkShop(ShopName: "디오니 전주 본점")
        
    ]
}

