//
//  BookMarkViewSearchBar.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

// SearchView에서 사용하는 검색바
struct SearchViewSearchBar: View {
    // 검색바에 입력된 Text
    @Binding var searchBarText: String
    // Back Button 구현을 위한 변수
    @Environment(\.dismiss) private var dismiss
    // 검색을 완료했는지 판단하는 Bool 값
    @Binding var doneTextFieldEdit: Bool
    // 검색 TextField 작성 완료시 키보드를 내리기위한 Bool 값
    @FocusState var focus: Bool
    // coreData
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var searchHistory: FetchedResults<SearchHistory>
    
    // transition Test
    @Binding var transitionView: Bool
    
    var body: some View {
        
        // MARK: - SearchBar
        HStack {
            //  Navigation Bar 의 Back Button을 유사하게 구현
            Button {
//                dismiss()
                withAnimation(.spring(response: 0.5)) {
                    transitionView.toggle()
                    focus = false
                }
                
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
            }
            .padding(5)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .font(.system(size: 18))
                // 검색바 TextField
                // onEditingChanged : TextField 편집 상태를 bool값으로 받는다
                // onCommit : TextField 작업 중 Return 키를 누를 때 수행할 작업
                TextField("원하는 술, 바틀샵 검색", text: $searchBarText, onEditingChanged: { bool in
                    if bool {
                        doneTextFieldEdit = false
                    } else {
                        doneTextFieldEdit = true
                    }
                }, onCommit: {
                    doneTextFieldEdit = true
                    // CoreData 최근 검색어 추가
                    addSearchHistory()
                    
                })
                .font(.bottles16)
                .multilineTextAlignment(.leading)
                .submitLabel(.search)
                .focused($focus)
                
                if !searchBarText.isEmpty {
                    Button(action: {
                        self.searchBarText = ""
                        focus = false
                    }) {
                        Image("xmark")
                    }
                    .padding(.trailing, 8)
                } else {
                    EmptyView()
                }
            }
            .padding(10)
            .frame(width: 270, height: 52)
            .background{
                Color.gray_f7
            }
            .cornerRadius(12)
        }
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

//struct SearchViewSearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchViewSearchBar()
//    }
//}
