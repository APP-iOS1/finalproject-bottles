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
    
    var body: some View {
        if isActive {
            if let _ = authStore.currentUser {
                MainTabView()
            } else {
                TotalLoginView()
            }
        } else {
            if isloading {
                ZStack {
                    Image("AppLogo_Final")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                        .transition(.opacity)
                        .offset(y: -20)
                    LottieView(jsonName: "loading")
                        .frame(width: 150)
                        .offset(y: 100)
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
