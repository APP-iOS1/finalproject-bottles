//
//  NearBySheetView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI
import SkeletonUI
import CoreLocation

// MARK: - SkeletonUI
struct SkeletonColor: Identifiable {
    let id = UUID()
    let name: String
}

// MARK: - 둘러보기 디테일 뷰
struct NearBySheetView: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var shopDataStore: ShopDataStore
//    @StateObject var mapViewModel: MapViewModel
    //    @State private var checkBookmark: Bool = false
    @Binding var isOpen: Bool
    @Binding var showMarkerDetailView: Bool
    @Binding var currentShopId: String
    //    @Binding var shopModel: ShopModel

    @StateObject var coordinator: Coordinator = Coordinator.shared

    
    
    // MARK: - 현재 위치 좌표 거리 계산 함수
    func distance(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: coordinator.userLocation.0, longitude: coordinator.userLocation.1)
        //        print("\(from.distance(from: to))")
        return from.distance(from: to)
    }
    
    // MARK: - 둘러보기 뷰 거리 순 오름차순 정렬 함수
    func sortShopData() -> [ShopModel] {
        let shopModel: [ShopModel] = shopDataStore.shopData
        var distanceSortedShops : [ShopModel] = []
        for shop in shopModel {
            let distance = distance(shop.location.latitude, shop.location.longitude)
            if distance <= 5000 {
                distanceSortedShops.append(shop)
            }
        }
        return distanceSortedShops.sorted(by: {$0.shopName < $1.shopName }).sorted(by: {distance($0.location.latitude, $0.location.longitude) < distance($1.location.latitude, $1.location.longitude)})
    }
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                Text("내 주변 둘러보기")
                    .font(.bottles16)
                    .bold()
                    .padding(.leading, 15)
                Spacer()
            }
            
            if sortShopData().isEmpty {
                VStack {
                        Spacer()
                            .frame(height: 100)
                        
                        Image(systemName: "house")
                            .font(.system(size: 50))
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Text("내 주변 5km 반경 이내에 바틀샵이 없습니다.")
                            .font(.bottles18)
                            .fontWeight(.semibold)
                }
                .foregroundColor(.gray)
                Spacer()
            } else {
                ScrollView {
                    VStack {
                        ForEach(sortShopData(), id: \.self) { shop in
                                Button {
                                    isOpen = false
                                    coordinator.showMarkerDetailView = true
                                    coordinator.currentShopId = shop.id
                                    coordinator.coord = (shop.location.latitude, shop.location.longitude)
                                } label: {
                                    NearBySheetCell(shopModel: shop, distance: shopDataStore.distance(shop.location.latitude, shop.location.longitude))
                                }
                        }
                        .setSkeletonView(opacity: 0.3, shouldShow: showMarkerDetailView)
                    }
                }
            }
        }
        .background {
            Color.white
        }
    }
}

//struct NearBySheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NearBySheetView()
//    }
//}
