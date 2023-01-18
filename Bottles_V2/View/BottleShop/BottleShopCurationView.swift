//
//  BottleShopCurationView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct BottleShopCurationView: View {
    var body: some View {
        ScrollView{
            VStack{
                ForEach(bottleItems, id: \.self) { item in
                    NavigationLink(destination: BottleView(), label:{
                        BottleShopView_BottleList(selectedItem: BottleItem22(name: item.name, price: item.price, category: item.category, tag: item.tag, use: item.use))
                    })
                    
                }
            }
            .navigationBarTitle("바틀샵 이름")
        }
    }
}

struct BottleShopCurationView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopCurationView()
    }
}
