//
//  MainTapView.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection: Int = 1
    var body: some View {
        TabView(selection: $selection) {
            MapView().tabItem {
                Image(systemName: "map")
            }.tag(1)
            BookMarkView().tabItem {
                Image(systemName: "bookmark.fill")
            }.tag(2)
            NotificationView().tabItem {
                Image(systemName: "bell.fill")
            }.tag(3)
            MyPageView().tabItem {
                Image(systemName: "person.fill")
            }.tag(4)
        }
//        .toolbarBackground(Color.white, for: .tabBar)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
