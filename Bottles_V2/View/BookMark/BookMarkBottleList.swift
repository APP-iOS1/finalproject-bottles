//
//  BookMarkBottleList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct BookMarkBottleList: View {
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
                BookMarkBottleListCell()
                BookMarkBottleListCell()
                BookMarkBottleListCell()
            }
        }
    }
}

struct BookMarkBottleListCell: View {
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
                Button {
                    
                } label: {
                    Image(systemName: "cart.badge.plus")
                }
            }
            .font(.title2)
            .padding()
        }
    }
}

struct BookMarkBottleList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookMarkBottleList()
        }
    }
}

// AsyncImage 사용
/*
 RoundedRectangle(cornerRadius: 5)
     .stroke(.black)
     .frame(width: 150, height: 150)
     .overlay {
         AsyncImage(url: URL(string: "https://kanashop.kr/web/product/big/201903/97ef5cee30f4cd6072fd736831623d2e.jpg")) { image in
             image
                 .resizable()
                 .aspectRatio(contentMode: .fit)
         } placeholder: {
             Image("ready_image")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
         }
     }
     .padding()
 */
