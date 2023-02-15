//
//  SearchResultList.swift
//  Bottles_V2
//
//  Created by 장다영 on 2023/01/30.
//

import SwiftUI

// MARK: - 검색 중 View
/// 사용자가 검색창에 텍스트 입력 시,
/// 해당 검색어가 포함되어 있는 단어들의 리스트를 보여주는 View

// TODO: - bottle과 shop 모두에서 겹치는 단어가 있는지 없는지를 찾아야함
///현재 bottle만 검색 가능

struct SearchResultList: View {
    // 검색바에 입력된 Text
    @Binding var searchBarText: String
    // 검색을 완료했는지 판단하는 Bool 값
    @Binding var doneTextFieldEdit: Bool
    // 검색 TextField 작성 완료시 키보드를 내리기위한 Bool 값
    @FocusState var focus: Bool
    // 검색 결과뷰의 Tab을 결정하는 값
    @Binding var selectedPicker: searchTabInfo
    
    // coreData
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var searchHistory: FetchedResults<SearchHistory>
    
    // Server Data Test
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @EnvironmentObject var shopDataStore: ShopDataStore
    struct SearchResult: Hashable {
        let name: String
        let type: String
    }
    var bottleAndShop: [SearchResult] {
        let bookMarkBottles = bottleDataStore.bottleData
        let bookMarkShops = shopDataStore.shopData
        var bottleAndShop: [SearchResult] = []
        
        for bottle in bookMarkBottles {
            bottleAndShop.append(SearchResult(name: bottle.itemName, type: "bottle"))
        }
        for shop in bookMarkShops {
            bottleAndShop.append(SearchResult(name: shop.shopName, type: "shop"))
        }
        let setbottleAndShop = Set(bottleAndShop)
        return Array(setbottleAndShop).sorted(by: {$0.name < $1.name})
    }

    var body: some View {
        List {
            ForEach (bottleAndShop, id: \.self) { item in
                
                // 검색어와 겹치는 단어가 있는지 없는지 확인
                if item.name.replacingOccurrences(of: " ", with: "").localizedCaseInsensitiveContains(searchBarText.replacingOccurrences(of: " ", with: "")) {
                    Button {
                        doneTextFieldEdit = true
                        
                        // 사용자가 리스트에서 찾고자하는 단어가 있어 터치 시, 해당 단어를 검색창의 텍스트로 전환
                        searchBarText = item.name
                        
                        focus = false
                        // CoreData 최근 검색어 추가
                        addSearchHistory()
                        // 검색어 타입에 따라 검색 결과뷰에서 보여주는 Tab을 결정
                        if item.type == "bottle" {
                            selectedPicker = .bottle
                        } else {
                            selectedPicker = .shop
                        }
                        
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing])
                            
                            // 검색어와 겹치는 단어가 있는 bottleName의 경우, 검색어와 겹치는 단어들만 accentColor
                            // 현재는 shop을 제외한 bottleName만 리스트에 보임
                            Text(item.name) { string in
                                if let range = string.range(of: searchBarText.trimmingCharacters(in: .whitespaces), options: .caseInsensitive) {
                                    string[range].foregroundColor = Color("AccentColor")
                                }
                            }
                            .font(.bottles16)
                            Spacer()
                            if item.type == "bottle" {
                                Image(systemName: "wineglass")
                                    .foregroundColor(.accentColor)
                                    .font(.bottles16)
                            } else {
                                Image("Map_tab_fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    func addSearchHistory() {
        var check: Bool = true
        // 중복 검사 (중복시 삭제)
        for search in searchHistory {
            if search.text == searchBarText {
                managedObjContext.delete(search)
                check = false
            }
        }
        // 5개로 개수 제한
        if searchHistory.count == 5 && check {
            managedObjContext.delete(searchHistory[4])
        }
        // Add
        DataController().addSearchHistory(text: searchBarText, context: managedObjContext)
    }
}


//struct SearchResultList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultList(searchBarText: .constant(""))
//    }
//}
