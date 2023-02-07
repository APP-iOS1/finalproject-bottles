//
//  SearchShopList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

struct SearchShopList: View {
    // 검색어를 저장하는 변수
    var shopName: String
    // 테스트용 모델
    @StateObject var bookMarkTestStore: BookMarkTestStore = BookMarkTestStore()
    // ActionSheet
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
    // 검색 결과를 필터링해주는 연산 프로퍼티
    var filteredResult: [BookMarkShop] {
        let bottles = bookMarkTestStore.BookMarkShops
        return bottles.filter {
            $0.shopName.contains(shopName)
        }
    }
    
    // Test
    func sortShopData() -> [BookMarkShop] {
        let searchedShops: [BookMarkShop] = bookMarkTestStore.BookMarkShops
        switch selection {
        case "거리순":
            return searchedShops.sorted(by: {$0.shopName < $1.shopName}).sorted(by: {$0.distance < $1.distance})
        default:
            return searchedShops.sorted(by: {$0.shopName < $1.shopName})
        }
    }
    
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
                            .font(.bottles14)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.black)
                }
                .padding(.trailing, 20)
            }
            // 검색어를 포함하는 Data가 없을 경우
            if filteredResult == [] {
                Text("검색 결과가 없습니다.")
                    .font(.bottles14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                Spacer()
            } else {
                // TODO: 서버 Shop 데이터 연결
                ScrollView {
                    ForEach(sortShopData(), id: \.self) { shop in
                        NavigationLink {
//                            BottleShopView(bottleShop: <#ShopModel#>)
                        } label: {
                            SearchShopListCell(shopInfo: shop)
                        }
                    }
                }
            }
        }
        // MARK: - 정렬 ActionSheet
        .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
            // TODO: 각 버튼 별로 정렬 액션 추가해야함
            Button("이름순") {
                selection = "이름순"
            }
            Button("거리순") {
                selection = "거리순"
            }
        }
    }
}

struct SearchShopListCell: View {
    // 필터링된 Shop의 정보를 저장하는 변수
    var shopInfo: BookMarkShop
    
    var body: some View {
        HStack(alignment: .top) {
            // Shop 이미지
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black)
                .frame(width: 120, height: 120)
                .overlay {
                    AsyncImage(url: URL(string: "https://wine21.speedgabia.com/NEWS_MST/froala/202007/20200716101122567972.jpg")) { image in
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
    
            VStack(alignment: .leading, spacing: 10) {
                // Shop 이름
                Text(shopInfo.shopName)
                    .font(.bottles18)
                    .bold()
                // Shop 소개글
                Text("바틀샵 소개 가나다라마 아자차 마바사가다")
                    .font(.bottles14)
                Spacer()
            }
            .foregroundColor(.black)
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

//struct SearchShopList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchShopList()
//    }
//}
