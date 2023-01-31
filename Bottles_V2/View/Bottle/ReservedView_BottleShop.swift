//
//  ReservedView_BottleShop.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct ReservedView_BottleShop: View {
    @State private var checkBookmark: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("픽업 바틀샵 저장하기")
                .font(.bottles16)
                .fontWeight(.bold)
            
            // MARK: - 픽업한 바틀샵
            BottleView_ShopCell()
        }
        .padding()
    }
}

struct ReservedView_BottleShop_Previews: PreviewProvider {
    static var previews: some View {
        ReservedView_BottleShop()
    }
}
