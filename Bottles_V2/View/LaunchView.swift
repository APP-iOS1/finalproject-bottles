//
//  LaunchView.swift
//  Bottles_V2
//
//  Created by dev on 2023/02/03.
//

import SwiftUI

struct LaunchView: View {
    @State private var isActive = false
    @State private var isloading = true
    var body: some View {
        if isActive {
            MainTabView()
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
