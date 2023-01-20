//
//  BottleShopCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/20.
//

import SwiftUI

struct BottleShopCell: View {
    @State private var checkBookmark: Bool = false
    var body: some View {
        HStack(spacing: 15) {
            Image("bottleShop")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
           
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("바틀샵 이름")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("한 줄 소개 내추럴 와인 포트와인\n위스키 럼 꼬냑")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("주소")
                        .font(.caption)
                        .fontWeight(.medium)
             
                }
                
                Spacer()
                
                Button(action: {
                    checkBookmark.toggle()
                }) {
                    Image(systemName: checkBookmark ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .frame(width: 15, height: 19)
                        .padding(.horizontal, 10)
                }
            }
        }
    }
}

struct BottleShopCell_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopCell()
    }
}
