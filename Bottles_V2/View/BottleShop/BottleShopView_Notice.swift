//
//  BottleShopView_Notice.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct BottleShopView_Notice: View {
    var body: some View {
        VStack{
            Text("이벤트")
        }
        .fontWeight(.light)
        .padding(.vertical, 5)
        .frame(minWidth: 350, maxWidth: 350, minHeight: 80, maxHeight: .infinity, alignment: .leading)
        .font(.system(size: 14))
        .foregroundColor(.black)
    }
}

struct BottleShopView_Notice_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopView_Notice()
    }
}
