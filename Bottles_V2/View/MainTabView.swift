//
//  MainTapView.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI
import Amplify
struct MainTabView: View {
    @EnvironmentObject var sessionManager : SessionManager
    
    // MARK: - UI피드백을 위한 주석 처리
//    let user: AuthUser
    
    @State private var selection: Int = 1
    
    // MARK: - UI피드백을 위한 주석 처리
    // TabBar 백그라운드 컬러 지정
//    init(user : AuthUser) {
//            UITabBar.appearance().backgroundColor = UIColor(Color.white)
//        self.user = user
//    }
    
    var body: some View {
        TabView(selection: $selection) {
            MapView().tabItem {
                Image(selection == 1 ? "Map_tab_fill" : "Map_tab")
                Text("주변")
            }.tag(1)
            BookMarkView().tabItem {
                Image(selection == 2 ? "BookMark_tab_fill" : "BookMark_tab")
                Text("저장")
            }.tag(2)
            NotificationView().tabItem {
                Image(selection == 3 ? "Notification_tab_fill" : "Notification_tab")
                Text("알림")
            }.tag(3)
            MyPageView().tabItem {
                Image(selection == 4 ? "MyPage_tab_fill" : "MyPage_tab")
                Text("MY")
            }.tag(4)
        }
        .toolbarBackground(Color.white, for: .tabBar)
    }
}

//struct TabButtonModifier: ViewModifier {
//    func body(image: Image) -> some View {
//        image
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 20)
//    }
//}

