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
import FirebaseFirestore
import FirebaseMessaging
@main
struct Bottles_V2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var userDataStore = UserStore()
    @ObservedObject var bottleDataStore = BottleDataStore()
    @ObservedObject var shopDataStore = ShopDataStore()
    @ObservedObject var reservationDataStore = ResevationDataStore()
    @ObservedObject var mapViewModel = MapViewModel()
    // coreData
    @StateObject var dataController = DataController()
    

    @StateObject var googleLoginViewModel: GoogleLoginViewModel = GoogleLoginViewModel()


    init() {
        //FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: "f2abf38572d20d5dde71ea5c33a02c07")
    }
    
    var body: some Scene {
        
        WindowGroup {
//            TotalLoginView()
//               .environmentObject(UserStore()).environmentObject(googleLoginViewModel)
//                .onOpenURL(perform: { url in
//                    if AuthApi.isKakaoTalkLoginUrl(url) {
//                        AuthController.handleOpenUrl(url: url)
//                   }
//                })
//            MainTabView()
            // coreData
//                .environment(\.managedObjectContext, dataController.container.viewContext)
         

            LaunchView()
            // coreData
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(bottleDataStore)
                .environmentObject(shopDataStore)
                .environmentObject(reservationDataStore)
                .environmentObject(mapViewModel)
                .environmentObject(userDataStore)
                .task {
                    userDataStore.readUser(userId: "test@naver.com")
                    await shopDataStore.getAllShopData()
                    await bottleDataStore.getAllBottleData()
                    await reservationDataStore.getAllResevationData()
                }
                .environmentObject(AuthStore())

            
            // MARK: - AccentColor 적용
                .accentColor(Color("AccentColor"))
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    
    // 앱이 켜졌을때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Use Firebase library to configure APIs
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        
        // 푸시 포그라운드 설정
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
}

extension AppDelegate : MessagingDelegate {
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("AppDelegate - 파베 토큰을 받았다.")
        print("AppDelegate - Firebase registration token: \(String(describing: fcmToken))")
        
        //UserStore 객체의 fcmToken에 값 저장
        UserStore.shared.fcmToken = fcmToken
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // 푸시메세지가 앱이 켜져 있을때 나올때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        print("willPresent: userInfo: ", userInfo)
        
        completionHandler([.banner, .sound, .badge])
    }
    
    // 푸시메세지를 받았을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("didReceive: userInfo: ", userInfo)
        completionHandler()
    }
    
}
