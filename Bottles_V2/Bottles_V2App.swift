//
//  Bottles_V2App.swift
//  Bottles_V2
//
//  Created by mac on 2023/01/17.
//

import SwiftUI
import UIKit
import FirebaseCore
import FirebaseFirestore

@main
struct Bottles_V2App: App {
    
    @ObservedObject var userDataStore = UserStore()
    @ObservedObject var bottleDataStore = BottleDataStore()
    @ObservedObject var shopDataStore = ShopDataStore()
    @ObservedObject var reservationDataStore = ResevationDataStore()
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
                .environmentObject(userDataStore)
                .task {
                    userDataStore.readUser(userId: "test@naver.com")
                    await shopDataStore.getAllShopData()
                    await bottleDataStore.getAllBottleData()
                    await reservationDataStore.getAllResevationData()
                }
            
            // MARK: - AccentColor 적용
                .accentColor(Color("AccentColor"))
        }
    }
}
