//
//  MapViewSearchBar.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct MapViewSearchBar: View {
    
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var shopDataStore: ShopDataStore
    @Binding var showMarkerDetailView: Bool
    @Binding var searchBarText: String
    @Binding var searchResult: [ShopModel]
    @Binding var currentShopId: String
    @Binding var tapSearchButton: Bool
    @FocusState var focus: Bool  // 포커스된 텍스트필드
    @StateObject var coordinator: Coordinator = Coordinator.shared

    
    var body: some View {
        HStack {
            TextField("바틀샵을 입력해주세요", text: $searchBarText)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
                .font(.bottles15)
                .focused($focus)
            if !searchBarText.isEmpty {
                Button(action: {
                    searchResult = shopDataStore.shopData
                    self.searchBarText = ""
                }) {
                    Image("xmark")
                }
            } else {
                EmptyView()
            }
            
            Button {
                searchResult = getSearchResult(searchText: searchBarText)
                print("====\(searchBarText) 검색 결과 : \(searchResult)")
                
                if searchResult.isEmpty || searchBarText.isEmpty {
                    //                    withAnimation(.easeIn(duration: 2)) {
                    tapSearchButton.toggle()
                    //                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        //                        withAnimation(.easeIn(duration: 2)) {
                        tapSearchButton.toggle()
                        //                        }
                    }
                }
                else {
                    for result in searchResult {
                        print(result.id)
                        coordinator.currentShopId = result.id
                        print("coordinator.currentShopId: \(coordinator.currentShopId)")
                        coordinator.coord = (result.location.latitude, result.location.longitude)
                        print("coordinator.coord: \(coordinator.coord)")
//                        coordinator.moveCameraPosition()
//                        showMarkerDetailView = true
                    }
                }
            } label: {
                Image("magnifyingglass")
                    .foregroundColor(.accentColor)
//                    .bold()
            }
        }
        .padding(10)
        .frame(width: 280, height: 34)
        .background {
            Color.gray_f7
        }
        .cornerRadius(10)
        //        .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
    }
    // 검색 기능
    func getSearchResult(searchText: String) -> [ShopModel] {
        let filteredData = self.shopDataStore.shopData
        
        if !searchText.isEmpty {
            return filteredData.filter {
                $0.shopName.contains(searchText)
            }
        }
        return filteredData
    }
}

//struct MapViewSearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        MapViewSearchBar(mapSearchBarText: .constant(""), searchResult: <#Binding<[ShopModel]>#>)
//    }
//}
