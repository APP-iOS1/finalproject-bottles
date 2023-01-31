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
    
    var body: some View {
        
        // MARK: - SearchBar
        HStack {
            //  Navigation Bar 의 Back Button을 유사하게 구현
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
            }
            .padding(5)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.accentColor)
                    .bold()
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
                })
                .multilineTextAlignment(.leading)
                .submitLabel(.search)
                .focused($focus)
                
                if !searchBarText.isEmpty {
                    Button(action: {
                        self.searchBarText = ""
                        focus = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(10)
            .frame(width: 270, height: 50)
            .background{
                Color.white
            }
            .cornerRadius(10)
            .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
        }
    }
}

//struct SearchViewSearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchViewSearchBar()
//    }
//}
