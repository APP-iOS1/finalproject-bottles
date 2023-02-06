//
//  ReservationView_Content.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

// MARK: - 예약하기
/// 픽업 안내 사항을 확인하고 바틀의 수량을 선택하는 뷰 입니다.
struct ReservationView_Content: View {
    @State private var count: Int = 1
    @State private var isShowingAlert: Bool = false
    @State private var isShowingCart: Bool = false
    @State private var isShowingReservationPage: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 25) {
                // MARK: - 픽업 매장 이름, 주소
                VStack(alignment: .leading, spacing: 5) {
                    Text("픽업 매장")
                        .modifier(titleModifier())
                        .padding(.bottom, 4)
                    Group {
                        Text("미들바틀")
                        Text("서울 광진구 면목로7길 8 1층")
                    }
                    .modifier(contentModifier())
                }
       
                // MARK: - 픽업 안내
                VStack(alignment: .leading, spacing: 5) {
                    Text("픽업 안내")
                        .modifier(titleModifier())
                        .padding(.bottom, 4)
                        
                    Group {
                        Text("예약 후 예약 확정 알림이 올 때까지 기다려주세요.")
                        Text("예약 확정 알림을 받은 뒤 3일 이내에 픽업해주세요.")
                    }
                    .modifier(contentModifier())
                }
                
                // 바틀 예약 수량
                ReservationView_Content_Amount(count: $count)
                
            }
            // MARK: 장바구니 담기 버튼 및 바로 예약하기 버튼
            HStack {
                // MARK: - 장바구니 담기 버튼
                Button(action: {
                    isShowingAlert.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("AccentColor").opacity(0.1))
                            .frame(width: UIScreen.main.bounds.width/2-20, height: 57)
                        Text("장바구니 담기")
                            .font(.bottles20)
                            .fontWeight(.medium)
                    }
                }
                // 장바구니 담기 버튼 클릭 시 Alert창 present
                .alert("상품이 장바구니에 담겼습니다.\n지금 확인하시겠습니까?" ,isPresented: $isShowingAlert) {
                    Button("OK", role: .destructive) { isShowingCart.toggle() }
                    Button("cancel", role: .cancel) { }
                }
                // Alert창에서 OK 버튼 클릭 시 장바구니 뷰로 이동
                .navigationDestination(isPresented: $isShowingCart) {
                    CartView()
                }
             
                // MARK: - 바로 예약하기 버튼
                NavigationLink(destination: ReservationPageView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: UIScreen.main.bounds.width/2-20, height: 57)
                        Text("바로 예약하기")
                            .modifier(AccentColorButtonModifier())
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 10)
        }
        .padding(.top)
        .padding(.horizontal)
    }
}


//struct ReservationView_Content_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationView(isShowingReservationView: <#Binding<Bool>#>)
//    }
//}
