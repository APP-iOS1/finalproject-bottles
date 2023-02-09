//
//  BottleShopView_Notice.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 임의로 공지 아이템이 담긴 구조체 생성 (데이터 연동시 삭제)
struct Notice22: Identifiable, Hashable{
    var id = UUID()
    var category: String
    var contents: String
    var time: String
}


// 임의로 공지 아이템 데이터 생성 (데이터 연동시 삭제)
var noticeItems: [Notice22] = [
    Notice22(category: "이벤트", contents: "오픈 기념 할인 이벤트!! 다가오는 연말, 친구 연인 가족과 함께 부담없이 마시기 좋은 스파클링 와인을 추천합니다.", time: "2시간 전"),
    Notice22(category: "공지", contents: "오픈 기념 할인 이벤트!! 다가오는 연말, 친구 연인 가족과 함께 부담없이 마시기 좋은 스파클링 와인을 추천합니다.", time: "1일 전"),
    Notice22(category: "공지", contents: "오픈 기념 할인 이벤트 예정! 곧 추가 공지 올리겠습니다. 많은 기대 부탁드립니다.", time: "1일 전")
]

// 바틀샵뷰 내 "사장님의 공지" 뷰
struct BottleShopView_Notice: View {
    var shopData: ShopModel
    
    @EnvironmentObject var shopNoticeDataStore: ShopNoticeDataStore
    
    var body: some View {
        VStack{
            // 데이터 연동 시 "해당 샵의 공지 리스트" 연동
            // 공지 셀 반복문
            ForEach(filterShopNotice(), id: \.self) { item in
                BottleShopView_NoticeCell(
                    selectedItem: ShopNotice(id: item.id, category: item.category, shopName: item.shopName, date: item.date, title: item.title, body: item.body))
            }
        }
    }
    
    func filterShopNotice() -> [ShopNotice] {
        return shopNoticeDataStore.shopNoticeData.filter { $0.shopName == shopData.shopName }
    }
}

//struct BottleShopView_Notice_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopView_Notice()
//    }
//}
