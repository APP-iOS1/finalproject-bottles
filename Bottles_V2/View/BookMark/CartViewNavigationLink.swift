//
//  CartViewNavigationLink.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

// CartView로 이동하는 버튼
struct CartViewNavigationLink: View {
    var body: some View {
        NavigationLink {
            CartView()
        } label: {
            Image(systemName: "cart.fill")
                .frame(width: 50, height: 50)
                .background{
                    Color.white
                }
                .cornerRadius(10)
                .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
        }
    }
}

struct CartViewNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        CartViewNavigationLink()
    }
}
