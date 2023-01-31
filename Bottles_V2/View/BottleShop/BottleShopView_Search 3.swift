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
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                NavigationLink(destination: BottleShopCurationView()){
                    HStack{
                        Text("연말 파티에 어울리는 스파클링 와인들")
                        Image(systemName: "chevron.right")
                            .padding(.leading, -5)
                        Spacer()
                    }
                    .fontWeight(.bold)
//                    .padding(.horizontal)
                }
                Text("다가오는 연말, 친구 / 연인 / 가족과 함께 \n부담없이 마시기 좋은 스파클링 와인을 추천합니다. \n어떤 음식과 페어링해도 평타 이상일 거예요!")
                    .padding(.top, 1)
            }
            .font(.system(size: 15))
            .foregroundColor(.black)
            .padding()
            .frame(height: 150)
            .background(Color(.systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.7)
            )
            .padding(.bottom)
            
            HStack {
                TextField("이 바틀샵의 상품을 검색해보세요", text: $text)
                    .font(.system(size: 15))
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
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
            
                Picker("Sort", selection: $selectedSort) {
                    Text("기본순").tag(Sort.automatic)
                    Text("인기순").tag(Sort.popularity)
                    Text("가격내림차순").tag(Sort.priceDown)
                    Text("가격오름차순").tag(Sort.priceUp)
                }
                .pickerStyle(.automatic)
            
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
