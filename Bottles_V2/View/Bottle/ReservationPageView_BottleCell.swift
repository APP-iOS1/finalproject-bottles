//
//  ReservationPageView_BottleCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI

struct ReservationPageView_BottleCell: View {
    var body: some View {
        // MARK: 예약 상품 셀
        HStack {
            // 상품 이미지
            Image("kilchoman")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 129, height: 129)
                .background(Color(UIColor(red: 246/255, green: 243/255, blue: 238/255, alpha: 1.0)))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 5) {
                // 상품 이름
                Text("킬호만 샤닉")
                    .font(.bottles15)
                    .fontWeight(.bold)
                // 상품 가격
                Text("350,000원")
                    .font(.bottles15)
                    .fontWeight(.bold)
                // 상품 개수
                Text("1개")
                    .font(.bottles15)
                    .fontWeight(.medium)
                
                Spacer()
                
                HStack {
                    Image("Map_Tab_fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 11, height: 16)
                    // 바틀샵 이름
                    Text("바틀샵 이름")
                        .font(.bottles15)
                        .fontWeight(.medium)
                }
            }
            .padding(10)
        }
        .frame(height: 129)
    }
}

struct ReservationPageView_BottleCell_Previews: PreviewProvider {
    static var previews: some View {
        ReservationPageView_BottleCell()
    }
}
