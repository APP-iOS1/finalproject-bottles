//
//  LaunchView.swift
//  Bottles_V2
//
//  Created by dev on 2023/02/03.
//

import SwiftUI

struct LaunchView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.white)
    }
    
    @EnvironmentObject var authStore: AuthStore
    
    @State private var isActive = false
    @State private var isloading = true
    
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수.
    // @AppStorage에 저장되어 앱 종료 후에도 유지됨.
    @AppStorage("isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        if isActive {
            if isFirstLaunching {
                OnboardingView(isFirstLaunching: $isFirstLaunching)
            }
            else {
                if let _ = authStore.currentUser {
                    MainTabView()
                } else {
                    TotalLoginView()
                }
            }
        } else {
            if isloading {
                ZStack {
                    Image("AppLogo_Final").transition(.opacity).zIndex(1)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            self.isActive = true
                            self.isloading.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
