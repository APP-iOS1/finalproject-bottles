//
//  NearBySheetCell.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/02/06.
//

import SwiftUI

struct NearBySheetCell: View {
    // Shop의 정보를 저장하는 변수
    var shopModel: ShopModel
    
    var body: some View {
        HStack(alignment: .top) {
            // Shop 이미지
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 120, height: 120)
                .overlay {
                    AsyncImage(url: URL(string: shopModel.shopTitleImage)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .cornerRadius(10)
                    } placeholder: {
                        Image("ready_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                // Shop 이름
                Text(shopModel.shopName)
                    .font(.bottles18)
                    .bold()
                // Shop 소개글
                Text(shopModel.shopIntroduction)
                    .font(.bottles14)
                Spacer()
            }
            .foregroundColor(.black)
            .padding(.top, 5)
            
            Spacer()
            VStack {
                // TODO: 즐겨찾기 기능 추가해야함
                Button {
                    
                } label: {
                    Image(systemName: "bookmark.fill")
                }
                Spacer()
            }
            .font(.title2)
            .padding()
            .padding(.top, -5)
        }
        .frame(height: 130)
        .padding(.vertical, 5)
    }
}

//struct NearBySheetCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NearBySheetCell()
//    }
//}
