//
//  NearBySheetView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI
import CoreLocation

// MARK: - 둘러보기 디테일 뷰
struct NearBySheetView: View {
    @EnvironmentObject var shopDataStore: ShopDataStore
    @StateObject var mapViewModel: MapViewModel
    @State private var checkBookmark: Bool = false

    @Binding var isOpen: Bool
    @Binding var showMarkerDetailView: Bool
    @Binding var currentShopIndex: Int
//    @Binding var coord: (Double, Double)
    
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
                    ForEach(Array(shopDataStore.shopData.enumerated()), id: \.offset) { (index, shop) in
                        let distance = distance(shop.location.latitude, shop.location.longitude)
                        if distance <= 5000 {
                            Button {
                                isOpen = false
                                showMarkerDetailView = true
                                currentShopIndex = index
                                mapViewModel.coord = (shop.location.latitude, shop.location.longitude)
                            } label: {
                                NearBySheetCell(checkBookmark: $checkBookmark, shopModel: shop)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func distance(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: mapViewModel.userLocation.0, longitude: mapViewModel.userLocation.1)
        print("\(from.distance(from: to))")
        return from.distance(from: to)
    }
}

//struct NearBySheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NearBySheetView()
//    }
//}
