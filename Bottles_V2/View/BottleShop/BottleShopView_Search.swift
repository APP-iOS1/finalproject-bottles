//
//  BottleShopView_Search.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

enum Sort: String, CaseIterable, Identifiable {
    case automatic, priceDown, priceUp, popularity
    var id: Self { self }
}

struct BottleShopView_Search: View {
    
    @Binding var text: String
    @State private var isEditing = false
    @State private var selectedSort = Sort.automatic
    @State private var showingActionSheet: Bool = false
    @State private var selection = "기본순"
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading){
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
            
            ForEach(bottleItems, id: \.self) { item in
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
