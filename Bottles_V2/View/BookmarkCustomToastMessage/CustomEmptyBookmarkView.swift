//
//  CustomEmptyBookmarkView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/13.
//

import SwiftUI

// MARK: - 북마크 해제 버튼 클릭 시 표시되는 토스트 메세지
struct CustomEmptyBookmarkView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            HStack{
                Image("BookMark")
                Text("북마크가 해제되었습니다.")
                    .foregroundColor(.black)
                    .font(.bottles11)
                
            }
            .zIndex(1)
            .transition(.opacity.animation(.easeIn))
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 30)
                    .foregroundColor(.gray_f7)
            }
            .offset(y: 300)
        }
    }
}

struct CustomEmptyBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CustomEmptyBookmarkView(isShowing: .constant(true))
    }
}
