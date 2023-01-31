//
//  SearchBottleList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchBottleList: View {
    var bottleName: String
    
    @StateObject var bookMarkTestStore: BookMarkTestStore = BookMarkTestStore()
    
    var filteredResult: [BookMarkBottle] {
        let bottles = bookMarkTestStore.BookMarkBottles
        return bottles.filter {
            $0.bottleName.contains(bottleName)
        }
    }
    
    var body: some View {
        VStack {
            if filteredResult == [] {
                Text("검색 결과가 없습니다.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                Spacer()
            } else {
                ScrollView {
                    ForEach(filteredResult, id: \.self) { bottle in
                        SearchBottleListCell(bottleInfo: bottle)
                    }
                }
            }
        }
    }
}

struct SearchBottleListCell: View {
    var bottleInfo: BookMarkBottle
    
    var body: some View {
        HStack(alignment: .top) {
                    Image("whisky_Image1")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .cornerRadius(10)
                         .frame(width: 120, height: 120)
                         .padding(.horizontal)
    
            VStack(alignment: .leading, spacing: 10) {
                Text(bottleInfo.bottleName)
                    .font(.title3)
                Text("350,000원")
                NavigationLink {
                    BottleShopView()
                } label: {
                    HStack {
                        Image("MapMarker")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        Text("와인앤모어")
                    }
                }
            }
            .bold()
            .padding(.vertical)
            
            Spacer()
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "bookmark.fill")
                }
                Spacer()
            }
            .font(.title2)
            .padding()
        }
        .frame(height: 130)
        .padding(.vertical, 5)
    }
}

//struct SearchBottleList_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SearchBottleList()
//        }
//    }
//}
