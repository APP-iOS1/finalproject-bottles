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
    // 북마크 알림 Test
    @State var bookMarkAlarm: Bool = false
    
    // Server Data Test
    @EnvironmentObject var shopDataStore: ShopDataStore
    @EnvironmentObject var mapViewModel: MapViewModel
    
    var testShopData: [ShopModel] {
        var test: [ShopModel] = []
        for i in 0...9 {
            test.append( shopDataStore.shopData[i])
        }
        return test
    }
    
    func distance(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: mapViewModel.userLocation.0, longitude: mapViewModel.userLocation.1)
        print("\(from.distance(from: to))")
        return from.distance(from: to)
    }

    func sortShopData() -> [ShopModel] {
        let bookMarkShops: [ShopModel] = testShopData
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

                // TODO: 서버 Shop 데이터 연결
                ScrollView {
                    ForEach(sortShopData()) { shop in
                        NavigationLink {
                            BottleShopView(bottleShop: shop)
                        } label: {
                            BookMarkShopListCell(shopInfo: shop, bookMarkAlarm: $bookMarkAlarm, distance: distance(shop.location.latitude, shop.location.longitude))
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

struct BookMarkShopListCell: View {
    // Shop의 정보를 저장하는 변수
    var shopInfo: ShopModel
    @Binding var bookMarkAlarm: Bool
    var distance: Double
    
    var body: some View {
        HStack(alignment: .top) {
            // Shop 이미지
            AsyncImage(url: URL(string: shopInfo.shopTitleImage)) { image in
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
            
            VStack(alignment: .leading, spacing: 8) {
                // Shop 이름
                Text(shopInfo.shopName)
                    .font(.bottles18)
                    .bold()
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

//struct BookMarkShopList_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            BookMarkShopList()
//        }
//    }
//}
//"https://wine21.speedgabia.com/NEWS_MST/froala/202007/20200716101122567972.jpg"
