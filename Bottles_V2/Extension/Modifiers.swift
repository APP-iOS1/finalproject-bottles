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




