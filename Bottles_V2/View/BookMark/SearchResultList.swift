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
    
    var body: some View {
        List {
            ForEach (testModel.BookMarkBottles, id: \.self) { bottle in
                if bottle.BottleName.contains(searchBarText) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding([.leading, .trailing])
                        Text(bottle.BottleName)
                    }
                    
                }
            }
            
        }
        .listStyle(.plain)
    }
}


struct SearchResultList_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultList(searchBarText: .constant(""))
    }
}
