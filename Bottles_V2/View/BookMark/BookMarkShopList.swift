//
//  BookMarkShopList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct BookMarkShopList: View {
    @State private var showingActionSheet: Bool = false
    @State private var selection = "기본순"
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showingActionSheet = true
                } label: {
                    HStack {
                        Text("\(selection)")
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.black)
                }
                .padding(.leading, 20)
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
        .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
            Button("기본순") {
                selection = "기본순"
            }
            
            Button("신상품순") {
                selection = "신상품순"
            }
            
            Button("낮은 가격순") {
                selection = "낮은 가격순"
            }
            
            Button("높은 가격순") {
                selection = "높은 가격순"
            }
        }
    }
}

struct BookMarkShopListCell: View {
    var body: some View {
        HStack {
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(.black)
//                .frame(width: 150, height: 150)
//                .overlay {
                    Image("bottleShop")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .cornerRadius(10)
                         .frame(width: 120, height: 120)
                         .padding(.horizontal)
//                }
//                .padding()
    
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

struct BookMarkShopList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookMarkShopList()
        }
    }
}
