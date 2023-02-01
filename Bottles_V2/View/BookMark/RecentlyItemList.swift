//
//  RecentlyItemList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/20.
//

import SwiftUI

struct RecentlyItemList: View {
    @EnvironmentObject var userDataStore: UserDataStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    
    var recentSearches: [String] = ["와인", "와인앤모어", "위스키", "선물", "킬호만"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("최근 검색어")
                .font(.bottles18)
                .bold()
                .padding(.leading, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(recentSearches, id: \.self) { search in
                        Button  {
                            
                        } label: {
                            Text(search)
                                .padding(12)
                                .background(RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 1))
                                .padding(.vertical)
                                .padding(.leading, 5)
                        }
                    }
                }
            }
            .padding(.leading, 10)
            Text("최근 본 상품")
                .font(.bottles18)
                .bold()
                .padding(.leading, 15)
            ScrollView {
                ForEach(userDataStore.user?.recentlyBottles ?? [] , id: \.self) { item in
                    Text(item ?? "없어")
                }
            }
        }
        .task{
            // TODO: 더미데이터 수정하기
            
        }
    }
}

struct RecentlyItemListCell: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("whisky_Image1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(width: 120, height: 120)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("킬호만 샤닉")
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
                Button {
                    
                } label: {
                    Image(systemName: "cart.badge.plus")
                }
            }
            .font(.title2)
            .padding()
        }
        .frame(height: 130)
        .padding(.vertical, 5)
    }
}

struct RecentlyItemList_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyItemList()
    }
}
