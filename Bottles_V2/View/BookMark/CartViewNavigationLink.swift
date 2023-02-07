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
            Image("cart")
                .frame(width: 52, height: 52)
                .background{
                    Color.gray_f7
                }
                .cornerRadius(12)
        }
    }
}

struct CartViewNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        CartViewNavigationLink()
    }
}
