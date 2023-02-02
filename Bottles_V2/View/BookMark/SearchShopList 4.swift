//
//  SearchShopList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchShopList: View {
    // filter
    @State private var filterType: String = "최신 순"
    
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink {
                    
                } label: {
                    SearchShopListCell()
                }
                SearchShopListCell()
                SearchShopListCell()
            }
        }
    }
}

struct SearchShopListCell: View {
    var body: some View {
        HStack {
                    Image("bottleShop")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .cornerRadius(10)
                         .frame(width: 120, height: 120)
                         .padding(.horizontal)
    
            VStack(alignment: .leading, spacing: 10) {
                Text("와인앤모어")
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

struct SearchShopList_Previews: PreviewProvider {
    static var previews: some View {
        SearchShopList()
    }
}
