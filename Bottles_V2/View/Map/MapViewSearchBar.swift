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
    @Binding var mapSearchBarText: String
    @Binding var searchResult: [ShopModel]
    @Binding var currentShopId: String
    @Binding var tapSearchButton: Bool
    
    var body: some View {
        HStack {
            TextField("", text: $mapSearchBarText)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
                .font(.bottles15)
            
            if !mapSearchBarText.isEmpty {
                Button(action: {
                    searchResult = shopDataStore.shopData
                    self.mapSearchBarText = ""
                }) {
                    Image("xmark")
                }
            } else {
                EmptyView()
            }
            
            Button {
                
                searchResult = getSearchResult(searchText: mapSearchBarText)
                print("====\(mapSearchBarText) 검색 결과 : \(searchResult)")
                
                if searchResult.isEmpty || mapSearchBarText.isEmpty {
                    //                    withAnimation(.easeIn(duration: 2)) {
                    tapSearchButton.toggle()
                    //                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        //                        withAnimation(.easeIn(duration: 2)) {
                        tapSearchButton.toggle()
                        //                        }
                    }
                } else {
                    for result in searchResult {
                        print(result.id)
                        currentShopId = result.id
                        mapViewModel.coord = (result.location.latitude, result.location.longitude)
                        showMarkerDetailView = true
                    }
                }
            } label: {
                Image("magnifyingglass")
                    .foregroundColor(.accentColor)
                    .bold()
            }
        }
        .padding(10)
        .frame(width: 300)
        .background{
            Color.white
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
