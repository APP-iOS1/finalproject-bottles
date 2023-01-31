//
//  MapViewSearchBar.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct MapViewSearchBar: View {
    
    @Binding var mapSearchBarText: String
    
    var body: some View {
        HStack {
            TextField("바틀샵/상품을 입력해주세요", text: $mapSearchBarText)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
                .font(.bottles15)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.accentColor)
                .bold()
            if !mapSearchBarText.isEmpty {
                Button(action: {
                    
                    self.mapSearchBarText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                }
            } else {
                EmptyView()
            }
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

struct MapViewSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        MapViewSearchBar(mapSearchBarText: .constant(""))
    }
}
