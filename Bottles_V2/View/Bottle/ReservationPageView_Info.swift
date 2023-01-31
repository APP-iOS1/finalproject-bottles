//
//  ReservationPageView_Info.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/31.
//

import SwiftUI

// MARK: - 예약자 정보 (이름, 전화번호, 생년월일)
struct ReservationPageView_Info: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("예약자 정보")
                    .font(.bottles16)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image("arrowBottom")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 9, height: 9)
            }
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    // MARK: - 예약자 이름
                    Text("이름")
                    Text("안은노")
                }
                HStack {
                    // MARK: - 예약자 전화번호
                    Text("전화번호")
                    Text("010-0000-0000")
                }
                HStack {
                    // MARK: - 예약자 생년월일
                    Text("생년월일")
                    Text("1998-00-00")
                }
            }
            .font(.bottles15)
            .fontWeight(.medium)
        }
        .padding()
    }
}

struct ReservationPageView_Info_Previews: PreviewProvider {
    static var previews: some View {
        ReservationPageView_Info()
    }
}
