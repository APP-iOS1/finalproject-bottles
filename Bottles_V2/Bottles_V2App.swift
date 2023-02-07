//
//  Bottles_V2App.swift
//  Bottles_V2
//
//  Created by mac on 2023/01/17.
//

import SwiftUI
import UIKit
import FirebaseCore

@main
struct Bottles_V2App: App {
    
    @ObservedObject var bottleDataStore = BottleDataStore()
    @ObservedObject var shopDataStore = ShopDataStore()
    @ObservedObject var reservationDataStore = ResevationDataStore()
    @ObservedObject var mapViewModel = MapViewModel()
    // coreData
    @StateObject var dataController = DataController()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            TotalLoginView()
//                .environmentObject(UserStore())
//            MainTabView()
            // coreData
//                .environment(\.managedObjectContext, dataController.container.viewContext)
            //LaunchView()
            LaunchView()
            // coreData
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(bottleDataStore)
                .environmentObject(shopDataStore)
                .environmentObject(reservationDataStore)
                .environmentObject(mapViewModel)
                .task {
                    await shopDataStore.getAllShopData()
                    await bottleDataStore.getAllBottleData()
                    await reservationDataStore.getAllResevationData()
                }
            
            // MARK: - AccentColor 적용
                .accentColor(Color("AccentColor"))
        }
    }
}
