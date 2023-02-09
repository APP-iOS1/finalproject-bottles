//
//  BookMarkBottleList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI
import CoreLocation

struct BookMarkBottleList: View {
    // ActionSheet (iOS 14 이하 - ActionSheet, iOS 15 이상 - confirmationDialog 사용해야함)
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
    
    // 북마크 알림 Test
    @State var bookMarkAlarm: Bool = false
    
    // MARK: Server Data Test
//    @StateObject var userDataStore: UserStore = UserStore()
    @EnvironmentObject var userDataStore: UserStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @EnvironmentObject var shopDataStore: ShopDataStore
    @EnvironmentObject var mapViewModel: MapViewModel
    
    func getMattchedShopData(bottleData: BottleModel) -> ShopModel {
        let mattchedShopData = shopDataStore.shopData.filter {$0.shopName == bottleData.shopName}
        return mattchedShopData[0]
    }
    
    func filterUserBottleData() -> [BottleModel] {
        var resultData: [BottleModel] = []
        
        for itemList in userDataStore.user.followItemList {
            let filterData = bottleDataStore.bottleData.filter {$0.id == itemList}[0]
            resultData.append(filterData)
        }
        
        return sortBottleData(resultData)
    }
    
    func sortBottleData(_ filterBottleData: [BottleModel]) -> [BottleModel] {
        print("userdata is \(userDataStore.user)")
        let bookMarkBottles: [BottleModel] = bottleDataStore.bottleData
        switch selection {
        case "거리순":
            return filterBottleData.sorted(by: {$0.itemName < $1.itemName})
                .sorted(by: {distance(getMattchedShopData(bottleData: $0).location.latitude, getMattchedShopData(bottleData: $0).location.longitude) < distance(getMattchedShopData(bottleData: $1).location.latitude, getMattchedShopData(bottleData: $1).location.longitude)})
        case "낮은 가격순":
            return filterBottleData.sorted(by: {$0.itemName < $1.itemName}).sorted(by: {$0.itemPrice < $1.itemPrice})
        case "높은 가격순":
            return filterBottleData.sorted(by: {$0.itemName < $1.itemName}).sorted(by: {$0.itemPrice > $1.itemPrice})
        default:
            return filterBottleData.sorted(by: {$0.itemName < $1.itemName})
        }
    }
    
    func distance(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: mapViewModel.userLocation.0, longitude: mapViewModel.userLocation.1)
        print("\(from.distance(from: to))")
        return from.distance(from: to)
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
                
                // TODO: 서버 Bottle 데이터 연결
                ScrollView {
                    ForEach(filterUserBottleData()) { bottle in
                        // 테스트용
//                        if bottle.bookMark == true {
                        BookMarkBottleListCell(bottleInfo: bottle, shopInfo: getMattchedShopData(bottleData: bottle), userStore: userDataStore, bookMarkAlarm: $bookMarkAlarm)
//                        }
                    }
                }
            }
            // MARK: - 정렬 ActionSheet
            .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
                // TODO: 각 버튼 별로 정렬 액션 추가해야함
                Button {
                    selection = "이름순"
                } label: {
                    Text("이름순")
                }
                
                Button("거리순") {
                    selection = "거리순"
                }
                
                Button("낮은 가격순") {
                    selection = "낮은 가격순"
                }
                
                Button("높은 가격순") {
                    selection = "높은 가격순"
                }
            }
            if bookMarkAlarm {
                HStack{
                    Image("BookMark")
                    Text("북마크가 해제되었습니다.")
                        .foregroundColor(.black)
                        .font(.bottles11)
                    
                }
                .zIndex(1)
                .transition(.opacity.animation(.easeIn))
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 30)
                        .foregroundColor(.gray_f7)
                }
                .offset(y: 250)
            }
        }
    }
}

struct BookMarkBottleListCell: View {
    // Bottle의 정보를 저장하는 변수
    var bottleInfo: BottleModel
    // Shop의 정보를 저장하는 변수
    var shopInfo: ShopModel
    var userStore: UserStore
    // Test
    @Binding var bookMarkAlarm: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            // 이미지를 누르면 Bottle Detail View로 이동
            NavigationLink {
                BottleView(bottleData: bottleInfo)
            } label: {
                // Bottle 이미지
                AsyncImage(url: URL(string: bottleInfo.itemImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
            }
            
            
            VStack(alignment: .leading, spacing: 10) {
                // Bottle 이름
                Text(bottleInfo.itemName)
                    .font(.bottles14)
                // Bottle 가격
                Text("\(bottleInfo.itemPrice)원")
                    .font(.bottles18)
                    .bold()
                // Test용 Shop 정보
//                Text("\(shopInfo.shopIntroduction)")
//                    .font(.footnote)
                // 해당 Bottle을 판매하는 Shop으로 이동하는 버튼
                NavigationLink {
//                    BottleShopView(bottleShop: <#ShopModel#>)
                } label: {
                    HStack {
                        Image("MapMarker")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        // Shop 이름
                        Text(bottleInfo.shopName)
                            .font(.bottles14)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            .padding(.top, 10)
            
            Spacer()
            VStack {
                // TODO: 즐겨찾기 기능 추가해야함
                Button {
                    userStore.deleteFollowItemId(bottleInfo.id)
                    withAnimation(.easeIn(duration: 1)) {
                        bookMarkAlarm.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        withAnimation(.easeIn(duration: 1)) {
                            bookMarkAlarm.toggle()
                        }
                    }
                } label: {
                    Image(systemName: "bookmark.fill")
                }
                Spacer()
            }
            .font(.title2)
            .padding()
            .padding(.top, -5)
        }
        .frame(height: 130)
        .padding(.vertical, 5)
    }
}

struct BookMarkBottleList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookMarkBottleList()
        }
    }
}
