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
    
    @Binding var text: String
    @State private var isEditing = false
    @State private var selectedSort = Sort.automatic
    @State private var showingActionSheet: Bool = false
    @State private var selection = "기본순"
    
    var body: some View {
        VStack(alignment: .leading){
            // 검색창
            VStack{
                HStack {
                    TextField("이 바틀샵의 상품을 검색해보세요", text: $text)
                        .font(.bottles16)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background{Color.gray_f7}
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                
                                if isEditing {
                                    Button(action: {
                                        self.text = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                    //                    .padding(.horizontal, 10)
                        .onTapGesture {
                            self.isEditing = true
                        }
                    
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.text = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                        }) {
                            Text("  종료  ")
                        }
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                .padding(.bottom, 10)
                
                // 검색뷰 수정시 살릴 것
                //            ForEach(bottleItems.filter({text.isEmpty ? false : $0.name.contains(text)}), id: \.self) { item in
                //                NavigationLink(destination: BottleView(), label:{
                //                    BottleShopView_BottleList(selectedItem: BottleItem22(name: item.name, price: item.price, category: item.category, tag: item.tag, use: item.use))
                //                })
                //            }
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
                .padding(.leading, 20)
                .padding(.bottom, -10)
            }
            
            // MARK: - 정렬 ActionSheet
            .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
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
            
            // 검색 결과에 따라 정렬함(검색하지 않는 경우 모든 바틀 보여주고, 검색 텍스트 입력시 텍스트가 포함되어있는 해당 바틀만 보여줌)
            // 데이터 연동 시 "해당 샵의 바틀 리스트" 연동
            // 바틀 셀 반복문
            ForEach(bottleItems.filter({text.isEmpty ? true : $0.name.contains(text)}), id: \.self) { item in
                
                // 바틀셀 누를 시 바틀뷰로 이동
                NavigationLink(destination: BottleView(), label:{
                    BottleShopView_BottleList(selectedItem: BottleItem22(name: item.name, price: item.price, category: item.category, tag: item.tag, use: item.use))
                })
            }
            
        }
        .padding()
    }
}

struct BottleShopView_Search_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopView_Search(text: .constant(""))
    }
}
