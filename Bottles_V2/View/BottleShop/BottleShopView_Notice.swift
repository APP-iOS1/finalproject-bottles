//
//  BottleShopView_Notice.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 바틀샵뷰 내 "사장님의 공지" 뷰
struct BottleShopView_Notice: View {
    var shopData: ShopModel
    
    @EnvironmentObject var shopNoticeDataStore: ShopNoticeDataStore
    
    var body: some View {
        VStack{
            
            if filterShopNotice().count == 0 {
                VStack{
                    Spacer()
                        .frame(height: 100)
                    
                    Image(systemName: "note")
                        .font(.system(size: 50))
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("공지가 아직 없어요!")
                        .font(.bottles18)
                        .fontWeight(.semibold)
                    
                    Spacer()
                        .frame(height: 100)
                }
                .foregroundColor(.gray)
                
            } else {
                // 데이터 연동 시 "해당 샵의 공지 리스트" 연동
                // 공지 셀 반복문
                ForEach(filterShopNotice(), id: \.self) { item in
                    BottleShopView_NoticeCell(
                        selectedItem: ShopNotice(id: item.id, category: item.category, shopName: item.shopName, date: item.date, title: item.title, body: item.body))
                }
            }
        }
//        .padding(.horizontal, 15)
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
