//
//  ReservedView_BottleShop.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

// MARK: - 픽업 바틀샵 저장
struct ReservedView_BottleShop: View {
    @State private var checkBookmark: Bool = false
    @Binding var isShowingFillBookmarkMessage: Bool
    @Binding var isShowingEmptyBookmarkMessage: Bool
    
    var body: some View {
        ZStack {
            Color("AccentColor").opacity(0.1).edgesIgnoringSafeArea([.top, .bottom])
            VStack(spacing: 3) {                
                Text("픽업 바틀샵 저장하기")
                    .font(.bottles14)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // MARK: - 픽업한 바틀샵
                ReservedView_ShopCell(
                    isShowingFillBookmarkMessage: $isShowingFillBookmarkMessage,
                    isShowingEmptyBookmarkMessage: $isShowingEmptyBookmarkMessage
                )
            }
            .padding(.top, 10)
            
            // MARK: - Bookmark 추가 시 표시되는 토스트 메세지
            CustomFillBookmarkView(isShowing: $isShowingFillBookmarkMessage)
                .offset(y: -230)
            
            // MARK: - Bookmark 해제 시 표시되는 토스트 메세지
            CustomEmptyBookmarkView(isShowing: $isShowingEmptyBookmarkMessage)
                .offset(y: -230)
        }
    }
}

//struct ReservedView_BottleShop_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservedView_BottleShop()
//    }
//}
