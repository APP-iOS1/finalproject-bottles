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
            RoundedRectangle(cornerRadius: 5)
                .stroke(.black)
                .frame(width: 150, height: 150)
                .overlay {
                    Image("oakDrum_Image")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 140, height: 140)
                }
                .padding()
    
            VStack(alignment: .leading, spacing: 10) {
                Text("와인앤모어")
                    .font(.title)
                Text("바틀샵 소개")
                Text("위스키 럼 꼬냑")
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
    }
}

struct SearchShopList_Previews: PreviewProvider {
    static var previews: some View {
        SearchShopList()
    }
}
