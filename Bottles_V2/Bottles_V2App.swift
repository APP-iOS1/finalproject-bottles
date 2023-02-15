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

import FBSDKCoreKit
@main
struct Bottles_V2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var userDataStore = UserStore()
    @ObservedObject var bottleDataStore = BottleDataStore()
    @ObservedObject var shopDataStore = ShopDataStore()
    @ObservedObject var shopNoticeDataStore = ShopNoticeDataStore()
    @ObservedObject var reservationDataStore = ReservationDataStore()
    @ObservedObject var cartStore = CartStore()
    @ObservedObject var mapViewModel = MapViewModel()
    @StateObject var authStore = AuthStore()
    // coreData
    @StateObject var dataController = DataController()
    

    init() {
//        FirebaseApp.configure()


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
                .environmentObject(authStore)
                .environmentObject(bottleDataStore)
                .environmentObject(shopDataStore)
                .environmentObject(shopNoticeDataStore)
                .environmentObject(reservationDataStore)
                .environmentObject(mapViewModel)
                .environmentObject(userDataStore)
                .environmentObject(cartStore)
                .environmentObject(appDelegate)
                .task {
                    userDataStore.readUser(userId: authStore.currentUser?.email ?? "")
                    userDataStore.getUserDataRealTime(userId: authStore.currentUser?.email ?? "")
                    cartStore.readCart(userEmail: authStore.currentUser?.email ?? "")
                    await shopDataStore.getAllShopData()
                    await bottleDataStore.getAllBottleData()
                    await reservationDataStore.readReservation()
                }
            
            
            
            // MARK: - AccentColor 적용
                .accentColor(Color("AccentColor"))
        }
    }
}



class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    //published property: 노티피케이션을 눌렀을 때 Data-driven으로 처리해주기 위함.
    @Published var openedFromNotification: Bool = false
    // 앱이 켜졌을때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Use Firebase library to configure APIs
        // 파이어베이스 설정
        FirebaseApp.configure()
        FBSDKCoreKit.ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("푸시메시지를 받았을 때: \(userInfo)")
        
        if let viewType = userInfo["viewType"] as? String {
            
        }
    }
    
    
    func application( app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
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
    
    // MARK: 앱이 active일 때 notification이 오면 동작 ( willPresent )
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        //openedFromNotification = true
        print("푸시메시지가 앱이 켜져 있을때 오면 : \(userInfo)")
        completionHandler([.banner, .sound, .badge])
    }
    
    // MARK: push notification click하면 동작( didReceive )
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if UIApplication.shared.applicationState == .active {
                // 앱이 foreground에 있을 때의 처리
            sleep(1);
            openedFromNotification = true;
        } else {
               
            //이렇게 하면 앱이 백엔드에 있을 때, 스플래쉬 뷰 3초가 지난 후 1초 뒤에 예약 알람이 보여지게 된다.
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation {
                    self.openedFromNotification = true
                }
            }
        }
        
        print("푸시메시지를 받았을 떄 : \(userInfo)")
        guard let viewType = userInfo["viewType"] as? String else {
            print("viewType에는 아무것도 없네..")
            return
        }
        
        completionHandler()
    }
    
}
