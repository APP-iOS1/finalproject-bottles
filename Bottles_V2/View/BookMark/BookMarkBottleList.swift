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
    
    // 북마크 알림
    @State var bookMarkAlarm: Bool = false
    @State var resetDeletedBottleId: String = ""
    
    // MARK: Server Data
    @EnvironmentObject var userDataStore: UserStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @EnvironmentObject var shopDataStore: ShopDataStore
    @EnvironmentObject var mapViewModel: MapViewModel
    
    func getMatchedShopData(bottleData: BottleModel) -> ShopModel {
        let matchedShopData = shopDataStore.shopData.filter {$0.id == bottleData.shopID}
        return matchedShopData[0]
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
        switch selection {
        case "거리순":
            return filterBottleData.sorted(by: {$0.itemName < $1.itemName})

                .sorted(by: {distance(getMatchedShopData(bottleData: $0).location.latitude, getMatchedShopData(bottleData: $0).location.longitude) < distance(getMatchedShopData(bottleData: $1).location.latitude, getMatchedShopData(bottleData: $1).location.longitude)})

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
        let to = CLLocation(latitude: Coordinator.shared.userLocation.0, longitude: Coordinator.shared.userLocation.1)
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
                if userDataStore.user.followItemList.isEmpty {
                    
                    VStack{
                        Spacer()
                            .frame(height: 100)
                        
                        Image(systemName: "wineglass")
                            .font(.system(size: 50))
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Text("북마크된 상품이 없습니다.")
                            .font(.bottles18)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(filterUserBottleData()) { bottle in
                            BookMarkBottleListCell(bottleInfo: bottle, shopInfo: getMatchedShopData(bottleData: bottle),   userStore: userDataStore, bookMarkAlarm: $bookMarkAlarm, deletedBottleId: $resetDeletedBottleId)
                            Divider()
                                .padding(.horizontal, 10)
                        }
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
                    
                    Button {
                        userDataStore.addFollowItemId(resetDeletedBottleId)
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

struct BookMarkBottleListCell: View {
    // Bottle의 정보를 저장하는 변수
    var bottleInfo: BottleModel
    // Shop의 정보를 저장하는 변수
    var shopInfo: ShopModel
    var userStore: UserStore
    // 북마크 알림
    @Binding var bookMarkAlarm: Bool
    @Binding var deletedBottleId: String
    
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
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                // Bottle 가격
                Text("\(bottleInfo.itemPrice)원")
                    .font(.bottles18)
                    .bold()
                // 해당 Bottle을 판매하는 Shop으로 이동하는 버튼
                NavigationLink {
                    BottleShopView(bottleShop: shopInfo)
                } label: {
                    HStack {
                        Image("Map_tab_fill")
                            .resizable()
                            .frame(width: 14, height: 17)
                        // Shop 이름
                        Text(bottleInfo.shopName)
                            .font(.bottles14)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                }
                Spacer()
            }
            .padding(.top, 10)
            
            Spacer()
            VStack {
                Button {
                    deletedBottleId = bottleInfo.id
                    userStore.deleteFollowItemId(bottleInfo.id)
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
                        .padding(.horizontal, 10)
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

struct BookMarkBottleList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookMarkBottleList()
        }
    }
}
