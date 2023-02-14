//
//  OnboardingView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI
import Lottie

struct OnboardingView: View {

    @Binding var isFirstLaunching: Bool

    var body: some View {
            TabView {
                // 페이지 1: 앱 소개
                OnboardingPageView(
                    imageName: "wineglass",
                    title: "바틀샵 예약을 손 쉽게!",
                    subtitle: "바틀샵 사장님과 바로 연결되는\n1:1 예약 어플"
                )
                
                // 페이지 2: 쓰기 페이지 안내
                OnboardingPageView(
                    imageName: "map",
                    title: "내 주변의 바틀샵을 내 손안에!",
                    subtitle: "지도를 통해 \n내 주변에 있는 바틀샵들을 \n한눈에 확인하세요."
                )
                
                // 페이지 3: 읽기 페이지 안내 + 온보딩 완료
                OnboardingLastPageView(
                    imageName: "bookmark",
                    title: "북마크를 통해 바틀샵&바틀 저장하기!",
                    subtitle: "어쩌구",
                    isFirstLaunching: $isFirstLaunching
                )
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }


//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}
