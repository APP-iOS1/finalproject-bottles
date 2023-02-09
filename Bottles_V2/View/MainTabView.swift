//
//  MainTapView.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct MainTabView: View {

    //    @EnvironmentObject var sessionManager : SessionManager
    @EnvironmentObject var shopDataStore : ShopDataStore
    @EnvironmentObject var bottleDataStore : BottleDataStore
    @EnvironmentObject var reservationDataStore : ResevationDataStore
    @EnvironmentObject var mapViewModel: MapViewModel

    //    let user: AuthUser
    @Binding var isSignIn: Bool
    @State private var selection: Int = 1
    //     TabBar 백그라운드 컬러 지정
    
    
    var body: some View {
        TabView(selection: $selection) {
            MapView().tabItem {
                Image(selection == 1 ? "Maptabfill" : "Map_tab")
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
            MyPageView(isSignIn: $isSignIn).tabItem {
                Image(selection == 4 ? "MyPage_tab_fill" : "MyPage_tab")
                Text("MY")
            }.tag(4)
        }
        .toolbarBackground(Color.white, for: .tabBar)

    }
}
//
//struct TabButtonModifier: ViewModifier {
//    func body(image: Image) -> some View {
//        image
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 20)
//    }
//}

