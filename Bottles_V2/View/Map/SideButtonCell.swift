//
//  SideButtonCell.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/02/02.
//

import SwiftUI
// MARK: - 맵뷰 사이드 셀 자리(북마크 & GPS 버튼)
struct SideButtonCell: View {
    @EnvironmentObject var userDataStore: UserStore
    @EnvironmentObject var shopDataStore: ShopDataStore
//    @StateObject var mapViewModel: MapViewModel
//    @StateObject var coordinator: Coordinator = Coordinator.shared
    @Binding var tapSearchButton: Bool
    @Binding var userLocation: (Double, Double)
    @Binding var isBookMarkTapped: Bool
//    @Binding var coordinator: Coordinator
    var body: some View {
        VStack(spacing: -20) {
            
            // MARK: - 북마크 버튼
            Button {
                isBookMarkTapped.toggle()
                if isBookMarkTapped {
                    print(isBookMarkTapped)
                    Coordinator.shared.removeMarkers()
                    Coordinator.shared.shopDataStore.shopData = shopDataStore.shopData
                    Coordinator.shared.userDataStore.user = userDataStore.user
                    Coordinator.shared.makeBookMarkedMarkers()
                    if Coordinator.shared.bookMarkedMarkers.isEmpty {
                        tapSearchButton = true
                    }
                    print("Coordinator.shared.markers.count: \(Coordinator.shared.bookMarkedMarkers.count)")
                } else {
                    tapSearchButton = false
                    print(isBookMarkTapped)
                    Coordinator.shared.removeMarkers()
                    Coordinator.shared.shopDataStore.shopData = shopDataStore.shopData
                    Coordinator.shared.userDataStore.user = userDataStore.user
                    Coordinator.shared.makeMarkers()
                    print("Coordinator.shared.markers.count: \(Coordinator.shared.markers.count)")
                }
            } label: {
                Image(isBookMarkTapped ? "Map_BookMark_tapped" : "Map_BookMark")
            }
            
            // MARK: - 현 위치 버튼
            Button {
//                mapViewModel.coord = mapViewModel.userLocation
                Coordinator.shared.fetchUserLocation()
                // current Coordinate -> mapViewModel 설정
                print("userLocation : \(userLocation)")
            } label: {
                Image("Map_GPS")
            }
        }
    }
}

//struct SideButtonCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SideButtonCell()
//    }
//}
