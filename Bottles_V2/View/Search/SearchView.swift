//
//  SearchView.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

// Search Tab의 종류를 담은 열거형
enum searchTabInfo : String, CaseIterable {
    case bottle = "상품 검색"
    case shop = "바틀샵 검색"
}

struct SearchView: View {
    // tap picker
    @State private var selectedPicker: searchTabInfo = .bottle
    @Namespace private var animation
    // searchBar
    @State var searchBarText: String = ""
    @State var isShowingSearchResult: Bool = false
    // 검색을 완료했는지 판단하는 Bool 값
    @State var doneTextFieldEdit: Bool = false
//     검색 TextField 작성 완료시 키보드를 내리기위한 Bool 값
    @FocusState var focus: Bool
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var searchHistory: FetchedResults<SearchHistory>
    
    // transition Test
    @Binding var transitionView: Bool
    
    @Binding var root: Bool
    
    var body: some View {
        VStack {
            HStack{
                // 검색바 + 장바구니 버튼
                SearchViewSearchBar(searchBarText: $searchBarText, doneTextFieldEdit: $doneTextFieldEdit, focus: _focus, transitionView: $transitionView)
                CartViewNavigationLink()
            }
            .padding(.top)
            // 검색어를 입력하지 않았을 시에 최근 검색어 및 최근 본 상품을 보여준다
            if searchBarText == "" {
                RecentlyItemList(searchBarText: $searchBarText, doneTextFieldEdit: $doneTextFieldEdit, focus: _focus, root: $root)
            } else {
                // 검색어를 입력 중이고 검색을 완료하지 않았으면 검색어를 포함한 Bottle, Shop 들을 보여준다
                if !doneTextFieldEdit {
                    SearchResultList(searchBarText: $searchBarText, doneTextFieldEdit: $doneTextFieldEdit, focus: _focus, selectedPicker: $selectedPicker)
                } else {
                    // 검색을 완료하면 검색어에 해당하는 검색 결과 탭뷰를 보여준다
                    animate()
                        .padding(.top, 10)
                    SearchTabView(searchTab: selectedPicker, bottleName: searchBarText, root: $root)
                }
            }
        }
        .navigationBarHidden(true)
    }
    // MARK: - Picker Animation 함수
    @ViewBuilder
    private func animate() -> some View {
        VStack {
            HStack {
                ForEach(searchTabInfo.allCases, id: \.self) { item in
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

struct SearchTabView: View {
    var searchTab: searchTabInfo
    // 검색어를 bottleName 변수로 받는다
    var bottleName: String
    
    @Binding var root: Bool
    
    var body: some View {
        VStack {
            switch searchTab {
            case .bottle:
                SearchBottleList(bottleName: bottleName, root: $root)
            case .shop:
                SearchShopList(shopName: bottleName, root: $root)
            }
        }
    }
}


//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SearchView()
//        }
//    }
//}
