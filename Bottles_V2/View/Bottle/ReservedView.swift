//
//  ReservedView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct ReservedView: View {
    @State private var isShowing: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            // 예약 상품 이미지
            ZStack {
               Circle()
                    .fill(Color(UIColor(red: 246/255, green: 243/255, blue: 238/255, alpha: 1.0)))
                    .frame(width: 221, height: 221)
                Image("kilchoman")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
            
            }
            
            VStack {
                Text("예약이 완료되었습니다.")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("곧 예약 확정 알림을 보내드릴게요!")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            Spacer()
        }
        .offset(y: 100)
        .sheet(isPresented: $isShowing) {
            BottleShopBookMarkView()
                .presentationDetents([.height(220)])
        }
    }
}

struct ReservedView_Previews: PreviewProvider {
    static var previews: some View {
        ReservedView()
    }
}
