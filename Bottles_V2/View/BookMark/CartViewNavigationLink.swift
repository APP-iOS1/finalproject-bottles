//
//  CartViewNavigationLink.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct CartViewNavigationLink: View {
    var body: some View {
        NavigationLink {
            
        } label: {
            Image(systemName: "cart.fill")
                .frame(width: 42, height: 42)
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
