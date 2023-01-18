//
//  ContentView.swift
//  Bottles_V2
//
//  Created by mac on 2023/01/17.
//

import SwiftUI

struct ContentView: View {

//    @EnvironmentObject var dataStore : DataStore
    
    var body: some View {
        VStack {
            BottleShopView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataStore())
    }
}
