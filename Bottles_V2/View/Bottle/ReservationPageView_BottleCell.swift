//
//  ReservationPageView_BottleCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI

// MARK: - 예약 바틀 셀 (상품 이미지, 상품 이름, 상품 가격, 상품 개수, 바틀샵 이름)
struct ReservationPageView_BottleCell: View {
    var bottleReservation: BottleReservation
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // MARK: - 상품 이미지
            AsyncImage(url: URL(string: bottleReservation.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)
            } placeholder: {
                Image("ready_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)

            }
            .background(Color.gray_f7)
            .cornerRadius(12)
            .frame(height: 128)
            //.padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 9) {
                // MARK: - 상품 이름
                Text(bottleReservation.title)
                    .font(.bottles14)
                    .fontWeight(.medium)
                    
                // MARK: - 상품 가격
                Text("\(bottleReservation.price)원")
                    .font(.bottles18)
                    .fontWeight(.bold)
                    
                // MARK: - 상품 개수
                Text("\(bottleReservation.count)개")
                    .font(.bottles15)
                    .fontWeight(.medium)
            }
            .padding(16)
        }
        .frame(height: 129)
    }
}



//struct ReservationPageView_BottleCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationPageView_BottleCell(bottleReservation: bottle_)
//    }
//}
