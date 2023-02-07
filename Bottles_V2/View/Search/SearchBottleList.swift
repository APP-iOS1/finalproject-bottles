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
    // ActionSheet
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
    // 검색 결과를 필터링해주는 연산 프로퍼티
    var filteredResult: [BookMarkBottle] {
        let bottles = bookMarkTestStore.BookMarkBottles
        return bottles.filter {
            $0.bottleName.contains(bottleName)
        }
    }
    //Test
    func sortBottleData() -> [BookMarkBottle] {
        let searchedBottles: [BookMarkBottle] = filteredResult
        switch selection {
        case "거리순":
            return searchedBottles.sorted(by: {$0.bottleName < $1.bottleName}).sorted(by: {$0.distance < $1.distance})
        case "낮은 가격순":
            return searchedBottles.sorted(by: {$0.bottleName < $1.bottleName}).sorted(by: {$0.price < $1.price})
        case "높은 가격순":
            return searchedBottles.sorted(by: {$0.bottleName < $1.bottleName}).sorted(by: {$0.price > $1.price})
        default:
            return searchedBottles.sorted(by: {$0.bottleName < $1.bottleName})
        }
    }
    @State var bookMarkAlarm: Bool = false
    @State var bookMark: Bool = false
    
    var body: some View {
        ZStack {
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
                    // TODO: 서버 Bottle 데이터 연결
                    ScrollView {
                        ForEach(sortBottleData(), id: \.self) { bottle in
                            SearchBottleListCell(bottleInfo: bottle, bookMark: $bookMark, bookMarkAlarm: $bookMarkAlarm)
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
                
                Button("낮은 가격순") {
                    selection = "낮은 가격순"
                }
                
                Button("높은 가격순") {
                    selection = "높은 가격순"
                }
            }
            
            if bookMarkAlarm {
                Text(bookMark ? "즐겨찾기에 추가되었습니다." : "즐겨찾기에서 해제되었습니다.")
                    .foregroundColor(.white)
                    .font(.caption)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 30)
                            .opacity(0.5)
                    }
                    .offset(y: 200)
                    .zIndex(1)
            }
        }
    }
}

struct SearchBottleListCell: View {
    // 필터링된 Bottle의 정보를 저장하는 변수
    var bottleInfo: BookMarkBottle
    
    // Test
    @Binding var bookMark: Bool
    @Binding var bookMarkAlarm: Bool
    
    var body: some View {
        HStack(alignment: .top) {
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
                    Text("가격 : \(bottleInfo.price)")
                        .font(.bottles18)
                        .bold()
                    // Test
                    Text("거리 : \(bottleInfo.distance)")
                        .font(.bottles14)
                    // 해당 Bottle을 판매하는 Shop으로 이동하는 버튼
                    NavigationLink {
//                        BottleShopView(bottleShop: <#ShopModel#>)
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
                        
                        withAnimation(.easeIn(duration: 1)) {
                            bookMark.toggle()
                            bookMarkAlarm.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            withAnimation(.easeIn(duration: 1)) {
                                bookMarkAlarm.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: bookMark ? "bookmark.fill" : "bookmark")
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
