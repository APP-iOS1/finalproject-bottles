//
//  ReservationPageView_Info.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/31.
//

import SwiftUI

// MARK: - 예약자 정보 (이름, 전화번호, 생년월일)
struct ReservationPageView_Info: View {
    @State private var hiddenInfo = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("예약자 정보")
                    .font(.bottles16)
                    .fontWeight(.medium)
                
                Spacer()
                
                Button(action: {
                    hiddenInfo.toggle()
                }) {
                    Image("arrowBottom")
                        .resizable()
                        .frame(width: 10, height: 6)
                }
            }
            if !hiddenInfo {
                VStack(alignment: .leading, spacing: 7) {
                    HStack(spacing: 13) {
                        // MARK: - 예약자 이름
                        Text("이름")
                            .frame(width: 55, alignment: .leading)
                        Text("안은노")
                    }
                    HStack(spacing: 13) {
                        // MARK: - 예약자 전화번호
                        Text("전화번호")
                            .frame(width: 55, alignment: .leading)
                        Text("010 - 0000 - 0000")
                    }
                    HStack(spacing: 13) {
                        // MARK: - 예약자 생년월일
                        Text("생년월일")
                            .frame(width: 55, alignment: .leading)
                        Text("1998 - 00 - 00")
                    }
                }
                .font(.bottles14)
                .fontWeight(.regular)
            }
        }
    }
}

struct ReservationPageView_Info_Previews: PreviewProvider {
    static var previews: some View {
        ReservationPageView_Info()
    }
}
