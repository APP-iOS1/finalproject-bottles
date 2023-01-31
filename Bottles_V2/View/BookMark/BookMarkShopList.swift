//
//  BookMarkShopList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct BookMarkShopList: View {
    // ActionSheet
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
            // TODO: ForEach로 BookMarkShopListCell에 Shop 데이터 넘겨줘야함
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
        // MARK: - 정렬 ActionSheet
        .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
            // TODO: 각 버튼 별로 정렬 액션 추가해야함
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
            // Shop 이미지
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black)
                .frame(width: 120, height: 120)
                .overlay {
                    AsyncImage(url: URL(string: "https://wine21.speedgabia.com/NEWS_MST/froala/202007/20200716101122567972.jpg")) { image in
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
                // Shop 이름
                Text("와인앤모어")
                    .font(.title)
                // Shop 소개글
                Text("바틀샵 소개 가나다라마 아자차 마바사가다")
                    .font(.footnote)
            }
            .foregroundColor(.black)
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
