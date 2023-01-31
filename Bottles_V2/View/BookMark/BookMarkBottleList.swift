//
//  BookMarkBottleList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct BookMarkBottleList: View {
    // ActionSheet (iOS 14 이하 - ActionSheet, iOS 15 이상 - confirmationDialog 사용해야함)
    @State private var showingActionSheet: Bool = false
    @State private var selection = "기본순"
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                // 정렬 기준 선택 버튼
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
                .padding(.trailing, 20)
            }
            // TODO: ForEach로 BookMarkBottleListCell에 Bottle 데이터 넘겨줘야함, Bottle DetailView로 이동하는 NavigationLink 추가해야함
            ScrollView {
                BookMarkBottleListCell()
                BookMarkBottleListCell()
                BookMarkBottleListCell()
            }
        }
        // MARK: - 정렬 ActionSheet
        .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
            // TODO: 각 버튼 별로 정렬 액션 추가해야함
            Button {
                selection = "기본순"
            } label: {
                Text("기본순")
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

struct BookMarkBottleListCell: View {
    var body: some View {
        HStack(alignment: .top) {
            // Bottle 이미지
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black)
                .frame(width: 120, height: 120)
                .overlay {
                    AsyncImage(url: URL(string: "https://kanashop.kr/web/product/big/201903/97ef5cee30f4cd6072fd736831623d2e.jpg")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 115, height: 115)
                    } placeholder: {
                        Image("ready_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 115, height: 115)
                    }
                }
                .padding(.horizontal)
    
            VStack(alignment: .leading, spacing: 10) {
                // Bottle 이름
                Text("킬호만 샤닉")
                    .font(.title3)
                // Bottle 가격
                Text("350,000원")
                // 해당 Bottle을 판매하는 Shop으로 이동하는 버튼
                NavigationLink {
                    BottleShopView()
                } label: {
                    HStack {
                        Image("MapMarker")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        // Shop 이름
                        Text("와인앤모어")
                    }
                }
            }
            .bold()
            .padding(.vertical)
            
            Spacer()
            VStack {
                // TODO: 즐겨찾기 기능 추가해야함
                Button {
                    
                } label: {
                    Image(systemName: "bookmark.fill")
                }
                Spacer()
                // TODO: 장바구니 기능 추가해야함
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
