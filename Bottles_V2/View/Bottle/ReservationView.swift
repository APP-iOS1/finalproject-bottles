//
//  ReservationView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct ReservationView: View {
    @State private var count: Int = 1
    @State private var isShowingCart: Bool = false
    @State private var isShowingReservationPage: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 25) {
                // 픽업 매장
                VStack(alignment: .leading, spacing: 7) {
                    Text("픽업 매장")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("바틀샵 이름")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
       
                // 픽업 안내
                VStack(alignment: .leading, spacing: 7) {
                    Text("픽업 안내")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        
                    Text("예약 후 예약 확정 알림이 올 때까지 기다려주세요.\n예약 확정 알림을 받은 뒤 3일 이내에 픽업해주세요.")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
                
                // 수량
                HStack {
                    Text("수량")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // 수량 제한 버튼
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 200)
                            .stroke(.black, lineWidth: 1)
                            .frame(width: 140, height: 37)
                        HStack {
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
                            Text("\(count)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Spacer()
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
                // 장바구니 담기 및 예약 버튼
                HStack {
                    Button(action: {
                        isShowingCart.toggle()
                        
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                                .frame(width: 171, height: 51)
                                
                            Text("장바구니 담기")
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                    .fullScreenCover(isPresented: $isShowingCart) {
                        CartView()
                    }
    
                    Button(action: {
                        isShowingReservationPage.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                                .frame(width: 171, height: 51)
                            Text("바로 예약하기")
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                    .fullScreenCover(isPresented: $isShowingReservationPage) {
                        ReservationPageView(dismiss: $isShowingReservationPage)
                    }
                }
            }
        }
        .padding()
    }
}

//struct ReservationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationView(isShowingReservationView: <#Binding<Bool>#>)
//    }
//}
