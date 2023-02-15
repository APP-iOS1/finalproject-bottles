//
//  MarkerDetailView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/30.
//

import SwiftUI
import SkeletonUI

// MARK: - 마커 클릭 시 모달 뷰
struct MarkerDetailView: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var shopDataStore: ShopDataStore
    var shopData: ShopModel
    @State private var checkBookmark: Bool = true
    @Binding var showMarkerDetailView: Bool
    @Binding var currentShopId: String
    @State var colors = [String]()
    @StateObject var coordinator: Coordinator = Coordinator.shared
    @State var calling: Bool = false
//    @Binding var shopModel: ShopModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("\(shopData.shopName)")
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
                        Button {
                            calling = true
                        } label: {
                            MakeCallOrAddToCallBook(calling: $calling, bottleShop: shopData)
                        }
                        // 북마크 버튼
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.5)) {
                                checkBookmark.toggle()
                            }
                            
                            if compareMyFollowShopID(shopData.id) == true {
                                checkBookmark = false
                                userStore.deleteFollowShopId(shopData.id)
                                shopDataStore.deleteFollowUserList(userStore.user.email, shopData.id)
                            }
                            
                            if compareMyFollowShopID(shopData.id) == false {
                                checkBookmark = true
                                userStore.addFollowShopId(shopData.id)
                                shopDataStore.addFollowUserList(userStore.user.email, shopData.id)
                            }
//                            if compareMyFollowShopID(shopData.id) == true {
//                                checkBookmark = false
//                                userStore.deleteFollowShopId(shopData.id)
//                            }
//
//                            if compareMyFollowShopID(shopData.id) == false {
//                                checkBookmark = true
//                                userStore.addFollowShopId(shopData.id)
//                            }
                            
                        }) {
                            Image(compareMyFollowShopID(shopData.id) ? "BookMark.fill" : "BookMark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .padding(.trailing, 5)
                        }
                    }
                }
                
                Text("\(shopData.shopIntroduction)")
                    .font(.bottles13)
                    .fontWeight(.medium)
                    .opacity(0.5)
                Text("\(shopData.shopCurationTitle)")
                    .font(.bottles15)
                    .fontWeight(.medium)
            }
            .padding(.horizontal)
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(shopData.shopImages, id: \.self) { imageLink in
                        // 바틀샵 이미지
                        AsyncImage(url: URL(string: imageLink)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 126, height: 126)
                    }
                }
            }
            .skeleton(with: colors.isEmpty)
            .scrollIndicators(.hidden)
        }
        .foregroundColor(.black)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.colors = ["GREEN", "RED", "BLUE", "YELLOW", "BLACK"]
                  }
        }
    }
    
    func compareMyFollowShopID(_ shopId: String) -> Bool {
        return (userStore.user.followShopList.filter { $0 == shopId }.count != 0) ? true : false
    }
}

//struct MarkerDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarkerDetailView(mappinShop: $)
//    }
//}
