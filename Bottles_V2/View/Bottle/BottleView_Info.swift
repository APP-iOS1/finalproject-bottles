//
//  BottleView_Info.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/31.
//

import SwiftUI

struct BottleView_Info: View {
    @State private var checkBookmark: Bool = true
    
    // MARK: - 바틀 기본 정보 (바틀 이름, 가격, 바틀샵 이름)
    var body: some View {
        // MARK: - 바틀 이미지
        Image("promesa")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width, height: 220)
        
        
        VStack(alignment: .leading) {
            HStack {
                // MARK: - 바틀 이름
                Text("프로메샤 모스카토")
                    .font(.bottles18)
                    .fontWeight(.medium)
                
                Spacer()
                
                HStack(spacing: 25) {
                    // MARK: - Share 버튼
                    ShareLink(item: "") {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 17, height: 23)
                    }
                    
                    // MARK: - 북마크 버튼
                    Button(action: {
                        checkBookmark.toggle()
                    }) {
                        Image(checkBookmark ? "BookMark.fill" : "BookMark")
                            .resizable()
                            .frame(width: 15, height: 19)
                    }
                }
            }
            // MARK: - 가격
            Text("10,100원")
                .font(.bottles24)
                .fontWeight(.bold)
            
            HStack {
                Image("Map_Tab_fill")
                    .resizable()
                    .frame(width: 11, height: 16)
                // MARK: - 바틀샵 이름
                Text("바틀샵 이름")
                    .font(.bottles15)
                    .fontWeight(.medium)
            }
        }
        .padding()
    }
}

//struct BottleView_Info_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView_Info()
//    }
//}
