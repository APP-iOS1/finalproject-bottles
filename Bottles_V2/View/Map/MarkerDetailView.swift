//
//  MarkerDetailView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/30.
//

import SwiftUI

// MARK: - 마커 클릭 시 모달 뷰
struct MarkerDetailView: View {
    
    /// 바틀샵 이미지(더미 데이터)
    var dummyImages: [String] = [
        "https://www.qplace.kr/content/images/2022/04/1-9.jpg",
        "https://mblogthumb-phinf.pstatic.net/MjAyMDA5MDhfMjk1/MDAxNTk5NTIwMDk4MDAz.xK6sV-9Ep_Z7DNE_We9ConkWU9UiBmGYg3npakZpQfsg.CT3SyyXcMrzfYo6BoLHfzqFJPxBsJp5T275E79RKv-Mg.JPEG.wolfin/SE-25173810-e2c1-4eeb-95ee-3c093b7c21ce.jpg?type=w800",
        "https://www.qplace.kr/content/images/2022/04/2-13.jpg"
    ]
    
    @State private var checkBookmark: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("바틀샵 이름")
                        .font(.bottles20)
                        .fontWeight(.bold)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1)
                            .opacity(0.5)
                            .frame(width: 49, height: 18)
                        Text("영업중")
                            .font(.bottles11)
                            .fontWeight(.medium)
                            .opacity(0.5)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 25) {
                        // 전화 버튼
                        Button(action: {
                            
                        }) {
                            Image("Phone.fill")
                                .resizable()
                                .frame(width: 19.5, height: 19.5)
                        }
                        
                        // 북마크 버튼
                        Button(action: {
                            checkBookmark.toggle()
                        }) {
                            Image(checkBookmark ? "BookMark.fill" : "BookMark")
                                .resizable()
                                .frame(width: 15, height: 19)
                        }
                    }
                }
                
                Text("한 줄 소개 내추럴 와인 포트와인 위스키 림 꼬낙")
                    .font(.bottles13)
                    .fontWeight(.medium)
                    .opacity(0.5)
                Text("연말 파티에 어울리는 스파클링 와인들")
                    .font(.bottles15)
                    .fontWeight(.medium)
            }
            .padding(.horizontal)
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(dummyImages, id: \.self) { index in
                        // 바틀샵 이미지
                        AsyncImage(url: URL(string: index)) { image in
                            image.resizable()
                        } placeholder: {
                            // FIXME: - 무한로딩 이슈
                            // ProgressView()
                            Image("oakDrum_Image")
                                .resizable()
                        }
                        .frame(width: 126, height: 126)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct MarkerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MarkerDetailView()
    }
}
