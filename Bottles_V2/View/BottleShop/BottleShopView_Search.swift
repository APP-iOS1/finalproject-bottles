//
//  BottleShopView_Search.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 정렬 기본순, 낮은 가격순, 높은 가격순, 신상품순
enum Sort: String, CaseIterable, Identifiable {
    case automatic, priceDown, priceUp, popularity
    var id: Self { self }
}

// 바틀샵뷰 내 "상품 검색" 뷰
struct BottleShopView_Search: View {
    
    @State private var isEditing: Bool = false
    @State private var selectedSort = Sort.automatic
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
    
    @Binding var search: Bool
    @FocusState var focus: Bool
    @Binding var isNavigationBarHidden: Bool
    
    @EnvironmentObject var bottleDataStore: BottleDataStore
    
    var bottleShop: ShopModel
    
    var sortedBottleData: [BottleModel] {
        let bottleItems: [BottleModel] = bottleDataStore.bottleData
        return bottleItems.sorted(by: {$0.itemName < $1.itemName})
    }
    
    func sortBottleData() -> [BottleModel] {
        let bottleItems: [BottleModel] = bottleDataStore.bottleData
        let test = bottleItems.filter{ $0.shopID == bottleShop.id }
        
        switch selection {
        case "낮은 가격순":
            return test.sorted(by: {$0.shopName < $1.shopName}).sorted(by: {$0.itemPrice < $1.itemPrice})
        case "높은 가격순":
            return test.sorted(by: {$0.shopName < $1.shopName}).sorted(by: {$0.itemPrice > $1.itemPrice})
        default:
            return test.sorted(by: {$0.shopName < $1.shopName})
        }
    }
    
    
    var body: some View {
        VStack(){
            // 검색창 버튼
            Button {
                search = true
                focus = true
                isNavigationBarHidden = true
            } label: {
                ZStack{
                    
                    Rectangle()
                        .frame(width: 358)
                        .foregroundColor(Color.gray_f7)
                        .cornerRadius(12)
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                            .padding(.leading, 8)
                        
                        Text("이 바틀샵의 상품 검색")
                            .font(.bottles16)
                            .foregroundColor(.gray)
                            .padding(.leading, -8)
                            .padding(7)
                        
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 10)
            }
            
            // 바틀 정렬 버튼
            HStack {
                Spacer()
                
                Button {
                    showingActionSheet = true
                } label: {
                    HStack {
                        Text("\(selection)")
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                    }
                    .font(.bottles14)
                    .foregroundColor(.black)
                }
                .padding(.leading, 22)
                .padding(.bottom, -10)
            }
            
            // MARK: - 정렬 ActionSheet
            .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
                Button {
                    selection = "이름순"
                } label: {
                    Text("이름순")
                }
                
                Button("낮은 가격순") {
                    selection = "낮은 가격순"
                }
                
                Button("높은 가격순") {
                    selection = "높은 가격순"
                }
            }
            
            if sortBottleData().count == 0 {
                VStack{
                    Spacer()
                        .frame(height: 100)
                    
                    Image(systemName: "wineglass")
                        .font(.system(size: 50))
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("상품 준비 중이에요!")
                        .font(.bottles18)
                        .fontWeight(.semibold)
                    
                    Spacer()
                        .frame(height: 100)
                }
                .foregroundColor(.gray)
                
            } else {
                // 검색 결과에 따라 정렬함(검색하지 않는 경우 모든 바틀 보여주고, 검색 텍스트 입력시 텍스트가 포함되어있는 해당 바틀만 보여줌)
                // 데이터 연동 시 "해당 샵의 바틀 리스트" 연동
                // 바틀 셀(정렬 후) 반복문
                ForEach(sortBottleData(), id: \.self) { item in
                    // 바틀셀 누를 시 바틀뷰로 이동
                    NavigationLink(destination: BottleView(bottleData: item), label:{
                        BottleShopView_BottleList(selectedItem: item)
                    })
                }
            }
        }
        .padding()
    }
}

//struct BottleShopView_Search_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopView_Search(text: <#Binding<String>#>, search: <#Binding<Bool>#>, isNavigationBarHidden: <#Binding<Bool>#>)
//    }
//}
