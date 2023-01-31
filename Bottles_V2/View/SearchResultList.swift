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
    
    @Binding var searchBarText: String
    @StateObject var testModel: BookMarkTestStore = BookMarkTestStore()
    
    @Binding var doneTextFieldEdit: Bool
    
    @FocusState var focus: Bool
    
    var body: some View {
        List {
            ForEach (testModel.BookMarkBottles, id: \.self) { bottle in
                
                //검색어와 겹치는 단어가 있는지 없는지 확인
                if bottle.bottleName.contains(searchBarText) {
                    Button {
                        doneTextFieldEdit = true
                        
                        // 사용자가 리스트에서 찾고자하는 단어가 있어 터치 시, 해당 단어를 검색창의 텍스트로 전환
                        searchBarText = bottle.bottleName
                        
                        focus = false
                        
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
}


// MARK: - 특정 범위 텍스트 컬러 설정
/// 사용자의 검색어와 동일한 텍스트의 컬러를 바꿔주기 위한 Extension
extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}


//struct SearchResultList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultList(searchBarText: .constant(""))
//    }
//}
