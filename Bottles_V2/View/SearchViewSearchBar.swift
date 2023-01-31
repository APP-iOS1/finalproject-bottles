//
//  BookMarkViewSearchBar.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchViewSearchBar: View {
    @Binding var searchBarText: String
    @Environment(\.dismiss) private var dismiss
    
    @Binding var doneTextFieldEdit: Bool
    
    @FocusState var focus: Bool
    
    var body: some View {
        
        // MARK: - SearchBar
        HStack {
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
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(10)
            .frame(width: 300)
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
