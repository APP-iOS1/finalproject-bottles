//
//  BottleShopCurationView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct BottleShopCurationView: View {
    @State private var selectedSort = Sort.automatic
    @State private var showingActionSheet: Bool = false
    @State private var selection = "기본순"
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 370, height: 370)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0.7)
                        )
                    
                    VStack{
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            
                            Text("연말 파티에 어울리는 스파클링 와인들")
                                .font(.bottles18)
                                .fontWeight(.semibold)
                            Text("다가오는 연말, 친구 / 연인 / 가족과 함께 \n부담없이 마시기 좋은 스파클링 와인을 추천합니다. \n어떤 음식과 페어링해도 평타 이상일 거예요!")
                                .padding(.top, 1)
                                .font(.bottles14)
                        }
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .padding(.trailing)
                        .padding(.bottom)
                        .padding(.leading, -10)
                    }
                }
                
                VStack(alignment: .leading){
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
            }
            .padding()
            .navigationBarTitle("바틀샵 이름")
        }
    }
}

struct BottleShopCurationView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopCurationView()
    }
}
