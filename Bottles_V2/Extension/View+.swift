//
//  View+.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/30.
//

import Foundation
import SwiftUI

extension View {
    func shakeEffect(trigger: Bool) -> some View {
        modifier(ShakeEffect(trigger: trigger))
    }
    
    func checkRegisterEffect(trigger: Bool) -> some View {
        modifier(TextFieldModifier(trigger: trigger))
    }
    
}

// MARK: - 빈 공간 터치로 키보드를 내리기 위한 View Extension
/// 필요한 View에서 onTapGesture를 통해 사용
extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil
        )
    }
}
