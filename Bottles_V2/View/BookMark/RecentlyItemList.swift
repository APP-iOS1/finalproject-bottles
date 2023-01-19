//
//  RecentlyItemList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/20.
//

import SwiftUI

struct RecentlyItemList: View {
    var recentSearches: [String] = ["와인", "와인앤모어", "위스키", "선물", "킬호만"]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(recentSearches, id: \.self) { search in
                        Button  {
                            
                        } label: {
                            Text(search)
                                .padding(12)
                                .background(RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 1))
                                .padding()
                        }     
                    }
                }
            }
//            .scrollIndicators(.hidden)
        }
    }
}

struct RecentlyItemList_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyItemList()
    }
}
