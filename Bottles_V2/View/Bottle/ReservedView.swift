//
//  ReservedView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct ReservedView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowing: Bool = true
    
    var body: some View {
        // MARK: 예약 완료
        NavigationStack {
            ZStack {
               Circle()
                    .fill(Color(UIColor(red: 246/255, green: 243/255, blue: 238/255, alpha: 1.0)))
                    .frame(width: 221, height: 221)
                // 예약 상품 이미지
                Image("kilchoman")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
            
            }
            
            VStack {
                Text("예약이 완료되었습니다.")
                    .font(.bottles20)
                    .fontWeight(.bold)
                Text("곧 예약 확정 알림을 보내드릴게요!")
                    .font(.bottles20)
                    .fontWeight(.bold)
            }
            .padding()
            
            HStack {
                // 다른 상품 보러가기
                NavigationLink(destination: BottleShopView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 171, height: 51)
                        Text("다른 상품 보러가기")
                            .foregroundColor(.white)
                            .font(.bottles18)
                            .fontWeight(.bold)
                    }
                }
                
                // 예약 확인
                NavigationLink(destination: PickUpDetailView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 171, height: 51)
                        Text("예약 확인하기")
                            .foregroundColor(.white)
                            .font(.bottles18)
                            .fontWeight(.bold)
                    }
                }
            }
            
        }
        .offset(y: -110)
        .sheet(isPresented: $isShowing) {
            ReservedView_BottleShop()
                .presentationDetents([.height(210)])
        }
    }
}

struct ReservedView_Previews: PreviewProvider {
    static var previews: some View {
        ReservedView()
    }
}
