//
//  BottleShopView_NoticeCell.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct BottleShopView_NoticeCell: View {
    
    var selectedItem: Notice22
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                VStack{
                    HStack{
                        Text(selectedItem.category)
                            .fontWeight(.bold)
                        Spacer()
                        
                        Text(selectedItem.time)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 1)
                    Text(selectedItem.contents)
                        .fontWeight(.medium)
                        .frame(alignment: .center)
                    
                }
            }
            .padding()
            Divider()
            

        }
        .font(.system(size: 15))
        .foregroundColor(.black)
    }
}

struct BottleShopView_NoticeCell_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopView_NoticeCell(selectedItem: Notice22(id: UUID(), category: "공지", contents: "오픈 기념 할인 이벤트!! 다가오는 연말, 친구 / 연인 / 가족과 함께 부담없이 마시기 좋은 스파클링 와인을 추천합니다.", time: "2시간 전"))
    }
}
