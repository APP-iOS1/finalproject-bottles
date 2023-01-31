//
//  SearchView.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

enum searchTapInfo : String, CaseIterable {
    case bottle = "상품 검색"
    case shop = "바틀샵 검색"
}

struct SearchView: View {
    // tap picker
    @State private var selectedPicker: searchTapInfo = .bottle
    @Namespace private var animation
    
    //searchBar
    @State var searchBarText: String = ""
    @State var isShowingSearchResult: Bool = false
    
    @State var doneTextFieldEdit: Bool = false
    
    @FocusState var focus: Bool
    
    var body: some View {
        VStack {
            SearchViewSearchBar(searchBarText: $searchBarText, doneTextFieldEdit: $doneTextFieldEdit, focus: _focus)
            
            if searchBarText == "" {
                RecentlyItemList()
            } else {
                if !doneTextFieldEdit {
                    SearchResultList(searchBarText: $searchBarText, doneTextFieldEdit: $doneTextFieldEdit, focus: _focus)
                } else {
                    animate()
                        .padding(.top, 10)
                    SearchTapView(searchTap: selectedPicker, bottleName: searchBarText)
                }
                
//                animate()
//                    .padding(.top, 10)
//                SearchTapView(searchTap: selectedPicker)
            }
        }
        .navigationBarHidden(true)
    }
    // MARK: - Picker Animation 함수
    @ViewBuilder
    private func animate() -> some View {
        VStack {
            HStack {
                ForEach(searchTapInfo.allCases, id: \.self) { item in
                    VStack {
                        Text(item.rawValue)
                            .kerning(-1)
                            .frame(maxWidth: 200, maxHeight: 30)
                            .foregroundColor(selectedPicker == item ? .black : .gray)
                            .padding(.top, 10)
                        
                        if selectedPicker == item {
                            Capsule()
                                .foregroundColor(.black)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "info", in: animation)
                        } else if selectedPicker != item {
                            Capsule()
                                .foregroundColor(.white)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            self.selectedPicker = item
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
        }
    }
}

struct SearchTapView: View {
    var searchTap: searchTapInfo
    var bottleName: String
    
    var body: some View {
        VStack {
            switch searchTap {
            case .bottle:
                SearchBottleList(bottleName: bottleName)
            case .shop:
                SearchShopList()
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView()
        }
    }
}