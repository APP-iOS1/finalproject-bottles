//
//  SearchBottleList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchBottleList: View {
    // 검색어를 저장하는 변수
    var bottleName: String
    // 테스트용 모델
    @StateObject var bookMarkTestStore: BookMarkTestStore = BookMarkTestStore()
    // 검색 결과를 필터링해주는 연산 프로퍼티
    var filteredResult: [BookMarkBottle] {
        let bottles = bookMarkTestStore.BookMarkBottles
        return bottles.filter {
            $0.bottleName.contains(bottleName)
        }
    }
    
    var body: some View {
        VStack {
            // 검색어를 포함하는 Data가 없을 경우
            if filteredResult == [] {
                Text("검색 결과가 없습니다.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                Spacer()
            } else {
                // TODO: Bottle DetailView로 이동하는 NavigationLink 추가해야함
                ScrollView {
                    ForEach(filteredResult, id: \.self) { bottle in
                        SearchBottleListCell(bottleInfo: bottle)
                    }
                }
            }
        }
    }
}

struct SearchBottleListCell: View {
    // 필터링된 Bottle의 정보를 저장하는 변수
    var bottleInfo: BookMarkBottle
    
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
                Text(bottleInfo.bottleName)
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
            }
            .font(.title2)
            .padding()
        }
        .frame(height: 130)
        .padding(.vertical, 5)
    }
}

//struct SearchBottleList_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SearchBottleList()
//        }
//    }
//}
