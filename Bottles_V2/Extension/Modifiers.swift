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
            .foregroundColor(textColor)
    }
}

struct tagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
           
    }
}



