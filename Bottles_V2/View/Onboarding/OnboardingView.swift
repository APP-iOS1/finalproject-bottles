//
//  OnboardingView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            // 페이지 1
            OnboardingFirstView()
            
            // 페이지 2
            OnboardingPageView(
                
                imageName: "Onboarding1", title: "내 주변 5km 반경에 있는\n바틀샵을 확인하세요!"
                
            )
            
            // 페이지 3
            OnboardingPageView(
                
                imageName: "Onboarding2", title: "즐겨찾기 좋다!"
                
            )
            
            // 페이지 4
            OnboardingPageView(
                
                imageName: "Onboarding3", title: "예약 확정 후 3일 이내에\n꼭 방문해주세요!"
                
            )
            
            // 페이지 5
            OnboardingLastPageView(
                imageName: "Onboarding4",
                title: "픽업 예약 완료 후\n5분 내에 확정이 됩니다!",
                //                    subtitle: "어쩌구",
                isFirstLaunching: $isFirstLaunching
            )
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}
