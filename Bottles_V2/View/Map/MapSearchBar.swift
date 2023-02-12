//
//  MapSearchBar.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/02/10.
//

import SwiftUI

struct MapSearchBar: View {
    
    var body: some View {
        HStack {
            Text("바틀샵/상품을 입력해주세요")
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
            Spacer()
            Image("magnifyingglass")
        }
        .padding(10)
        .frame(width: 300)
        
        
        .background{
            Color.white
        }
        .cornerRadius(10)
        .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
    }
}

struct MapSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchBar()
    }
}
