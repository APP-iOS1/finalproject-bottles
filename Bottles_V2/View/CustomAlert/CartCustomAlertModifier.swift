//
//  CartCustomAlertModifier.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/14.
//

import SwiftUI

struct CartCustomAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let primaryButtonTitle: String
    let primaryAction: () -> Void
    /// 취소 버튼 true일 때 추가 false일 때 취소버튼 없이 한가지만
    let withCancelButton: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            // 애니메이션을 넣기 위해 ZStack을 한번 더 사용
            ZStack{
            if isPresented {
                    Rectangle()
                        .fill(.black.opacity(0.2))
                        .ignoresSafeArea()
                    // 애니메이션| 트랜지션이란 없던 게 나오거나, 있던게 사라질 때의 효과
                        .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                    
                    CartCustomAlertView(
                        isPresented: $isPresented,
                        title: title,
                        message: message,
                        primaryButtonTitle: primaryButtonTitle,
                        primaryAction: primaryAction,
                        withCancelButton: withCancelButton)
                    .transition(
                        // 비대칭 트렌지션 나올 때랑 사라질 때 서로 다른 효과를 주고싶을 때 사용한다
                        .asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)) //combined를 넣으면 애니메이션 효과를 두개를 넣을 수 있다.
                        .animation(.easeInOut(duration: 0.3)))
                }
            }
            .animation(.easeInOut, value: isPresented)
        }
    }
}

struct CartCustomAlertModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Text("")
        }
        .modifier(CartCustomAlertModifier(isPresented: .constant(true), title: "타이틀", message: "메세지", primaryButtonTitle: "확인", primaryAction: {}, withCancelButton: true))
       
    }
}
