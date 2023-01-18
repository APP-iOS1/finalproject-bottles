//
//  BookMarkShopList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct BookMarkShopList: View {
    // filter
    @State private var filterType: String = "최신 순"
    
    var body: some View {
        VStack {
            // MARK: - 정렬 Menu
            HStack {
                Menu {
                    Button("최신 순", action: {
                        filterType = "최신 순"
                    })
                    Button("낮은 가격 순", action: {
                        filterType = "낮은 가격 순"
                    })
                    Button("높은 가격 순", action: {
                        filterType = "높은 가격 순"
                    })
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.accentColor)
                        .frame(width: 140, height: 35)
                        .overlay {
                            HStack {
                                Text(filterType)
                                    .frame(width: 90)
                                    .bold()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.accentColor)
                            }
                        }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                Spacer()
            }
            ScrollView {
                NavigationLink {
                    BottleShopView()
                } label: {
                    BookMarkShopListCell()
                }
                NavigationLink {
                    BottleShopView()
                } label: {
                    BookMarkShopListCell()
                }
                NavigationLink {
                    BottleShopView()
                } label: {
                    BookMarkShopListCell()
                }
            }
        }
    }
}

struct BookMarkShopListCell: View {
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
    }
}

struct BookMarkShopList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookMarkShopList()
        }
    }
}
