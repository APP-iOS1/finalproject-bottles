//
//  NearBySheetView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI
import SkeletonUI
import CoreLocation

// MARK: - 둘러보기 디테일 뷰
struct NearBySheetView: View {
    @EnvironmentObject var shopDataStore: ShopDataStore
    @StateObject var mapViewModel: MapViewModel
    //    @State private var checkBookmark: Bool = false
    @Binding var isOpen: Bool
    @Binding var showMarkerDetailView: Bool
    @Binding var currentShopId: String
    //    @Binding var shopModel: ShopModel
    @State var colors = [SkeletonColor]()
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                Text("내 주변 둘러보기")
                    .font(.bottles16)
                    .bold()
                    .padding(.leading, 15)
                Spacer()
            }
            
            // 현재 위치 mapViewModel.userLocation
            ScrollView {
                LazyVStack {
                    ForEach(Array(sortShopData().enumerated()), id: \.offset) { (index, shop) in
                        let distance = distance(shop.location.latitude, shop.location.longitude)
                        if distance <= 5000 {
                            Button {
                                isOpen = false
                                showMarkerDetailView = true
                                currentShopId = shop.id
                                mapViewModel.coord = (shop.location.latitude, shop.location.longitude)
                            } label: {
                                NearBySheetCell(shopModel: shop, distance: distance)
                            }
                        }
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.colors = [
                        SkeletonColor(name: "GREEN"),
                        SkeletonColor(name: "RED"),
                        SkeletonColor(name: "BLUE"),
                        SkeletonColor(name: "BLACK")
                    ]
                }
            }
        }
        
        .background {
            Color.white
        }
    }
    // MARK: - 현재 위치 좌표 거리 계산 함수
    func distance(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: mapViewModel.userLocation.0, longitude: mapViewModel.userLocation.1)
        //        print("\(from.distance(from: to))")
        return from.distance(from: to)
    }
    // MARK: - 둘러보기 뷰 거리 순 오름차순 정렬 함수
    func sortShopData() -> [ShopModel] {
        let shopModel: [ShopModel] = shopDataStore.shopData
        return shopModel.sorted(by: {$0.shopName < $1.shopName }).sorted(by: {distance($0.location.latitude, $0.location.longitude) < distance($1.location.latitude, $1.location.longitude)})
    }
}

struct SkeletonColor: Identifiable {
    let id = UUID()
    let name: String
}

//struct NearBySheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NearBySheetView()
//    }
//}
