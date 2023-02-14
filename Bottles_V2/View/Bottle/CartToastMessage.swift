//
//  CartToastMessage.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/14.
//

import SwiftUI

// MARK: - 장바구니에
struct CartToastMessage: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            HStack{
                Text("장바구니에 상품이 담겼습니다.")
                    .font(.bottles12)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
               
                Spacer()
                
                Button(action: {}) {
                    Text("장바구니로 가기")
                        .font(.bottles12)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("AccentColor"))
                }
            }
            .zIndex(1)
            .transition(.opacity.animation(.easeIn))
            .padding(15)
            .background(Color("AccentColor").opacity(0.1))
            .cornerRadius(5)
            .padding()
            .offset(y: 250)
        }
    }
}

struct CartToastMessage_Previews: PreviewProvider {
    static var previews: some View {
        CartToastMessage(isShowing: .constant(true))
    }
}
