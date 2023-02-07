//
//  ReservationPageView_BottleCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI

// MARK: - 예약 바틀 셀 (상품 이미지, 상품 이름, 상품 가격, 상품 개수, 바틀샵 이름)
struct ReservationPageView_BottleCell: View {
    var bottleReservation: Bottle_reservation
    
    var body: some View {
        HStack(alignment: .top) {
            // MARK: - 상품 이미지
            Image(bottleReservation.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 129, height: 129)
                .background(Color(UIColor(red: 246/255, green: 243/255, blue: 238/255, alpha: 1.0)))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 8) {
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
                
                HStack {
                    Image("Map_Tab_fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 17)
                    // MARK: - 바틀샵 이름
                    Text(bottleReservation.shop)
                        .font(.bottles14)
                        .fontWeight(.medium)
                }
                .padding(.top, 5)
            }
            .padding(10)
        }
        .frame(height: 129)
    }
}



//struct ReservationPageView_BottleCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationPageView_BottleCell(bottleReservation: bottle_)
//    }
//}
