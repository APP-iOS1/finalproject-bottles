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
    /// 최상단 Stack에서 .customAlert으로 CustomAlert을 띄울 수 있습니다.
    func customAlert(
        isPresented: Binding<Bool>,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        withCancelButton: Bool) -> some View
    {
        modifier(CustomAlertModifier(isPresented: isPresented, message: message, primaryButtonTitle: primaryButtonTitle, primaryAction: primaryAction, withCancelButton: withCancelButton))
    }
    
}
