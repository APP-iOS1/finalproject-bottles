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
    var font = Font.bottles18
    var fontWeight = Font.Weight.bold
    var textColor = Color.white
    var backgroundColor = Color("AccentColor")
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(textColor)
    }
}

// MARK: - 바틀의 이름 및 가격 모디파이어.

struct BottleTitleAndPriceModifier: ViewModifier {
    var font = Font.bottles15
    var fontWeight = Font.Weight.bold
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
    }
}

// MARK: - 바틀샵의 이름 모디파이어.

struct BottleShopTitleModifier: ViewModifier {
    var font = Font.bottles20
    var fontWeight = Font.Weight.bold
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
    }
}

// MARK: - 바틀샵의 소개 모디파이어.

struct BottleShopIntroductionModifier: ViewModifier {
    var font = Font.bottles12
    var fontWeight = Font.Weight.medium
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            .multilineTextAlignment(.leading)
    }
}




