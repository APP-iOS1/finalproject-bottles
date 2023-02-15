//
//  Modifiers.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/31.
//

import SwiftUI
import Foundation

// MARK: - 대표색 버튼에 사용될 모디파이어.

struct AccentColorButtonModifier: ViewModifier {
    var font = Font.bottles20
    var fontWeight = Font.Weight.medium
    var textColor = Color.white
    var backgroundColor = Color("AccentColor")
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(textColor)
    }
}


// MARK: - 바틀샵의 이름 모디파이어.

struct BottleShopTitleModifier: ViewModifier {
    var font = Font.bottles18
    var fontWeight = Font.Weight.bold
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
    }
}

// MARK: - 바틀샵의 소개 모디파이어.

struct BottleShopIntroductionModifier: ViewModifier {
    var font = Font.bottles14
    var fontWeight = Font.Weight.regular
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            .multilineTextAlignment(.leading)
    }
}

//MARK: 반짝이는 스켈레톤 View
struct BlinkingAnimatinoModifier: AnimatableModifier {
    //MARK: Property
    var shouldShow: Bool            // 스켈레톤을 보이게 할 것 인지
    var opacity: Double                // 반짝임의 정도
    var animatableData: Double {
        get { opacity }
        set { opacity = newValue }
    }
    
    // zIndex: ZStack 우선순위 정하기(stack처럼 쌓이고, 이래야 ZStack끼리 오류가 적게 발생)
    func body(content: Content) -> some View {
        content.overlay(
            ZStack {
                Color("bgColor")
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .zIndex(0)                        // 뒤의 Conent가 보이지 않도록
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color("lodingColor").opacity(0.5))
                    .opacity(self.opacity).zIndex(1)            // 우선순위 1
            }.opacity(shouldShow ? 1 : 0)
        )
    }
}



