//
//  CartView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import Foundation
import SwiftUI

//MARK: - 장바구니 View
/// 현재 로그인한 사용자의 장바구니를 보여주는 View
// TODO: - 바틀 이미지 데이터 연동, 바틀 이름 데이터 연동

struct CartView: View {
    
    @ObservedObject var cartStore = CartStore()
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
//    // 각각의 항목을 선택하였는지, 전체 선택을 사용하여 선택하였는지를 판별하기 위한 변수
//    @State var isAllSelected: Bool = false
//    @State var allSelectButtonCheck : Bool = false
    
    var body: some View {
        VStack {
            /// 장바구니에 들어있는 품목 목록
            ScrollView {
                
                HStack {
                    Image("Map_tab_fill")
                        .padding(.leading)
                    Text("\(cartStore.shopName)")
                        .font(.bottles20)
                        .bold()
                        
                    Spacer()
                }
                .padding(.top)
                Divider()
                
                ForEach (cartStore.carts) { cart in
                    CartCell(cartStore: cartStore, userStore: userStore, cart: cart, bottle: getBottleModel(bottleId: cart.bottleId))
                    //                    if cart < cartStore.carts.count - 1 {
                    Divider()
                    //                    }
                }
            }
            Divider()
                .background(.black)
            
            // MARK: - View의 하단
            // 총 금액, 예약하기 버튼
            VStack {
                HStack {
                    Text("총 금액")
                        .font(.bottles18)
                        .padding(.leading)
                    Spacer()
                    Text("\(cartStore.totalPrice)원")
                        .font(.bottles18)
                        .bold()
                        .padding(.trailing)
                }
                .padding([.leading, .trailing, .top])
                Text("결제는 각 매장에서 진행됩니다.")
                    .font(.bottles12)
                    .padding(.top)
                
                NavigationLink(destination: ReservationPageView(bottleReservations: getBottleReservation(carts: cartStore.carts))) {
                
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width : UIScreen.main.bounds.size.width-50, height: (UIScreen.main.bounds.size.width-50)/7)
                        .overlay(Text("예약하러 하기")
                            .foregroundColor(.white)
                            .font(.bottles18))
                        .bold()
                }
                .foregroundColor(.accentColor)
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitle("장바구니", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            cartStore.readCart(userEmail: userStore.user.email)
        }
    }
    
    func getBottleModel(bottleId: String) -> BottleModel {
        let matchedBottleData = bottleDataStore.bottleData.filter {
            $0.id == bottleId
        }
        
        return matchedBottleData[0]
    }
    
    func getBottleReservation(carts: [Cart]) -> [BottleReservation] {
        var matchedBottleReservation: [BottleReservation] = []
        var bottleModel: BottleModel
        
        for cart in carts {
            bottleModel = getBottleModel(bottleId: cart.bottleId)
            matchedBottleReservation.append(BottleReservation(image: bottleModel.itemImage, title: bottleModel.itemName, price: cart.eachPrice * cart.itemCount, count: cart.itemCount, shop: cart.shopName))
        }
        
        return matchedBottleReservation
    }
    
    /// CustomNavigationBackButton
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")    // back button 이미지
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.black)
            }
    }
    // MARK: - 전체 선택 버튼
    //      var AllSelectButton : some View {
    //        Button {
    //            allSelectButtonCheck = true
    //            isAllSelected.toggle()
    //        } label : {
    //            Image(systemName: isAllSelected ? "checkmark.circle.fill" : "circle")
    //        }
    //        .padding([.leading, .top, .bottom])
    //
    //    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
