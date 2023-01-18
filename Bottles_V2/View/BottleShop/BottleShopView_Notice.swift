//
//  BottleShopView_Notice.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct Notice22: Identifiable, Hashable{
    var id = UUID()
    var category: String
    var contents: String
    var time: String
}

var noticeItems: [Notice22] = [
    Notice22(category: "이벤트", contents: "오픈 기념 할인 이벤트!! 다가오는 연말, 친구 연인 가족과 함께 부담없이 마시기 좋은 스파클링 와인을 추천합니다.", time: "2시간 전"),
    Notice22(category: "공지", contents: "오픈 기념 할인 이벤트!! 다가오는 연말, 친구 연인 가족과 함께 부담없이 마시기 좋은 스파클링 와인을 추천합니다.", time: "1일 전"),
    Notice22(category: "공지", contents: "오픈 기념 할인 이벤트 예정! 곧 추가 공지 올리겠습니다. 많은 기대 부탁드립니다.", time: "1일 전")
]

struct BottleShopView_Notice: View {
    var body: some View {
        VStack{
            ForEach(noticeItems, id: \.self) { item in
                BottleShopView_NoticeCell(selectedItem: Notice22(id: UUID(), category: item.category, contents: item.contents, time: item.time))
            }
        }
    }
}

struct BottleShopView_Notice_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopView_Notice()
    }
}
