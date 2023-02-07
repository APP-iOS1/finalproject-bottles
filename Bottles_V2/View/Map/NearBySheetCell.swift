//
//  NearBySheetCell.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/02/06.
//

import SwiftUI

struct NearBySheetCell: View {
    
    // Shop의 정보를 저장하는 변수
    @State private var checkBookmark: Bool = false
    var shopModel: ShopModel
    var distance: Double
    
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
                    .multilineTextAlignment(.leading)
                
                /// 현재 위치와 바틀샵과의 거리
                /// 초기 distance 값(m) -> km로 환산 후 소수점 1번째 자리까지 제거
                ///  distance -> m 값 분기처리
                if distance/1000 < 1 {
                    Text("\(String(format: "%.0f", round(distance))) m")
                        .font(.bottles14)
                        .foregroundColor(.gray)
                } else {
                    Text("\(String(format: "%.0f", round(distance/1000))) km")
                        .font(.bottles14)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .foregroundColor(.black)
            .padding(.top, 5)
            
            Spacer()
            VStack {
                // TODO: 북마크 기능 추가해야함
                Button {
                    checkBookmark.toggle()
                } label: {
                    Image(systemName: checkBookmark ? "bookmark.fill" : "bookmark")
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
