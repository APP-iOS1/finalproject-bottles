//
//  RecentlyItemList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/20.
//

import SwiftUI

struct RecentlyItemList: View {
    // 테스트용 최근 검색어 배열
    var recentSearches: [String] = ["와인", "와인앤모어", "위스키", "선물", "킬호만"]
    // 검색바에 입력된 Text
    @Binding var searchBarText: String
    // 검색을 완료했는지 판단하는 Bool 값
    @Binding var doneTextFieldEdit: Bool
    // 검색 TextField 작성 완료시 키보드를 내리기위한 Bool 값
    @FocusState var focus: Bool
    // 테스트용 모델
    @StateObject var bookMarkTestStore: BookMarkTestStore = BookMarkTestStore()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {            
            Text("최근 검색어")
                .font(.bottles18)
                .bold()
                .padding([.leading, .top], 15)
            
            // 최근 검색어 나열
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(recentSearches, id: \.self) { search in
                        // 최근 검색어를 누르면 해당 검색어로 검색이 진행된다
                        Button  {
                            searchBarText = search
                            doneTextFieldEdit = true
                            focus = false
                        } label: {
                            Text(search)
                                .font(.bottles16)
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
            // TODO: 서버 최근 본 상품(Bottle) 데이터 연결
            ScrollView {
                ForEach(bookMarkTestStore.BookMarkBottles, id: \.self) { bottle in
                    RecentlyItemListCell(bottleInfo: bottle)
                }
            }
        }
    }
}

struct RecentlyItemListCell: View {
    // Bottle의 정보를 저장하는 변수
    var bottleInfo: BookMarkBottle
    
    var body: some View {
        HStack(alignment: .top) {
            // 이미지를 누르면 Bottle Detail View로 이동
            NavigationLink {
                BottleView()
            } label: {
                // Bottle 이미지
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black)
                    .frame(width: 120, height: 120)
                    .overlay {
                        AsyncImage(url: URL(string: "https://kanashop.kr/web/product/big/201903/97ef5cee30f4cd6072fd736831623d2e.jpg")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                        } placeholder: {
                            Image("ready_image")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
            }
            
            
            VStack(alignment: .leading, spacing: 10) {
                // Bottle 이름
                Text(bottleInfo.bottleName)
                    .font(.bottles14)
                // Bottle 가격
                Text("350,000원")
                    .font(.bottles18)
                    .bold()
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
                        Text(bottleInfo.shopName)
                            .font(.bottles14)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            .padding(.top, 5)
            
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
            .padding(.top, -5)
        }
        .frame(height: 130)
        .padding(.vertical, 5)
    }
}

//struct RecentlyItemList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentlyItemList()
//    }
//}
