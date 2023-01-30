//
//  ContentView.swift
//  Bottles_V2
//
//  Created by mac on 2023/01/17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var shopStore : ShopStore
    
    var body: some View {
        VStack {
            Button {
                Task{
                    await shopStore.getData()
                }
            } label: {
                Text("서버로부터 데이터 수신!")
            }
            
            List {
                ForEach(shopStore.shop ?? [], id: \.id) { shop in
                    Text(shop.shopName ?? "test")
                }
            }
        }
        .padding()
        .task {
            await shopStore.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ShopStore())
    }
}
