//
//  SearchResultList.swift
//  Bottles_V2
//
//  Created by 장다영 on 2023/01/30.
//

import SwiftUI

struct SearchResultList: View {
    
    @Binding var searchBarText: String
    @StateObject var testModel: BookMarkTestStore = BookMarkTestStore()
    
    @Binding var doneTextFieldEdit: Bool
    
    @FocusState var focus: Bool
    
    var body: some View {
        List {
            ForEach (testModel.BookMarkBottles, id: \.self) { bottle in
                if bottle.bottleName.contains(searchBarText) {
                    Button {
                        doneTextFieldEdit = true
                        searchBarText = bottle.bottleName
                        focus = false
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing])
                            Text(bottle.bottleName)
                        }
                    }
                }
            }
            
        }
        .listStyle(.plain)
    }
}


//struct SearchResultList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultList(searchBarText: .constant(""))
//    }
//}
