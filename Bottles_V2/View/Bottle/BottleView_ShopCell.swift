//
//  BottleView_ShopCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/20.
//

import SwiftUI

struct BottleView_ShopCell: View {
    @State private var checkBookmark: Bool = false
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // 바틀샵 이미지
            Image("bottleShop")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    // 바틀샵 이름
                    Text("바틀샵 이름")
                        .font(.bottles20)
                        .fontWeight(.bold)
                    // 바틀샵 소개
                    Text("한 줄 소개 내추럴 와인 포트와인\n위스키 럼 꼬냑")
                        .font(.bottles12)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                // 북마크
                Button(action: {
                    checkBookmark.toggle()
                }) {
                    Image(checkBookmark ? "BookMark.fill" : "BookMark")
                        .resizable()
                        .frame(width: 15, height: 19)
                        .padding(.horizontal, 10)
                }
            }
            .padding(.vertical)
        }
    }
}

struct BottleView_ShopCell_Previews: PreviewProvider {
    static var previews: some View {
        BottleView_ShopCell()
    }
}
