//
//  BookMarkShopList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI
import CoreLocation

struct BookMarkShopList: View {
    // ActionSheet
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
    // 북마크 알림
    @State var bookMarkAlarm: Bool = false
    @State var resetDeletedShopId: String = ""
    
    // Server Data
    @EnvironmentObject var userDataStore: UserStore
    @EnvironmentObject var shopDataStore: ShopDataStore
    
    func distance(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
//        let to = CLLocation(latitude: mapViewModel.userLocation.0, longitude: mapViewModel.userLocation.1)
        let to = CLLocation(latitude: Coordinator.shared.userLocation.0, longitude: Coordinator.shared.userLocation.1)
        print("\(from.distance(from: to))")
        return from.distance(from: to)
    }
    
    func filterUserShopData() -> [ShopModel] {
        var resultData: [ShopModel] = []
        
        for itemList in userDataStore.user.followShopList {
            let filterData = shopDataStore.shopData.filter {$0.id == itemList}[0]
            resultData.append(filterData)
        }
        
        return sortShopData(resultData)
    }

    func sortShopData(_ bookMarkShops: [ShopModel]) -> [ShopModel] {
        switch selection {
        case "거리순":
            return bookMarkShops.sorted(by: {$0.shopName < $1.shopName}).sorted(by: {distance($0.location.latitude, $0.location.longitude) < distance($1.location.latitude, $1.location.longitude)})
        default:
            return bookMarkShops.sorted(by: {$0.shopName < $1.shopName})
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    // 정렬 기준 선택 버튼
                    Button {
                        showingActionSheet = true
                    } label: {
                        HStack {
                            Text("\(selection)")
                                .font(.bottles14)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.trailing, 20)
                }
                
                if userDataStore.user.followShopList.isEmpty {
                    VStack{
                        Spacer()
                            .frame(height: 100)
                        
                        Image(systemName: "house")
                            .font(.system(size: 50))
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Text("북마크된 바틀샵이 없습니다.")
                            .font(.bottles18)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(filterUserShopData()) { shop in
                            NavigationLink {
                                BottleShopView(bottleShop: shop)
                            } label: {
                                BookMarkShopListCell(
                                    userStore: userDataStore,
                                    shopDataStore: shopDataStore,
                                    shopInfo: shop,
                                    bookMarkAlarm: $bookMarkAlarm,
                                    resetDeletedShopId: $resetDeletedShopId,
                                    distance: distance(
                                        shop.location.latitude,
                                        shop.location.longitude))
                            }
                            Divider()
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
            // MARK: - 정렬 ActionSheet
            .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
                // TODO: 각 버튼 별로 정렬 액션 추가해야함
                Button("이름순") {
                    selection = "이름순"
                }
                
                Button("거리순") {
                    selection = "거리순"
                }
            }
            if bookMarkAlarm {
                HStack{
                    Image("BookMark")
                    Text("북마크가 해제되었습니다.")
                        .foregroundColor(.black)
                        .font(.bottles11)
                    Button {
                        userDataStore.addFollowShopId(resetDeletedShopId)
                        shopDataStore.addFollowUserList(userDataStore.user.email, resetDeletedShopId)
                    } label: {
                        Text("실행취소")
                            .font(.bottles11)
                    }
                }
                .zIndex(1)
                .transition(.opacity.animation(.easeIn))
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 30)
                        .foregroundColor(.gray_f7)
                }
                .offset(y: (UIScreen.main.bounds.height/4))
            }
        }
    }
}

struct BookMarkShopListCell: View {
    // Shop의 정보를 저장하는 변수
    var userStore: UserStore
    var shopDataStore: ShopDataStore
    var shopInfo: ShopModel
    // 북마크 알림
    @Binding var bookMarkAlarm: Bool
    @Binding var resetDeletedShopId: String
    var distance: Double
    
    var body: some View {
        HStack(alignment: .top) {
            // Shop 이미지
            AsyncImage(url: URL(string: shopInfo.shopTitleImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)
            } placeholder: {
                Image("ready_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)
            }
            .background(Color.gray_f7)
            .cornerRadius(12)
            .frame(height: 128)
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                // Shop 이름
                Text(shopInfo.shopName)
                    .font(.bottles18)
                    .bold()
                    .multilineTextAlignment(.leading)
                // Shop 소개글
                Text(shopInfo.shopIntroduction)
                    .font(.bottles14)
                    .multilineTextAlignment(.leading)
                Spacer()
                /// 현재 위치와 바틀샵과의 거리
                /// 초기 distance 값(m) -> km로 환산 후 소수점 1번째 자리까지 제거
                ///  distance -> m 값 분기처리
                if distance/1000 < 1 {
                    Text("\(String(format: "%.0f", round(distance))) m")
                        .font(.bottles14)
                        .foregroundColor(.gray)
                } else {
                    Text("\(String(format: "%.0f", round(distance/1000))) km")
                        .font(.bottles14)
                        .foregroundColor(.gray)
                }
            }
            .foregroundColor(.black)
            .padding(.vertical, 10)
            
            Spacer()
            VStack {
                // TODO: 즐겨찾기 기능 추가해야함
                Button {
                    resetDeletedShopId = shopInfo.id
                    userStore.deleteFollowShopId(shopInfo.id)
                    shopDataStore.deleteFollowUserList(userStore.user.id, shopInfo.id)
                    withAnimation(.easeIn(duration: 1)) {
                        bookMarkAlarm.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation(.easeIn(duration: 1)) {
                            bookMarkAlarm.toggle()
                        }
                    }
                } label: {
                    Image("BookMark.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 18)
                        .padding(.trailing, 10)
                }
                Spacer()
            }
            .font(.title2)
            .padding()
            .padding(.top, -5)
        }
        .frame(minHeight: 130, maxHeight: 300)
        .padding(.vertical, 5)
    }
}

//struct BookMarkShopList_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            BookMarkShopList()
//        }
//    }
//}
