//
//  SearchBottleList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchBottleList: View {
    // filter
    @State private var filterType: String = "최신 순"
    
    var body: some View {
        VStack {
            ScrollView {
                SearchBottleListCell()
                SearchBottleListCell()
                SearchBottleListCell()
            }
        }
    }
}

struct SearchBottleListCell: View {
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.black)
                .frame(width: 150, height: 150)
                .overlay {
                    Image("whisky_Image1")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 140, height: 140)
                }
                .padding()
    
            VStack(alignment: .leading, spacing: 10) {
                Text("킬호만 샤닉")
                    .font(.title3)
                Text("350,000원")
                NavigationLink {
                    
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
    }
}

struct SearchBottleList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchBottleList()
        }
    }
}
