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
    //@EnvironmentObject var path: Path
    @State private var isShowingMessage: Bool = false
    @State private var isShowingCart: Bool = false
    @State private var isShowingReservationPage: Bool = false
    @Binding var count: Int
    @Binding var isShowingAnotherShopAlert: Bool
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @EnvironmentObject var cartStore: CartStore
    @EnvironmentObject var userStore: UserStore
    
    var bottleData: BottleModel
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                    
                    // MARK: 장바구니 담기 버튼 및 바로 예약하기 버튼
                    HStack {
                        // MARK: - 장바구니 담기 버튼
                        Button(action: {
                            if (cartStore.shopName == bottleData.shopName) || (cartStore.shopName == "")  {
                                cartStore.addCart(cart: Cart(id: UUID().uuidString, bottleId: bottleData.id, eachPrice: bottleData.itemPrice, itemCount: count, shopId: bottleData.shopID, shopName: bottleData.shopName), userEmail: userStore.user.email)
                                withAnimation(.easeOut(duration: 1.5)) {
                                    isShowingMessage = true
                                    print("장바구니 추가")
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    isShowingMessage = false
                                }
                            }
                            else {
                                isShowingAnotherShopAlert.toggle()
                            }
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
                        
                        // MARK: - 바로 예약하기 버튼
                        //                NavigationLink(value: "") {
                        //                    ZStack {
                        //                        RoundedRectangle(cornerRadius: 12)
                        //                            .frame(width: UIScreen.main.bounds.width/2-20, height: 57)
                        //                        Text("바로 예약하기")
                        //                            .modifier(AccentColorButtonModifier())
                        //                    }
                        //                }
                        //                .navigationDestination(for: String.self) { _ in
                        //                    ReservationPageView()
                        //                        .environmentObject(path)
                        //                }
                        
                        NavigationLink(destination: ReservationPageView(bottleReservations: getBottleReservation(bottleData: bottleData))) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: UIScreen.main.bounds.width/2-20, height: 57)
                                Text("바로 예약하기")
                                    .modifier(AccentColorButtonModifier())
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
                .padding(.bottom, 33)
                
                // MARK: - 장바구니에 상품 추가 시 표시되는 토스트 메세지
                CartToastMessage(isShowingMessage: $isShowingMessage, isShowingCart: $isShowingCart)
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .navigationDestination(isPresented: $isShowingCart) {
            CartView()
        }
    }
    
    func getBottleReservation(bottleData: BottleModel) -> [BottleReservation] {
        var matchedBottleReservation: [BottleReservation] = []
        
        matchedBottleReservation.append(BottleReservation(id: bottleData.id, image: bottleData.itemImage, title: bottleData.itemName, price: bottleData.itemPrice, count: count, shop: bottleData.shopName))
        
        return matchedBottleReservation
        
    }
    
}
//struct ReservationView_Content_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationView(isShowingReservationView: <#Binding<Bool>#>)
//    }
//}

