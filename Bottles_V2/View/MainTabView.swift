//
//  MainTapView.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var delegate: AppDelegate
    //    @EnvironmentObject var sessionManager : SessionManager
    @EnvironmentObject var shopDataStore : ShopDataStore
    @EnvironmentObject var bottleDataStore : BottleDataStore
    @EnvironmentObject var reservationDataStore : ReservationDataStore
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var userDataStore: UserStore

    //    let user: AuthUser
    
    @State var selection: Int = 1
    //     TabBar 백그라운드 컬러 지정
    
    @State private var isActive = false
    @State private var isloading = true
    
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
                MyPageView(selection: $selection).tabItem {
                    Image(selection == 4 ? "MyPage_tab_fill" : "MyPage_tab")
                    Text("MY")
                }.tag(4)
            }
                    .task {
            mapViewModel.checkIfLocationServicesIsEnabled()
        }
            .toolbarBackground(Color.white, for: .tabBar)
            .sheet(isPresented: $delegate.openedFromNotification, onDismiss: didDismiss){
                NotificationView()
            }
    }
    func didDismiss(){
        delegate.openedFromNotification = false
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

