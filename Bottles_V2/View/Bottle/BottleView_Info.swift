//
//  BottleView_Info.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/31.
//

import SwiftUI

// MARK: - 바틀 기본 정보(바틀 이미지, 바틀 이름, 북마크, 바틀 가격, 바틀샵 이름)
struct BottleView_Info: View {
    @State private var checkBookmark: Bool = true
    var tagList: [String] = ["위스키", "한정판", "스모키"]
    
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
        
        VStack(alignment: .leading) {
            // MARK: - 바틀 소개
            Text("술 소개. 친구 연인 가족과 함께 부담없이 마시기 좋은 스파클링 와인을 추천합니다.\n 어떤 음식과 페어링해도 평타 이상일거에요!")
                .font(.bottles14)
                .fontWeight(.medium)
                .lineSpacing(3)
            
            HStack {
                // MARK: - 바틀 태그
                ForEach(tagList, id: \.self) { tag in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1)
                            .opacity(0.4)
                            .frame(width: 54, height: 21)
                        Text(tag)
                            .font(.bottles12)
                            .fontWeight(.medium)
                            .opacity(0.4)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

//struct BottleView_Info_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView_Info()
//    }
//}
