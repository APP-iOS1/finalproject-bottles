//
//  SearchShopList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchShopList: View {
    var shopName: String
    
    @StateObject var bookMarkTestStore: BookMarkTestStore = BookMarkTestStore()
    
    var filteredResult: [BookMarkShop] {
        let bottles = bookMarkTestStore.BookMarkShops
        return bottles.filter {
            $0.shopName.contains(shopName)
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
                    ForEach(filteredResult, id: \.self) { shop in
                        NavigationLink {
                            BottleShopView()
                        } label: {
                            SearchShopListCell(shopInfo: shop)
                        }
                    }
                }
            }
        }
    }
}

struct SearchShopListCell: View {
    var shopInfo: BookMarkShop
    
    var body: some View {
        HStack {
                    Image("bottleShop")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .cornerRadius(10)
                         .frame(width: 120, height: 120)
                         .padding(.horizontal)
    
            VStack(alignment: .leading, spacing: 10) {
                Text(shopInfo.shopName)
                    .font(.title)
                Text("바틀샵 소개 가나다라마 아자차 마바사가다")
                    .font(.footnote)
            }
            .foregroundColor(.black)
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

//struct SearchShopList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchShopList()
//    }
//}
