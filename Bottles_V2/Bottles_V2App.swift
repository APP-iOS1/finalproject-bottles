//
//  Bottles_V2App.swift
//  Bottles_V2
//
//  Created by mac on 2023/01/17.
//

import SwiftUI
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin
import AWSCognitoAuthPlugin
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        do {
            try Amplify.configure()
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
        return true
    }
}

@main
struct Bottles_V2App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var sessionManager = SessionManager()
    @ObservedObject var bottleDataStore = BottleDataStore()
    @ObservedObject var shopDataStore = ShopDataStore()
    @ObservedObject var userStore = UserStore()
    
    init() {
        do {
            // AmplifyModels is generated in the previous step
            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
            try Amplify.add(plugin: dataStorePlugin)
            
            //            try Amplify.add(plugin: apiPlugin)
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            print("Amplify configured with DataStore plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
<<<<<<< Updated upstream
            switch sessionManager.authState{
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
                
            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)
                
            case .confirmCode(let username):
                ConfirmationView(username: username)
                    .environmentObject(sessionManager)
                
            case .session(let user):
                MainTabView(user: user)
                    .environmentObject(sessionManager)
                    .environmentObject(bottleDataStore)
                    .environmentObject(shopDataStore)
                    .environmentObject(userStore)
            }
=======
            // MARK: - UI피드백을 위한 주석 처리
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
            //                .environmentObject(userStore)
            //                .accentColor(Color("AccentColor"))
            //            }
            MainTabView()
                .environmentObject(sessionManager)
                .environmentObject(bottleDataStore)
                .environmentObject(shopDataStore)
                .environmentObject(userStore)
                .accentColor(Color("AccentColor"))
>>>>>>> Stashed changes
        }
    }
}
