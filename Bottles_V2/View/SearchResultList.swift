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
                            Text(bottle.bottleName) { string in
                                if let range = string.range(of: searchBarText) {
                                    string[range].foregroundColor = Color("AccentColor")
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

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
