//
//  NearBySheetCell.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/02/06.
//

import SwiftUI
import SkeletonUI
struct NearBySheetCell: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var shopDataStore: ShopDataStore

    // Shop의 정보를 저장하는 변수
    @State private var checkBookmark: Bool = false
    var shopModel: ShopModel
    var distance: Double
    @State var colors = [SkeletonColor]()
    
    func compareMyFollowShopID(_ shopId: String) -> Bool {
        return (userStore.user.followShopList.filter { $0 == shopId }.count != 0) ? true : false
    }
    
    var body: some View {
        HStack(alignment: .top) {
            // Shop 이미지
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 120, height: 120)
                .overlay {
                    AsyncImage(url: URL(string: shopModel.shopTitleImage)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .cornerRadius(10)
                    } placeholder: {
//                        ProgressView()
                          EmptyView()
                            .background(Color.clear)
                    }
                }
                .skeleton(with: colors.isEmpty)
                .animation(type: .linear(duration: 3.0))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                // Shop 이름
                Text(shopModel.shopName)
                    .font(.bottles18)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .skeleton(with: colors.isEmpty)
                    .animation(type: .pulse())
                // Shop 소개글
                Text(shopModel.shopIntroduction)
                    .font(.bottles14)
                    .multilineTextAlignment(.leading)
                    .skeleton(with: colors.isEmpty)
                    .animation(type: .pulse())
                /// 현재 위치와 바틀샵과의 거리
                /// 초기 distance 값(m) -> km로 환산 후 소수점 1번째 자리까지 제거
                ///  distance -> m 값 분기처리
                if distance/1000 < 1 {
                    Text("\(String(format: "%.0f", round(distance))) m")
                        .font(.bottles14)
                        .foregroundColor(.gray)
                        .skeleton(with: colors.isEmpty)
                } else {
                    Text("\(String(format: "%.0f", round(distance/1000))) km")
                        .font(.bottles14)
                        .foregroundColor(.gray)
                        .skeleton(with: colors.isEmpty)
                        .animation(type: .pulse())
                }
                Spacer()
            }
            .foregroundColor(.black)
            .padding(.top, 5)
            
            Spacer()
            VStack {
                // TODO: 북마크 기능 추가해야함
                Button(action: {
                    withAnimation(.easeOut(duration: 0.5)) {
                        checkBookmark.toggle()
                    }
                    
                    if compareMyFollowShopID(shopModel.id) == true {
                        checkBookmark = false
                        userStore.deleteFollowShopId(shopModel.id)
                        shopDataStore.deleteFollowUserList(userStore.user.email, shopModel.id)
                    }
                    
                    if compareMyFollowShopID(shopModel.id) == false {
                        checkBookmark = true
                        userStore.addFollowShopId(shopModel.id)
                        shopDataStore.addFollowUserList(userStore.user.email, shopModel.id)
                    }
                    
                }) {
                    Image(compareMyFollowShopID(shopModel.id) ? "BookMark.fill" : "BookMark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15)
                        .padding(.trailing, 5)
                        .foregroundColor(.accentColor)
                        .skeleton(with: colors.isEmpty)
                }
                Spacer()
            }
            .font(.title2)
            .padding()
            .padding(.top, -5)
        }
        .tint(.clear)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.colors = [
                    SkeletonColor(name: "GREEN"),
                    SkeletonColor(name: "RED"),
                    SkeletonColor(name: "BLUE"),
                    SkeletonColor(name: "BLACK")
                ]
            }
        }
        .frame(height: 130)
        .padding(.vertical, 5)
    }
}

//struct NearBySheetCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NearBySheetCell()
//    }
//}
