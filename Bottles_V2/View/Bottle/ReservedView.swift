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
            .padding()
            
            HStack {
                NavigationLink(destination: CartView() ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .frame(width: 171, height: 51)
                            
                        Text("다른 상품 둘러보기")
                            .font(.system(size: 18, weight: .bold))
                    }
                }
                
                NavigationLink(destination: ReservationPageView(dismiss: $isShowing)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .frame(width: 171, height: 51)
                        Text("예약 확인하기")
                            .font(.system(size: 18, weight: .bold))
                    }
                }
            }
            
        }
        .offset(y: -55)
        
        .sheet(isPresented: $isShowing) {
            BottleShopBookMarkView()
                .presentationDetents([.height(250)])
        }
    }
}

struct ReservedView_Previews: PreviewProvider {
    static var previews: some View {
        ReservedView()
    }
}
