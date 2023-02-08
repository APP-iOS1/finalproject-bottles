//
//  CartCell.swift
//  Bottles_V2
//
//  Created by 장다영 on 2023/01/18.
//

import SwiftUI

// MARK: - 장바구니 Cell
/// 장바구니 리스트의 셀
///
struct CartCell: View {
    
    var cartStore: CartStore
    var userStore: UserStore
    var cart: Cart
    var bottle: BottleModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // MARK: - 바틀 이미지
            AsyncImage(url: URL(string: bottle.itemImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)
            } placeholder: {
                Image("ready_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)

            }
            .background(Color.gray_f7)
            .cornerRadius(12)
            .frame(height: 128)
            .padding(.horizontal)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        // MARK: - 바틀 이름
                        Text(bottle.itemName)
                            .font(.bottles14)
                            .fontWeight(.medium)
                        Spacer()
                        
                        deleteButton
                            .padding(.trailing)
                    }
                    
                    // MARK: - 바틀 가격
                    Text("\(cart.eachPrice * cart.itemCount)")
                        .font(.bottles18)
                        .fontWeight(.bold)
                    
                    increaseButtonView
                        .padding(.top)
                }
                .foregroundColor(.black)
                
                Spacer()
                
                
            }
            .padding(.top, 10)
        }
    }
    
    // MARK: -View : 삭제 버튼
    private var deleteButton : some View {
        Button {
            cartStore.deleteCart(cart: cart, userEmail: userStore.user.email)
        } label : {
            Image(systemName: "multiply")
                .foregroundColor(.black)
        }
        //.padding(.bottom, 20)
    }
    
    // MARK: -View : 수량 관리 버튼
    private var increaseButtonView : some View {
        // MARK: - 수량 선택 버튼
        ZStack {
            RoundedRectangle(cornerRadius: 200)
                .stroke(.black.opacity(0.2), lineWidth: 1)
                .frame(width: 140, height: 37)
            HStack {
                // MARK: - -버튼
                Button(action: {
                    if cart.itemCount > 1 {
                        cartStore.manageItemCount(cart: cart, userEmail: userStore.user.email, op: "-")
                    }
                }) {
                    Image(systemName: "minus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 13, height: 13)
                }
                
                Spacer()
                
                // MARK: - 선택 수량
                Text("\(cart.itemCount)")
                    .font(.bottles15)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                Spacer()
                
                // MARK: - +버튼
                Button(action: {
                    cartStore.manageItemCount(cart: cart, userEmail: userStore.user.email, op: "+")
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

}

//struct CartCell_Previews: PreviewProvider {
//    @State var test = false
//    static var previews: some View {
//        CartCell(isAllSelected: .constant(false), allSelectButtonCheck: .constant(false))
//    }
//}
