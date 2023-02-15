//
//  MainTapView.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

enum Destination: Hashable {
    case bottleShop
    case cart
    case pickUpList
    case setting
}

struct MainTabView: View {
    @EnvironmentObject private var delegate: AppDelegate
    //    @EnvironmentObject var sessionManager : SessionManager
    @EnvironmentObject var shopDataStore: ShopDataStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @EnvironmentObject var reservationDataStore: ReservationDataStore
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var userDataStore: UserStore
    @EnvironmentObject var cartStore: CartStore
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var shopNoticeDataStore: ShopNoticeDataStore

    //    let user: AuthUser
    
    @State var selection: Int = 1
    @State private var root: Bool = false
    
    @State private var isActive = false
    @State private var isloading = true
    
    var selectionBinding: Binding<Int> { Binding (
        get: {
            self.selection
        },
        set: {
            if $0 == self.selection && root {
                print("root view 이동")
                root = false
            }
            self.selection = $0
        }
    )}
    
    var body: some View {
            TabView(selection: selectionBinding) {
                MapView(root: $root).tabItem {
                    Image(selection == 1 ? "Maptabfill" : "Map_tab")
                    Text("주변")
                }.tag(1)
                BookMarkView().tabItem {
                    Image(selection == 2 ? "BookMark_tab_fill" : "BookMark_tab")
                    Text("저장")
                }.tag(2)
                NotificationView(root: $root).tabItem {
                    Image(selection == 3 ? "Notification_tab_fill" : "Notification_tab")
                    Text("알림")
                }.tag(3)
                MyPageView(root: $root, selection: $selection).tabItem {
                    Image(selection == 4 ? "MyPage_tab_fill" : "MyPage_tab")
                    Text("MY")
                }.tag(4)
            }
            .toolbarBackground(Color.white, for: .tabBar)
            .sheet(isPresented: $delegate.openedFromNotification, onDismiss: didDismiss){
                NotificationView(root: $root)
            }
            .task {
                userDataStore.readUser(userId: authStore.currentUser?.email ?? "")
                cartStore.readCart(userEmail: authStore.currentUser?.email ?? "")
                shopNoticeDataStore.getAllShopNoticeDataRealTime()

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

