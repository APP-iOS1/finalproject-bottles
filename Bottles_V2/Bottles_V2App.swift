//
//  Bottles_V2App.swift
//  Bottles_V2
//
//  Created by mac on 2023/01/17.
//

import SwiftUI
import UIKit

@main
struct Bottles_V2App: App {
//    @ObservedObject var sessionManager = SessionManager()
    @ObservedObject var bottleDataStore = BottleDataStore()
    @ObservedObject var shopDataStore = ShopDataStore()
    @ObservedObject var userDataStore = UserDataStore()
   

    var body: some Scene {
        WindowGroup {
            MainTabView()
//            switch sessionManager.authState{
//            case .login:
//                LoginView()
//                    .environmentObject(sessionManager)
//
//            case .signUp:
//                SignUpView()
//                    .environmentObject(sessionManager)
//
//            case .confirmCode(let username):
//                ConfirmationView(username: username)
//                    .environmentObject(sessionManager)
//
//            case .session(let user):
//                MainTabView(user: user)
//                .environmentObject(sessionManager)
//                .environmentObject(bottleDataStore)
//                .environmentObject(shopDataStore)
//                .environmentObject(userDataStore)
//            }
        }
    }
}
