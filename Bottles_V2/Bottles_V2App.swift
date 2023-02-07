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
    // coreData
    @StateObject var dataController = DataController()
    
    @StateObject var googleLoginViewModel: GoogleLoginViewModel = GoogleLoginViewModel()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            TotalLoginView()
                .environmentObject(UserStore()).environmentObject(googleLoginViewModel)
//            MainTabView()
            // coreData
//                .environment(\.managedObjectContext, dataController.container.viewContext)
            //LaunchView()
//            LaunchView()
//            // coreData
//                .environment(\.managedObjectContext, dataController.container.viewContext)
//                .environmentObject(bottleDataStore)
//                .environmentObject(shopDataStore)
//                .environmentObject(reservationDataStore)
//                .task {
//                    await shopDataStore.getAllShopData()
//                    await bottleDataStore.getAllBottleData()
//                    await reservationDataStore.getAllResevationData()
//                }
            
            // MARK: - AccentColor 적용
                .accentColor(Color("AccentColor"))
        }
    }
}
