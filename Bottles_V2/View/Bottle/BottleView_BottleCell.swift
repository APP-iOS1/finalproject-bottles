//
//  BottleView_BottleCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/06.
//

import SwiftUI

// MARK: - 바틀 셀(바틀 이미지, 바틀 이름, 바틀 가격, 바틀샵 이름, 북마크)
struct BottleView_BottleCell: View {
    @State private var checkBookmark: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // MARK: - 바틀 이미지
            Image("bottle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 128, height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    // MARK: - 바틀 이름
                    Text("프로메샤 모스카토")
                        .font(.bottles14)
                        .fontWeight(.medium)
                    
                    // MARK: - 바틀 가격
                    Text("110,000원")
                        .font(.bottles18)
                        .fontWeight(.bold)
                
                    // MARK: - 바틀샵 이름
                    HStack {
                        Image("Map_Tab_fill")
                            .resizable()
                            .frame(width: 14, height: 17)
                        // MARK: - 바틀샵 이름
                        Text("와인앤모어 군자점")
                            .font(.bottles14)
                            .fontWeight(.medium)
                    }
                }
                .foregroundColor(.black)
                
                Spacer()
                
                // MARK: - 북마크
                Button(action: {
                    checkBookmark.toggle()
                }) {
                    Image(checkBookmark ? "bookmark_fill" : "bookmark")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .padding(.horizontal, 10)
                }
            }
            .padding(.top, 10)
        }
    }
}

struct BottleView_BottleCell_Previews: PreviewProvider {
    static var previews: some View {
        BottleView_BottleCell()
    }
}
