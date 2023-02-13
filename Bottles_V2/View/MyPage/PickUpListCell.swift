//
//  PickUpListCell.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct PickUpListCell: View {
    
    let reservationData: ReservationModel
    
    var body: some View {
        VStack{
            // MARK: - 예약 일자, 예약 상태 HStack
            HStack {
                Text("2023.01.18")
                    .font(.bottles15)
                    .bold()
                Spacer()
                
                Text("\(reservationData.state)")
                    .font(.bottles12)
                    .overlay{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke()
                            .frame(width: 80, height: 30)
                    }
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            }
            .padding(.vertical)
            
            // MARK: - 픽업 매장, 상품명 HStack
            HStack{
                VStack(alignment:.leading){
                    Text("픽업 매장")
                        .padding(.bottom, -3)
                    Text("상품 명")
                }
                VStack(alignment:.leading){
                    Text("\(reservationData.shopID)")
                        .padding(.bottom, -3)
                    Text("디 오리지널 골드바 위스키")
                }
                Spacer()
            }
            .font(.bottles13)
        }
        .foregroundColor(.black)
        .padding(.horizontal)
    }
}

struct PickUpListCell_Previews: PreviewProvider {
    static var previews: some View {
        PickUpListCell()
    }
}
