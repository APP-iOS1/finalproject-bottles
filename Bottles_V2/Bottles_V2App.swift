//
//  Bottles_V2App.swift
//  Bottles_V2
//
//  Created by mac on 2023/01/17.
//

import SwiftUI
import UIKit
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth


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
        KakaoSDK.initSDK(appKey: "f2abf38572d20d5dde71ea5c33a02c07")
    }
    
    var body: some Scene {
        
        WindowGroup {
            TotalLoginView()
                .environmentObject(UserStore()).environmentObject(googleLoginViewModel)
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
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
