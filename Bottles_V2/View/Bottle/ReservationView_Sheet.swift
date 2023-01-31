//
//  ReservationView_Sheet.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct ReservationView_Sheet: View {
    @State private var count: Int = 1
    @State private var isShowingAlert: Bool = false
    @State private var isShowingCart: Bool = false
    @State private var isShowingReservationPage: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 25) {
                // MARK: - 픽업 매장 이름
                VStack(alignment: .leading, spacing: 7) {
                    Text("픽업 매장")
                        .font(.bottles15)
                        .fontWeight(.bold)
                    Text("바틀샵 이름")
                        .font(.bottles13)
                        .fontWeight(.medium)
                }
       
                // MARK: - 픽업 안내
                VStack(alignment: .leading, spacing: 7) {
                    Text("픽업 안내")
                        .font(.bottles15)
                        .fontWeight(.bold)
                        
                    Text("예약 후 예약 확정 알림이 올 때까지 기다려주세요.\n예약 확정 알림을 받은 뒤 3일 이내에 픽업해주세요.")
                        .font(.bottles13)
                        .fontWeight(.medium)
                        .frame(height: 45)
                }
                
                // MARK: - 바틀 예약 수량
                HStack {
                    Text("수량")
                        .font(.bottles15)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // MARK: - 수량 제한 버튼
                    ZStack {
                        RoundedRectangle(cornerRadius: 200)
                            .stroke(.black, lineWidth: 1)
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
                                .fontWeight(.medium)
                            
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
                // MARK: 장바구니 담기 버튼 및 바로 예약하기 버튼
                HStack {
                    // MARK: - 장바구니 담기 버튼
                    Button(action: {
                        isShowingAlert.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width/2-20, height: 51)
                            Text("장바구니 담기")
                                .modifier(AccentColorButtonModifier())
                        }
                    }
                    .alert("상품이 장바구니에 담겼습니다.\n지금 확인하시겠습니까?" ,isPresented: $isShowingAlert) {
                        Button("OK", role: .destructive) { isShowingCart.toggle() }
                        Button("cancel", role: .cancel) { }
                    }
                    .navigationDestination(isPresented: $isShowingCart) {
                        CartView()
                    }
                 
                    // MARK: - 바로 예약하기 버튼
                    NavigationLink(destination: ReservationPageView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width/2-20, height: 51)
                            Text("바로 예약하기")
                                .modifier(AccentColorButtonModifier())
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        
    }

}

//struct ReservationView_Sheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationView(isShowingReservationView: <#Binding<Bool>#>)
//    }
//}
