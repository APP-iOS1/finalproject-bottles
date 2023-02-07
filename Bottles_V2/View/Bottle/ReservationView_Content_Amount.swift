//
//  ReservationView_Content_Amount.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/06.
//

import SwiftUI

// MARK: - 바틀 예약 수량
struct ReservationView_Content_Amount: View {
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text("수량")
                .modifier(titleModifier())
            
            Spacer()
            
            // MARK: - 수량 선택 버튼
            ZStack {
                RoundedRectangle(cornerRadius: 200)
                    .stroke(.black.opacity(0.2), lineWidth: 1)
                    .frame(width: 140, height: 37)
                HStack {
                    // MARK: - -버튼
                    Button(action: {
                        if count > 1 {
                            count -= 1
                        }
                    }) {
                        Image(systemName: "minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 13, height: 13)
                    }
                    
                    Spacer()
                    
                    // MARK: - 선택 수량
                    Text("\(count)")
                        .font(.bottles15)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // MARK: - +버튼
                    Button(action: {
                        count += 1
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 13, height: 13)
                    }
                }
                .frame(width: 110, height: 30)
            }
        }
    }
}

//struct ReservationView_Content_Amount_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationView_Content_Amount()
//    }
//}
