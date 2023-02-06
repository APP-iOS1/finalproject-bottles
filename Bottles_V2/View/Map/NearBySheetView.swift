//
//  NearBySheetView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

// MARK: - 둘러보기 디테일 뷰
struct NearBySheetView: View {
    @EnvironmentObject var shopDataStore: ShopDataStore
    @StateObject var mapViewModel: MapViewModel
    @Binding var isOpen: Bool
    @Binding var showMarkerDetailView: Bool
    @Binding var currentShopIndex: Int
    @Binding var coord: (Double, Double)
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                Text("내 주변 둘러보기")
                    .font(.bottles14)
                    .bold()
                    .padding(.leading, 15)
                Spacer()
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(Array(shopDataStore.shopData.enumerated()), id: \.offset) { (index, shop) in
                        Button {
                            isOpen = false
                            showMarkerDetailView = true
                            currentShopIndex = index
                            mapViewModel.coord = (shop.location.latitude, shop.location.longitude)
                        } label: {
                            NearBySheetCell(shopModel: shop)
                        }
                    }
                }
            }
        }
    }
}

//struct NearBySheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NearBySheetView()
//    }
//}
