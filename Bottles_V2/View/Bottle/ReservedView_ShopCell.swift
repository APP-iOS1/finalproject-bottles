//
//  BottleView_ShopCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/20.
//

import SwiftUI

// MARK: - 바틀샵 셀(바틀샵 이미지, 바틀샵 이름, 바틀샵 소개, 북마크)
struct ReservedView_ShopCell: View {
    @State private var checkBookmark: Bool = false
    @Binding var isShowingFillBookmarkMessage: Bool
    @Binding var isShowingEmptyBookmarkMessage: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // MARK: - 바틀샵 이미지
            Image("bottleShop")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 112, height: 112)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    // MARK: - 바틀샵 이름
                    Text("바틀리스트")
                        .font(.bottles18)
                        .fontWeight(.bold)
                    
                    // MARK: - 바틀샵 소개
                    Text("눈 감고 먹어도 맛있는 곳.\n직접 먹어보고 추천해 드립니다.")
                        .font(.bottles14)
                        .fontWeight(.regular)
                        .lineSpacing(5)
                    
                    // MARK: - 거리
                    Text("500m")
                        .font(.bottles14)
                        .fontWeight(.medium)
                        .opacity(0.4)
                }
                .foregroundColor(.black)
                
                Spacer()
                
                // MARK: - 북마크
                Button(action: {
                    if checkBookmark {
                        checkBookmark = false
                        withAnimation(.easeOut(duration: 1.5)) {
                            isShowingEmptyBookmarkMessage = true
                            print("북마크 해제")
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            isShowingEmptyBookmarkMessage = false
                        }
                    } else {
                        checkBookmark = true
                        withAnimation(.easeOut(duration: 1.5)) {
                            isShowingFillBookmarkMessage = true
                            print("북마크 완료")
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            isShowingFillBookmarkMessage = false
                        }
                    }
                }) {
                    Image(checkBookmark ? "bookmark_fill" : "bookmark")
                        .resizable()
                        .frame(width: 16, height: 19)
                        .padding(.horizontal, 10)
                }
            }
            .padding(.vertical, 10)
        }
        .padding()
    }
}

//struct ReservedView_ShopCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservedView_ShopCell()
//    }
//}
