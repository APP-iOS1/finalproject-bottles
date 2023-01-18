//
//  SearchViewNavigationLabel.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchViewNavigationLabel: View {
    var body: some View {
        HStack {
            HStack {
                Text("원하는 술, 바틀샵 검색")
                    .foregroundColor(.black)
                    .padding(.leading, 5)
                Spacer()
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.accentColor)
                    .bold()
                    .padding(.trailing, 5)
            }
            .padding(10)
            .frame(width: 300, alignment: .leading)
            .background{
                Color.white
            }
            .cornerRadius(10)
            .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
        }
    }
}
struct SearchViewNavigationLabel_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewNavigationLabel()
    }
}
