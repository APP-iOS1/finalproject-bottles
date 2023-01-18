//
//  BottleShopDetailView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct BottleShopDetailView: View {
    @State var showingSheet: Bool = true
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitle("바틀샵 이름")
    }
}

struct BottleShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopDetailView()
    }
}
