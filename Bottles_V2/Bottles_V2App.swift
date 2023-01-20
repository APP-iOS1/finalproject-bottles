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
import UIKit

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
//    ) -> Bool {
//        do {
//            try Amplify.configure()
//        } catch {
//            print("An error occurred setting up Amplify: \(error)")
//        }
//        return true
//    }
//}

@main
struct Bottles_V2App: App {
    //    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            //            ContentView().environmentObject(DataStore())
            ContentView()
                .accentColor(Color("AccentColor"))
        }
    }
    
//    init() {
//        do {
//            // AmplifyModels is generated in the previous step
//            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
//            try Amplify.add(plugin: dataStorePlugin)
//            try Amplify.configure()
//            print("Amplify configured with DataStore plugin")
//        } catch {
//            print("Failed to initialize Amplify with \(error)")
//        }
//    }
}
