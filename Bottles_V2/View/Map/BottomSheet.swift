//
//  BottomSheet.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/20.
//

import SwiftUI

struct BottomSheet<SheetContent: View>: ViewModifier {
    
    let sheetContent: SheetContent
    
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> SheetContent) {
        self.sheetContent = content()
        _isPresented = isPresented
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                ZStack {
                    Color.black.opacity(0.1)
                    VStack {
                        Spacer()
                        sheetContent
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
        }
    }
}

extension View {
    func bottomSheet<SheetContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> SheetContent) -> some View {
        self.modifier(BottomSheet(isPresented: isPresented, content: content))
    }
}
