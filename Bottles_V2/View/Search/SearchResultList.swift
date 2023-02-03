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
    // 테스트용 모델
    @StateObject var bookMarkTestStore: BookMarkTestStore = BookMarkTestStore()
    // coreData
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var searchHistory: FetchedResults<SearchHistory>
    
    var body: some View {
        List {
            ForEach (bookMarkTestStore.BookMarkBottles, id: \.self) { bottle in
                
                // 검색어와 겹치는 단어가 있는지 없는지 확인
                if bottle.bottleName.contains(searchBarText) {
                    Button {
                        doneTextFieldEdit = true
                        
                        // 사용자가 리스트에서 찾고자하는 단어가 있어 터치 시, 해당 단어를 검색창의 텍스트로 전환
                        searchBarText = bottle.bottleName
                        
                        focus = false
                        // CoreData 최근 검색어 추가
                        addSearchHistory()
                        
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing])
                            
                            // 검색어와 겹치는 단어가 있는 bottleName의 경우, 검색어와 겹치는 단어들만 accentColor
                            // 현재는 shop을 제외한 bottleName만 리스트에 보임
                            Text(bottle.bottleName) { string in
                                if let range = string.range(of: searchBarText) {
                                    string[range].foregroundColor = Color("AccentColor")
                                }
                            }
                        }
                        .font(.bottles16)
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
