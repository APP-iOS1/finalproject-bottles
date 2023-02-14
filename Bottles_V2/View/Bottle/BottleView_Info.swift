//
//  BottleView_Info.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/31.
//

import SwiftUI

// MARK: - 바틀 기본 정보(바틀 이미지, 바틀 이름, 북마크, 바틀 가격, 바틀샵 이름)
struct BottleView_Info: View {
    @EnvironmentObject var userStore: UserStore
    @State private var checkBookmark: Bool = false
    @Binding var isShowingFillBookmarkMessage: Bool
    @Binding var isShowingEmptyBookmarkMessage: Bool
    
    var tagList: [String] = ["위스키", "한정판", "스모키"]
    var bottleData: BottleModel
    
    var body: some View {
        // MARK: - 바틀 이미지
        AsyncImage(url: URL(string: bottleData.itemImage)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 390)
                .cornerRadius(12)
        } placeholder: {
            Image("ready_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 390)
                .cornerRadius(12)
        }
        .background(Color.gray_f7)
        .padding(.bottom, 8)
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                // MARK: - 바틀 이름
                Text(bottleData.itemName)
                    .font(.bottles18)
                    .fontWeight(.medium)
                
                Spacer()
                
                HStack(spacing: 23) {
                    // MARK: - Share 버튼
                    ShareLink(item: "") {
                        Image("share")
                            .resizable()
                            .frame(width: 14, height: 20)
                    }
                    
                    // MARK: - 북마크 버튼
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.5)) {
                            checkBookmark.toggle()
                        }
                        if compareMyFollowBottleID(bottleData.id) == true {
                            checkBookmark = false
                            userStore.deleteFollowItemId(bottleData.id)
                            withAnimation(.easeOut(duration: 1.5)) {
                                isShowingEmptyBookmarkMessage = true
                                print("북마크 해제")
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                isShowingEmptyBookmarkMessage = false
                            }
                        }

                        if compareMyFollowBottleID(bottleData.id) == false {
                            checkBookmark = true
                            userStore.addFollowItemId(bottleData.id)
                            withAnimation(.easeOut(duration: 1.5)) {
                                isShowingFillBookmarkMessage = true
                                print("북마크 완료")
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                isShowingFillBookmarkMessage = false
                            }
                        }
                    }) {
                        Image(compareMyFollowBottleID(bottleData.id) ? "BookMark.fill" : "BookMark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 18)
                            .padding(.horizontal, 10)
                    }
                }
            }
            // MARK: - 가격
            Text("\(bottleData.itemPrice)원")
                .font(.bottles24)
                .fontWeight(.bold)
            
            HStack {
                Image("Maptabfill")
                    .resizable()
                    .frame(width: 14, height: 17)
                // MARK: - 바틀샵 이름
                Text(bottleData.shopName)
                    .font(.bottles14)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal)
        
        VStack(alignment: .leading) {
            // MARK: - 바틀 소개
            Text("술 소개. 친구 연인 가족과 함께 부담없이 마시기 좋은 스파클링 와인을 추천합니다.\n어떤 음식과 페어링해도 평타 이상일거에요!")
                .font(.bottles14)
                .fontWeight(.medium)
                .foregroundColor(Color("AccentColor"))
                .lineSpacing(3)
            
            HStack {
                // MARK: - 바틀 태그
                ForEach(bottleData.itemTag, id: \.self) { tag in
                    Text(tag)
                        .font(.bottles12)
                        .fontWeight(.regular)
                        .opacity(0.7)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black.opacity(0.2), lineWidth: 1)
                            )
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("AccentColor").opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    func compareMyFollowBottleID(_ bottleId: String) -> Bool {
        return (userStore.user.followItemList.filter { $0 == bottleId }.count != 0) ? true : false
    }
}

//struct BottleView_Info_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView_Info()
//    }
//}
