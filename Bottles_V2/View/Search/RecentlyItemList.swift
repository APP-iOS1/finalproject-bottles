//
//  RecentlyItemList.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/20.
//

import SwiftUI

struct RecentlyItemList: View {
    // 검색바에 입력된 Text
    @Binding var searchBarText: String
    // 검색을 완료했는지 판단하는 Bool 값
    @Binding var doneTextFieldEdit: Bool
    // 검색 TextField 작성 완료시 키보드를 내리기위한 Bool 값
    @FocusState var focus: Bool
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var shopDataStore: ShopDataStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    // coreData
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var searchHistory: FetchedResults<SearchHistory>
    // 북마크 알림
    @State var bookMarkAlarm: Bool = false
    @State var bookMark: Bool = false
    
    @Binding var root: Bool
    
//    func getMatchedShopData(bottleData: BottleModel) -> ShopModel {
//        let matchedShopData = shopDataStore.shopData.filter {$0.id == bottleData.shopID}
//        return matchedShopData[0]
//    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    if !searchHistory.isEmpty {
                        Text("최근 검색어")
                            .font(.bottles18)
                            .bold()
                            .padding([.leading, .top], 15)
                        
                        // 최근 검색어 나열
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(searchHistory, id: \.self) { search in
                                    HStack {
                                        // 최근 검색어를 누르면 해당 검색어로 검색이 진행된다
                                        Button  {
                                            searchBarText = search.text!
                                            doneTextFieldEdit = true
                                            focus = false
                                            searchAgain(search: search)
                                        } label: {
                                            Text(search.text!)
                                        }
                                        
                                        Button {
                                            if let index = searchHistory.firstIndex(of: search) {
                                                deleteSearchHistory(offsets: IndexSet(integer: index))
                                            }
                                        } label: {
                                            Image(systemName: "xmark")
                                        }
                                    }
                                    .font(.bottles16)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .background(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                                    .padding(.top, 8)
                                    .padding(.bottom, 10)
                                    .padding(.leading, 5)
                                }
                                
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.bottom, -5)
                    }
                    
                    Text("최근 본 상품")
                        .font(.bottles18)
                        .bold()
                        .padding([.leading, .top], 15)
                    
                    if userStore.user.recentlyItem.isEmpty {
                        VStack{
                            Spacer()
                                .frame(height: 100)
                            
                            Image(systemName: "wineglass")
                                .font(.system(size: 50))
                            
                            Spacer()
                                .frame(height: 20)
                            
                            Text("최근 본 상품이 없습니다.")
                                .font(.bottles18)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    } else {
                        //                    ScrollView {
                        ForEach(filterRecentlyBottle(), id: \.self) { bottle in
                            RecentlyItemListCell(
                                bottleInfo: bottle,
                                shopInfo: shopDataStore.getMatchedShopData(bottleData: bottle),
                                bookMark: $bookMark, bookMarkAlarm: $bookMarkAlarm, root: $root)
                            Divider()
                                .padding(.horizontal, 10)
                        }
                        //                    }
                    }
                }
            }
            if bookMarkAlarm {
                HStack{
                    Image(bookMark ? "BookMark.fill" : "BookMark")
                    Text(bookMark ? "북마크가 완료되었습니다." : "북마크가 해제되었습니다.")
                        .foregroundColor(.black)
                        .font(.bottles11)
                }
                .zIndex(1)
                .transition(.opacity.animation(.easeIn))
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 30)
                        .foregroundColor(.gray_f7)
                }
                .offset(y: (UIScreen.main.bounds.height/4))
            }
        }
        .onTapGesture {
            endTextEditing()
        }
    }
    
    func filterRecentlyBottle() -> [BottleModel] {
        var resultData: [BottleModel] = []
        for (index, item) in userStore.user.recentlyItem.enumerated() {
            print("최근 본 상품 \(item)")
            let filter = bottleDataStore.bottleData.filter { $0.id == item }
            if index < 21 {
                resultData.append(contentsOf: filter)
            }
        }
        
        return resultData.reversed()
    }
    
    // 개별 삭제
    func deleteSearchHistory(offsets: IndexSet) {
        withAnimation(.default.speed(3)) {
            offsets.map { searchHistory[$0] }.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    func searchAgain(search: SearchHistory) {
        // 삭제하고 다시 새롭게 Add
        if let index = searchHistory.firstIndex(of: search) {
            deleteSearchHistory(offsets: IndexSet(integer: index))
        }
        DataController().addSearchHistory(text: searchBarText, context: managedObjContext)
    }
}

struct RecentlyItemListCell: View {
    // Bottle의 정보를 저장하는 변수
    @EnvironmentObject var userStore: UserStore
    var bottleInfo: BottleModel
    var shopInfo: ShopModel
    // 북마크 알림
    @Binding var bookMark: Bool
    @Binding var bookMarkAlarm: Bool
    
    @State var destination: Destination?
    @Binding var root: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            // 이미지를 누르면 Bottle Detail View로 이동
            Button(action: {
                destination = .bottle
                root.toggle()
            }) {
                // Bottle 이미지
                AsyncImage(url: URL(string: bottleInfo.itemImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128, height: 128)
                        .cornerRadius(12)
                } placeholder: {
                    Image("ready_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128, height: 128)
                        .cornerRadius(12)
                }
                .background(Color.gray_f7)
                .cornerRadius(12)
                .frame(height: 128)
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                // Bottle 이름
                Text(bottleInfo.itemName)
                    .font(.bottles14)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                // Bottle 가격
                Text("\(bottleInfo.itemPrice)원")
                    .font(.bottles18)
                    .bold()
                // 해당 Bottle을 판매하는 Shop으로 이동하는 버튼
                Button(action: {
                    destination = .bottleShop
                    root.toggle()
                }) {
                    HStack {
                        Image("Map_tab_fill")
                            .resizable()
                            .frame(width: 14, height: 17)
                        // Shop 이름
                        Text(bottleInfo.shopName)
                            .font(.bottles14)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                }
                Spacer()
            }
            .padding(.top, 5)
            
            Spacer()
            VStack {
                Button(action: {
                    withAnimation(.easeIn(duration: 1)) {
                        bookMark.toggle()
                        bookMarkAlarm.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        withAnimation(.easeIn(duration: 1)) {
                            bookMarkAlarm.toggle()
                        }
                    }
                    
                    if compareMyFollowBottleID(bottleInfo.id) == true {
                        bookMark = false
                        userStore.deleteFollowItemId(bottleInfo.id)
                    }

                    if compareMyFollowBottleID(bottleInfo.id) == false {
                        bookMark = true
                        userStore.addFollowItemId(bottleInfo.id)
                    }
                    
                }) {
                    Image(compareMyFollowBottleID(bottleInfo.id) ? "BookMark.fill" : "BookMark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 18)
                        .padding(.horizontal, 10)
                }
                Spacer()
            }
            .font(.title2)
            .padding()
            .padding(.top, -5)
        }
        .frame(minHeight: 130, maxHeight: 300)
        .padding(.vertical, 5)
        .navigationDestination(isPresented: $root) {
            switch self.destination {
            case .bottle:
                BottleView(bottleData: bottleInfo)
            case .bottleShop:
                BottleShopView(bottleShop: shopInfo)
            default:
                EmptyView()
            }
        }
    }
    
    func compareMyFollowBottleID(_ bottleId: String) -> Bool {
        return (userStore.user.followItemList.filter { $0 == bottleId }.count != 0) ? true : false
    }
}

//struct RecentlyItemList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentlyItemList()
//    }
//}
