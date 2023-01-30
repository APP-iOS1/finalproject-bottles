//
//  MarkerDetailView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/30.
//

import SwiftUI

struct MarkerDetailView: View {
    
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
                ForEach(0..<5, id: \.self) { _ in
                    Image("bottleShop")
                        .resizable()
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
