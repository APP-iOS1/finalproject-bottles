//
//  BottleShopBookMarkView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct BottleShopBookMarkView: View {
    @State private var checkBookmark: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("픽업 바틀샵 저장하기")
                .font(.callout)
                .fontWeight(.bold)
            
            BottleShopCell()
        }
        .padding()
    }
}

struct BottleShopBookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopBookMarkView()
    }
}
