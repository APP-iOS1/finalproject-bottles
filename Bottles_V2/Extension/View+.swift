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
